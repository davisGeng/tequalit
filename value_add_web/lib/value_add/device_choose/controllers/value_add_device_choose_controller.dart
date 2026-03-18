import 'dart:ui_web' as ui;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:value_add_web/api/value_add_api.dart';
import 'package:value_add_web/common/utils/js_utils.dart';
import 'package:value_add_web/common/widget/loadable_web_scaffold.dart';
import 'package:value_add_web/value_add/widget/pay_methods_dialog.dart';

import '../../../common/model/load_state.dart';
import '../../../common/widget/basic_snack.dart';
import '../../../model/check_device_available_by_plan_response.dart';
import '../../../model/value_add_create_order_response.dart';
import '../../../model/value_add_product_response.dart';
import '../../../common/controller/route_view_controller.dart';
import '../../../services/log_service.dart';

import 'dart:html' as html;

enum PayProgress { undo, success, fail, cancel }

class ValueAddDeviceChooseController extends RouteViewController with LoadableWebController {
  ValueAddDeviceChooseController(this.plans, this.prices);
  Plans plans;
  Prices prices;
  final RxList<DeviceAvailableResults> devices = <DeviceAvailableResults>[].obs;
  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: false,
  );
  int currentPage = 1;

  final int pageSize = 10;
  final selectIndex = (-1).obs;
  final payProgress = PayProgress.undo.obs;

  final doneBtnEnable = false.obs;

  ValueAddCreateOrderResponse? suborderResponse;

  bool openPaymentWeb = false;

  String userRegion = "";
  final loadState = LoadState.idle().obs;

  final isPaymentDialogShow = false.obs;

  late final WebParamsStore _paramsStore;
  final String iframeId = 'react-b-iframe';
  final isIframeLoading = true.obs;
  String paymentBaseUrl =
      // "http://localhost:3001";
      "http://0.0.0.0:3001";
  html.IFrameElement? _iframeElement;

  @override
  void onInit() {
    showLoadingWidget.value = true;
    super.onInit();
    _registerMessageListener();
  }

  @override
  void onAppear(bool isFirstAppear) {
    Log.d("goAirwallexAndPayOrder back onAppear :showWeb:$openPaymentWeb");

    super.onAppear(isFirstAppear);
  }

  @override
  void onDisAppear(bool isLastDisAppear, bool isHidden) {
    Log.d("goAirwallexAndPayOrder back onDisAppear");
    html.window.removeEventListener('message', _handleReactTSMessage);
    super.onDisAppear(isLastDisAppear, isHidden);
  }

  Future<void> refreshData() async {
    currentPage = 1;
    try {
      loadState.value = LoadState.loading();
      await _fetchData();
      // 等待一帧后再结束刷新状态，避免刷新动画卡住
      loadState.value = LoadState.success();
      await Future.microtask(() {
        Log.d("Refresh events over .device length:${devices.length}");
        refreshController.finishRefresh();
      });
    } catch (e) {
      loadState.value = LoadState.failure();
      refreshController.finishRefresh();
    }
  }

  Future<void> _fetchData() async {
    // await initService();
    final deviceMaps = JsUtils.instance.deviceMaps;

    if (deviceMaps.isNotEmpty) {
      final res = await ValueAddApi.instance.getValueAddAvailableDeviceByPlan(plans.planId ?? "", deviceMaps);
      Log.d("Refresh events over .device length:${devices.length}");
      if (res != null) {
        List<DeviceAvailableResults> results = res.results ?? [];
        devices.value = results;
      }
    }
    if (devices.isEmpty) {
      doneBtnEnable.value = false;
    } else {
      if (devices.length == 1) {
        if (devices[0].compatible) {
          updateSelectIndex(0);
        }
      }
    }
  }

  void updateSelectIndex(int index) {
    if (selectIndex.value == index) {
      selectIndex.value = -1;
      doneBtnEnable.value = false;
    } else {
      selectIndex.value = index;
      doneBtnEnable.value = true;
    }
  }

  Future choosePaymentMethodDialog(BuildContext context) async {
    await choosePaymentMethodAction(context, plans, (channelCode, isRepay) async {
      subOrder(context, channelCode, isRepay);
    });
  }

  Future choosePaymentMethodAction(
    BuildContext context,
    Plans plans,
    Function(String channelCode, bool isRepayOrder) onConformTap,
  ) async {
    // 初始化默认索引为0
    int checkIndex = 0;

    // 获取支付渠道列表（空安全处理保持不变）
    List<SupportedPaymentChannels> paymentChannels = plans.paymentConfig?.supportedPaymentChannels ?? [];

    if (paymentChannels.isNotEmpty) {
      // 用 indexWhere 直接找到第一个 isDefault 为 true 的索引
      // 若没有找到，返回 -1
      final defaultIndex = paymentChannels.indexWhere((channel) => channel.isDefault == true);
      // 若存在默认渠道，更新索引；否则保持默认0
      if (defaultIndex != -1) {
        checkIndex = defaultIndex;
      }
    }
    if (paymentChannels.isEmpty) {
      paymentChannels = [SupportedPaymentChannels(code: "airwallex", name: "信用卡", icon: "", isDefault: true)];
    }
    await Get.bottomSheet(
      PayMethodsDialog(
        platforms: paymentChannels,
        selectIndex: checkIndex,
        onTap: (v) async {
          // selectPayPlatform = paymentChannels[v];
          Get.back();
          // onConformTap.call(paymentChannels[v].code ?? "", false);
          //开始下单，然后支付
          await subOrder(context, paymentChannels[v].code, false);
        },
      ),
      isScrollControlled: true,
    );
  }

  // 下单
  Future subOrder(BuildContext context, String? channelCode, bool isRepayOrder) async {
    if (channelCode == null) {
      return;
    }

    startLoading();

    try {
      DeviceAvailableResults device = devices[selectIndex.value];
      if (!isRepayOrder) {
        suborderResponse = await ValueAddApi.instance.createOrder(
          deviceId: device.deviceId ?? "",
          paymentChannel: channelCode,
          priceId: prices.priceId ?? "",
          iccid: device.iccid ?? "",
        );
      }
    } catch (e) {
      stopLoading();
      Log.d("createOrder err:${e.toString()}");
    }
    stopLoading();
    try {
      if (suborderResponse == null) {
        BasicSnack.error("create_order_failed_err".tr);
        return;
      }

      _registerIframeView(
        suborderResponse?.intentId ?? "",
        suborderResponse?.clientSecret ?? "",
        suborderResponse?.currency ?? "",
      );
      // html.window.removeEventListener('message', _handleReactTSMessage);
      // _registerMessageListener();
    } catch (err) {
      Log.d("**subscripbeGoodsAction err:${err.toString()}");

      stopLoading();
      if (err is PlatformException) {
        Get.back(result: err.message);
      } else {
        await retryGetPayDetail();
      }
    } finally {
      stopLoading();
    }
  }

  Future retryGetPayDetail() async {
    if (suborderResponse == null) {
      return;
    }
    startLoading();

    await Future.delayed(Duration(seconds: 2));
  }

  void _registerIframeView(String intentId, String clientSecret, String currency) {
    // String finalurl = "$paymentBaseUrl?intent_id=$intentId&client_secret=$clientSecret&currency=$currency";
    ui.platformViewRegistry.registerViewFactory(iframeId, (int viewId) {
      // 直接创建iframe并返回，一步到位
      final iframe =
          html.IFrameElement()
            ..id = iframeId
            ..src = paymentBaseUrl
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%'
            // 跨域兜底配置（解决iframe加载限制）
            ..allowFullscreen = true
            ..allow = 'cross-origin-isolated; fullscreen'
            // 监听加载状态（成功/失败都更新）
            ..onLoad.listen((_) {
              isIframeLoading.value = false;
              debugPrint("iframe加载完成！");
            })
            ..onError.listen((error) {
              isIframeLoading.value = false;
              debugPrint("iframe加载失败：$error");
            });
      _iframeElement = iframe;
      return iframe;
    });
    isPaymentDialogShow.value = true;
  }

  void _registerMessageListener() {
    html.window.addEventListener('message', _handleReactTSMessage);
  }

  void _handleReactTSMessage(html.Event event) {
    final html.MessageEvent msgEvent = event as html.MessageEvent;
    // if (msgEvent.origin != 'http://192.168.1.107:3000') return;

    final data = msgEvent.data;
    debugPrint("接收到payment 返回数据:$data");

    if (data is Map) {
      // 1. 从Map中取出type字符串，转换为枚举
      final String? typeStr = data["type"];
      final PaymentMessageType type = PaymentMessageType.fromString(typeStr);

      // 2. 基于枚举的switch判断（类型安全+可读性更强）
      switch (type) {
        case PaymentMessageType.cardElementReady:
          debugPrint("React B已就绪,发送机密参数...");
          _sendSecretParamsToReact();
          break;
        case PaymentMessageType.initSuccess:
          debugPrint("React支付组件初始化成功: ${data['msg']}");
          break;
        case PaymentMessageType.initError:
          debugPrint("React支付组件初始化失败: ${data['msg']}");
          break;
        case PaymentMessageType.paramsError:
          debugPrint("React参数校验失败: ${data['msg']}");
          break;
        // 合并相同处理逻辑的case：关闭弹窗
        case PaymentMessageType.closeDialog:
          closePaymentDialog();
          break;
        case PaymentMessageType.paySuccess:
          closePaymentDialog();
          payProgress.value = PayProgress.success;
          break;
        case PaymentMessageType.payFail:
          closePaymentDialog();
          payProgress.value = PayProgress.fail;
          break;
        // 兜底处理未知类型
        case PaymentMessageType.unknown:
          debugPrint("收到未知类型的消息: $typeStr，原始数据: $data");
          break;
      }
    }
  }

  // ========== 核心：发送机密参数给React B ==========
  void _sendSecretParamsToReact() {
    if (_iframeElement == null) {
      debugPrint("iframe未加载，无法发送参数");
      return;
    }

    // 发送机密参数（仅发送给React B，targetOrigin严格指定）
    _iframeElement!.contentWindow?.postMessage(
      {
        "type": "paymentParams",
        "params": {
          "intentId": suborderResponse?.intentId ?? "", // 你的intentId
          "clientSecret": suborderResponse?.clientSecret ?? "", // 你的clientSecret
          "currency": suborderResponse?.currency ?? "", // 币种
        }, // 机密参数
      },
      paymentBaseUrl, // 必须指定React B的地址，禁止用*
    );
    debugPrint("机密参数已发送");
  }

  void openPaymentDialog() {
    isPaymentDialogShow.value = true;
  }

  void closePaymentDialog() {
    isPaymentDialogShow.value = false;
  }
}

// 建议放在类外部或单独的constants文件中
enum PaymentMessageType {
  cardElementReady('cardElementReady'),
  initSuccess('initSuccess'),
  initError('initError'),
  paramsError('paramsError'),
  closeDialog('closeDialog'),
  paySuccess('paySuccess'),
  payFail('payFail'),
  unknown('unknown'); // 兜底未知类型

  // 枚举值对应的原始字符串
  final String value;
  const PaymentMessageType(this.value);

  // 从字符串转换为枚举（处理null/未知类型）
  static PaymentMessageType fromString(String? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => unknown, // 未知类型返回unknown
    );
  }
}
