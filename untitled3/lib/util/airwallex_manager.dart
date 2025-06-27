import 'package:airwallex_payment_flutter/airwallex.dart';
import 'package:airwallex_payment_flutter/types/environment.dart';
import 'package:airwallex_payment_flutter/types/payment_result.dart';
import 'package:airwallex_payment_flutter/types/payment_session.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/api/ApiService.dart';
import 'package:untitled3/api/api_client.dart';
import 'package:untitled3/api/payment_repository.dart';
import 'package:untitled3/types/payment_result_extend.dart';
import 'package:untitled3/util/card_creator.dart';
import 'package:untitled3/util/log_service.dart';
import 'package:untitled3/util/session_creator.dart';

class AirwallexManager {
  // 静态私有实例变量
  static final AirwallexManager _instance = AirwallexManager._internal();

  // 公开的静态获取实例的方法
  static AirwallexManager get instance => _instance;

  // 私有构造函数，防止外部实例化
  AirwallexManager._internal() {
    // 初始化操作
    _initAirwallex();
  }
  late Airwallex airwallex;

  String apiKey = 'bc735183b7eeb714a1b679507d7b0016c74563077dc40e6a71d4aa4125925fabe86fb77b1eb8f1502568f633652cc77a';
  String clientId = '_kxXlEflRVCG61JUqZpnDw';
  String? customerIdForTest = "";

  Environment environment = Environment.demo;
  late PaymentRepository paymentRepository;

  BillingMode billingMode = BillingMode.oneOff;

  // 标记是否已初始化
  bool _initialized = false;

  Future<void> _initAirwallex() async {
    if (_initialized) {
      return;
    }
    try {
      airwallex = Airwallex();
      await saveKeys(apiKey, clientId);
      await saveEnvironment(environment);
      Airwallex.initialize(environment: environment);
      final apiClient = ApiClient(environment: environment, apiKey: apiKey, clientId: clientId);
      paymentRepository = PaymentRepository(apiClient: apiClient);
      _initialized = true;
      Log.d('Airwallex SDK 初始化成功');
    } on PlatformException catch (e) {
      Log.d('Airwallex SDK 初始化失败：${e.toString()}');
    } on Exception catch (e) {
      Log.d('Airwallex SDK 初始化失败：${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> airwallexLogin() async {
    ApiService().init(
      baseUrl: 'https://api-demo.airwallex.com',
      headers: {
        // 'Host': 'api-demo.airwallex.com',
        "Accept": "application/json",
        'Content-Type': 'application/json',
      },
    );
    Map<String, dynamic> map = await ApiService().airwallexApiLogin(apiKey, clientId);
    return map;
  }

  Future saveEnvironment(Environment environment) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('environment', environment.name);
  }

  Future saveKeys(String apiKey, String clientId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('apiKey', apiKey);
    prefs.setString('clientId', clientId);
  }

  Future<PaymentResult> startPayment(int modeIndex, PaymentMethod paymentMethod,
      {String? customerId, Map<String, dynamic>? param}) async {
    if (_initialized == false) {
      await _initAirwallex();
    }
    param ??= {"merchant_order_id": "CB202506271124111"};

    PaymentResult paymentResult;
    switch (paymentMethod) {
      case PaymentMethod.entire:
        paymentResult = await presentEntirePaymentFlow(billingMode, customerId: customerId, param: param);
        break;
      case PaymentMethod.card:
        //todo test
        paymentResult = await presentCardPaymentFlow(billingMode, customerId: customerId, param: param);
        break;
      case PaymentMethod.cardDetails:
        paymentResult = await payWithCardDetails(billingMode, customerId: customerId, param: param);
        break;
      case PaymentMethod.applePay:
        paymentResult = await presentEntirePaymentFlow(billingMode, customerId: customerId, param: param);
        break;
      default:
        paymentResult = await presentCardPaymentFlow(billingMode, customerId: customerId, param: param);
    }
    return paymentResult;
  }

  //完整支付流程，包含多个支付方式
  Future<PaymentResultExtend> presentEntirePaymentFlow(BillingMode billingMode,
      {String? customerId, Map<String, dynamic>? param}) async {
    BaseSession baseSession = await _createSession(billingMode, customerId: customerId, param: param);
    PaymentResult paymentResult = await airwallex.presentEntirePaymentFlow(baseSession);
    String? paymentIntentId = "";
    if (baseSession is OneOffSession) {
      paymentIntentId = baseSession.paymentIntentId;
    } else if (baseSession is RecurringWithIntentSession) {
      paymentIntentId = baseSession.paymentIntentId;
    }
    PaymentResultExtend extend = PaymentResultExtend(paymentResult.status);
    extend.paymentIntentId = paymentIntentId;
    return extend;
  }

  //银行卡支付---单独拉起 银行卡支付流程，聚焦卡支付场景（输入卡号、有效期、CVV 等信息完成支付 ）。
  Future<PaymentResultExtend> presentCardPaymentFlow(BillingMode billingMode,
      {String? customerId, Map<String, dynamic>? param}) async {
    BaseSession baseSession = await _createSession(billingMode, customerId: customerId, param: param);

    PaymentResult paymentResult = await airwallex.presentCardPaymentFlow(baseSession);
    String? paymentIntentId = "";
    if (baseSession is OneOffSession) {
      paymentIntentId = baseSession.paymentIntentId;
    } else if (baseSession is RecurringWithIntentSession) {
      paymentIntentId = baseSession.paymentIntentId;
    }
    PaymentResultExtend extend = PaymentResultExtend(paymentResult.status);
    extend.paymentIntentId = paymentIntentId;
    return extend;
  }

  //payWithCardDetails + save
  //用预填 / 手动输入的银行卡信息直接发起支付,
  //save 复选框：勾选后会尝试保存银行卡信息（需用户授权、符合支付平台合规要求 ），方便后续快捷支付
  Future<PaymentResultExtend> payWithCardDetails(BillingMode billingMode,
      {String? customerId, Map<String, dynamic>? param}) async {
    BaseSession baseSession = await _createSession(billingMode, customerId: customerId, param: param);
    PaymentResult paymentResult = await airwallex.presentEntirePaymentFlow(baseSession);
    String? paymentIntentId = "";
    if (baseSession is OneOffSession) {
      paymentIntentId = baseSession.paymentIntentId;
    } else if (baseSession is RecurringWithIntentSession) {
      paymentIntentId = baseSession.paymentIntentId;
    }
    PaymentResultExtend extend = PaymentResultExtend(paymentResult.status);
    extend.paymentIntentId = paymentIntentId;
    return extend;
  }

  Future<Map<String, dynamic>> getPaymentIntents({Map<String, dynamic>? param}) async {
    Map<String, dynamic> map = await paymentRepository.getPaymentIntents(param: param);
    return map;
  }

  Future<BaseSession> _createSession(BillingMode mode, {Map<String, dynamic>? param, String? customerId}) async {
    switch (mode) {
      case BillingMode.oneOff:
        final paymentIntent =
            await paymentRepository.getPaymentIntentFromServer(param: param, force3DS: false, customerId: customerId);
        return SessionCreator.createOneOffSession(paymentIntent);
      case BillingMode.recurring:
        if (customerId == null || customerId == '') {
          customerId = await paymentRepository.getCustomerId();
        }

        customerIdForTest = customerId;
        final clientSecret = await paymentRepository.getClientSecret(customerId);
        Map<String, dynamic> sendParam = {};
        sendParam["amount"] = 1.00;
        sendParam["currency"] = "HKD";
        sendParam["countryCode"] = "HK";

        return SessionCreator.createRecurringSession(clientSecret, customerId, param ?? sendParam);
      default: //'recurring and payment':
        if (customerId == null || customerId == '') {
          customerId = await paymentRepository.getCustomerId();
        }
        customerIdForTest = customerId;

        final paymentIntent =
            await paymentRepository.getPaymentIntentFromServer(param: param, force3DS: false, customerId: customerId);
        return SessionCreator.createRecurringWithIntentSession(paymentIntent, customerId);
    }
  }

//MIT 模式
//首次授权后无需二次确认	依赖令牌化和风控	定期支付、小额高频 :【应用场景、预授权支付：酒店押金，定期缴费，订阅服务，公交乘车码】
// airwallex demo 是在one off 情况下使用，其他情况待验证
  Future<PaymentResult> payWithConsent(String customerId) async {
    BaseSession baseSession = await _createSession(BillingMode.oneOff);
    return airwallex.payWithConsent(
        baseSession, await paymentRepository.getPaymentConsents(customerId).then((consents) => consents.first));
  }

  Future<PaymentResult> _payWithCardDetails(BillingMode mode, bool saveCard, {String? customerId}) async {
    if (saveCard && customerId == null) {
      customerId = await paymentRepository.getCustomerId();
    }
    return airwallex.payWithCardDetails(await _createSession(mode), CardCreator.createDemoCard(environment), saveCard);
  }

  Future<Map<String, dynamic>> retrieveAPaymentIntent(String intentId) async {
    return await paymentRepository.retrieveAPaymentIntent(intentId);
  }

  Future<Map<String, dynamic>> createARefund(String intentId) async {
    return await paymentRepository.createARefund(intentId);
  }

  Future<Map<String, dynamic>> retrieveARefund(String refundId) async {
    return await paymentRepository.retrieveARefund(refundId);
  }

  destory() {
    _initialized = false;
  }
}

// 支付方式枚举
enum PaymentMethod {
  entire, //所有支付方式
  card, //银行卡支付
  cardDetails, // 银行卡预填信息支付
  applePay, // 苹果支付
  googlePay, //谷歌支付
}

//付款类型
enum BillingMode {
  oneOff, //单次支付
  recurring, // 周期支付或订阅 ，----- 绑卡模式
  recurringAndPayment, // 周期支付+ 额外单次支付-----绑卡并支付
}
