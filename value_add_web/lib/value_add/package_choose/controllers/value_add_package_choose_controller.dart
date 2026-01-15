import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:value_add_web/api/value_add_api.dart';

import '../../../common/model/load_state.dart';
import '../../../common/widget/basic_snack.dart';
import '../../../common/widget/basic_toast.dart';
import '../../../common/widget/loadable_web_scaffold.dart';
import '../../../model/value_add_create_order_response.dart';
import '../../../model/value_add_product_response.dart';
import '../../../services/log_service.dart';
import '../../device_choose/controllers/value_add_device_choose_controller.dart';
import '../../../common/controller/route_view_controller.dart';
import '../../device_choose/views/value_add_device_choose_view.dart';

class ValueAddPackageChooseController extends RouteViewController
    with LoadableWebController {
  final CardSwiperController swiperController = CardSwiperController();

  final RxList<CloudGoodsBanners> banners = <CloudGoodsBanners>[].obs;
  final selectPlanTag = "0_0".obs;
  final selectSwiperIndex = 0.obs;

  final RxList<Plans> plansList = <Plans>[].obs;

  String appver = "";
  final loadState = LoadState.idle().obs;

  String selectPriceId = '';
  final selectCurrent = ''.obs;
  final selectCurrentSymbol = ''.obs;
  final selectUnitAmount = 0.obs;

  String productType = "";
  ValueAddProductItem? currentProduct;

  String productId = "";
  FromPageType fromPageType = FromPageType.valueAddIndex;

  String deviceIds = "";
  String firmwareVersion = "";

  int currentPage = 1;

  final payProgress = PayProgress.undo.obs;

  final doneBtnEnable = false.obs;

  ValueAddCreateOrderResponse? suborderResponse;

  bool openPaymentWeb = false;
  String thirdPartDeviceUuid = "";

  @override
  void onInit() {
    // AppService.instance.addObserver(this);

    if (Get.arguments != null) {
      String fromType = Get.arguments["fromPageType"] ?? "";
      if (fromType == FromPageType.cloudPlayback.name) {
        fromPageType = FromPageType.cloudPlayback;
        deviceIds = Get.arguments["deviceIds"] ?? "";
        thirdPartDeviceUuid = Get.arguments["thirdPartDeviceUuid"] ?? "";
      } else if (fromType == FromPageType.data4gPairing.name) {
        fromPageType = FromPageType.data4gPairing;
        deviceIds = Get.arguments["deviceIds"] ?? "";
        thirdPartDeviceUuid = Get.arguments["thirdPartDeviceUuid"] ?? "";
      } else {
        fromPageType = FromPageType.valueAddIndex;
        productId = Get.arguments["productId"] ?? "";
      }
    }
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    refreshData(showLoading: true);
  }

  @override
  void onClose() {
    // AppService.instance.removeObserver(this);

    super.onClose();
  }

  @override
  void onAppear(bool isFirstAppear) {
    Log.d("goAirwallexAndPayOrder back onAppear :showWeb:$openPaymentWeb");
    if (suborderResponse != null && openPaymentWeb) {
      retryGetPayDetail();
    }
    super.onAppear(isFirstAppear);
  }

  @override
  void onDisAppear(bool isLastDisAppear, bool isHidden) {
    Log.d("goAirwallexAndPayOrder back onDisAppear");

    super.onDisAppear(isLastDisAppear, isHidden);
  }

  Future<void> refreshData({
    bool showLoading = false,
    bool refresh = false,
  }) async {
    if (showLoading) {
      startLoading();
    }
    loadState.value = LoadState.loading();

    currentPage = 1;
    Log.d("Start refresh events .");

    try {
      await _fetchData(needRefresh: true);
      loadState.value = LoadState.success();

      // 等待一帧后再结束刷新状态，避免刷新动画卡住
    } catch (e) {
      loadState.value = LoadState.failure();
      Log.d("Refresh catche err:${e.toString()} .");
      if (showLoading) {
        stopLoading();
      }
    } finally {
      if (showLoading) {
        stopLoading();
      }
    }
  }

  Future<void> _fetchData({bool needRefresh = false}) async {
    plansList.clear();
    if (needRefresh) {
      if (fromPageType == FromPageType.valueAddIndex) {
        final response = await ValueAddApi.instance.getProductDetail(productId);
        if (response == null) return;
        productType = response.type ?? "";
        plansList.addAll(response.plans ?? []);

        //没有更多了
      } else {
        final response = await ValueAddApi.instance.getValueAddPlansByDevice(
          deviceIds,
        );
        if (response == null) return;
        if (currentPage == 1) {
          plansList.value = response.items ?? [];
        } else {
          plansList.addAll(response.items ?? []);
        }
      }
    } else {
      if (currentProduct != null) {
        plansList.addAll(currentProduct?.plans ?? []);
      }
    }
    banners.value = [
      CloudGoodsBanners(
        imageUrl: productType,
        description:
            productType == ValueAddProductServiceType.data4G.typeName
                ? 'top_up_4g_intro_content'.tr
                : "cloud_recording_intro_content".tr,
      ),
    ];

    updateSelectPlanTag(selectPlanTag.value);
  }

  //更新选中套餐信息
  updateSelectPlanTag(String tag) {
    if (plansList.isEmpty) {
      return;
    }
    List<int> intList =
        tag
            .split("_")
            .map((s) => int.tryParse(s)) // 转换失败返回 null
            .where((num) => num != null) // 过滤 null
            .cast<int>() // 转换为 int 类型
            .toList();
    selectPlanTag.value = tag;

    if (intList.length == 2) {
      Plans plans = plansList[intList[0]];
      List<Prices> priceList = plans.prices ?? [];
      if (priceList.isNotEmpty) {
        Prices selectItem = priceList[intList[1]];
        selectPriceId = selectItem.priceId ?? "";
        selectUnitAmount.value = selectItem.unitAmount ?? -1;
        selectCurrent.value = selectItem.currency ?? "";
        selectCurrentSymbol.value = selectItem.currencySymbol ?? "";
      }
    }
  }

  // 点击订阅按钮
  clickSubcription(BuildContext context) async {
    if (plansList.isEmpty) {
      return;
    }
    List<int> intList =
        selectPlanTag.value
            .split("_")
            .map((s) => int.tryParse(s)) // 转换失败返回 null
            .where((num) => num != null) // 过滤 null
            .cast<int>() // 转换为 int 类型
            .toList();

    if (intList.length == 2) {
      Plans plans = plansList[intList[0]];
      List<Prices> priceList = plans.prices ?? [];
      if (priceList.isNotEmpty) {
        Prices selectItem = priceList[intList[1]];
        if (fromPageType == FromPageType.valueAddIndex) {
          gotoDeviceChoosePage(plans, selectItem);
        } else {
          //todo
          // choosePaymentMethodAction(context, plans, (channelCode, isRepay) {
          //   subOrder(context, channelCode, isRepay);
          // });
        }
      }
    }
  }

  Future gotoDeviceChoosePage(Plans plans, Prices selectItem) async {
    final result = await Get.to(
      () => ValueAddDeviceChooseView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ValueAddDeviceChooseController>(
          () => ValueAddDeviceChooseController(plans, selectItem),
        );
        // Get.put(() => CloudServiceChooseDeviceController(plans, selectItem));
      }),
    );
    if (result != null && result is String) {
      if (result.startsWith("AUTH")) {
        BasicToast.error("验证失败");
      } else if (result.startsWith("ISSUER")) {
        BasicToast.error("授权失败");
      } else if (result.startsWith("fail")) {
        BasicToast.error("支付失败");
      } else {
        BasicToast.error(result);
      }
    }
  }

  Future subOrder(
    BuildContext context,
    String? channelCode,
    bool isRepayOrder,
  ) async {
    if (channelCode == null) {
      return;
    }

    startLoading();

    try {
      if (!isRepayOrder) {
        suborderResponse = await ValueAddApi.instance.createOrder(
          deviceId: thirdPartDeviceUuid,
          paymentChannel: channelCode,
          priceId: selectPriceId,
        );
      }
    } catch (e) {
      stopLoading();
      Log.d("createOrder err:${e.toString()}");
    }
    try {
      if (suborderResponse == null) {
        BasicSnack.error("create_order_failed_err".tr);
        return;
      }
      // SupavizPaymentManager.instance.addLocalCloudStorageOrder(
      //   orderNo: suborderResponse?.orderNumber ?? "",
      //   platform: channelCode,
      // );

      //开始支付
      // if (channelCode.contains("paypal")) {
      //   Log.d("paypal hmOrderId:${suborderResponse?.orderNumber}");
      //
      //   //跳转网页m suborderResponse?.packageValue ??
      //   await PrivacyPolicyHelper.openWebViewPageWithUrl(
      //     context,
      //     "paypal_label".tr,
      //     "",
      //     // "https://www.paypal.com/checkoutnow?token=4WS556916Y4460845",
      //   );
      //   openPaymentWeb = true;
      //   Log.d("webview end **");
      // } else if (channelCode.contains("airwallex")) {
      //   //ios 结果返回在appear 里捕获
      //   openPaymentWeb = true;
      //   if (Platform.isIOS) {
      //     stopLoading();
      //   }
      //   PaymentResultExtend? resultExtend = await SupavizPaymentManager.instance
      //       .payWithAirwallexV1(
      //         orderNumber: suborderResponse?.orderNumber ?? "",
      //         totalAmount: suborderResponse?.totalAmount ?? 0,
      //         currency: suborderResponse?.currency ?? "",
      //         intentId: suborderResponse?.intentId ?? "",
      //         clientSecret: suborderResponse?.clientSecret ?? "",
      //         returnUrl: suborderResponse?.returnUrl ?? "",
      //       );
      //
      //   openPaymentWeb = false;
      //   Log.d(
      //     "**subscripbeGoodsAction: orderNo:${suborderResponse?.orderNumber},result:${resultExtend.toString()}",
      //   );
      //
      //   if (resultExtend == null) {
      //     Log.d(
      //       "**subscripbeGoodsAction: orderNo:${suborderResponse?.orderNumber},result:null",
      //     );
      //
      //     Get.back(
      //       result: {
      //         "status": "fail",
      //         "orderNumber": suborderResponse?.orderNumber,
      //       },
      //     );
      //     return;
      //   }
      //   await Future.delayed(Duration(seconds: 1));
      //   if (resultExtend.status.toLowerCase().startsWith("succ")) {
      //     Log.d(
      //       "**subscripbeGoodsAction: orderNo:${suborderResponse?.orderNumber},result: ssss,payprogress:${payProgress.value.name}",
      //     );
      //     //todo  ios 进入当前页面，第一个支付弹窗被下拉消失后，第二次支付成功或者失败，或者下拉消失时会自动返回上级页面
      //
      //     //成功
      //     payProgress.value = PayProgress.success;
      //     Get.back(
      //       result: {
      //         "status": "success",
      //         "orderNumber": suborderResponse?.orderNumber,
      //       },
      //     );
      //
      //     // BasicSnack.success("pay successfull");
      //   } else {
      //     Log.d(
      //       "**subscripbeGoodsAction: orderNo:${suborderResponse?.orderNumber},result:fffff",
      //     );
      //     Get.back(
      //       result: {
      //         "status": "fail",
      //         "orderNumber": suborderResponse?.orderNumber,
      //       },
      //     );
      //   }
      // }
    } catch (err) {
      Log.d("**subscripbeGoodsAction err:${err.toString()}");

      stopLoading();
      if (err is PlatformException) {
        Get.back(
          result: {
            "status": err.message,
            "orderNumber": suborderResponse?.orderNumber,
          },
        );
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
    try {
      String paymentChannel = suborderResponse?.paymentChannel ?? "";
    } catch (e) {
      stopLoading();
    } finally {
      stopLoading();
    }
  }

  bool onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    selectSwiperIndex.value = currentIndex ?? 0;
    Log.d(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    Log.d('The card $currentIndex was undod from the ${direction.name}');
    return true;
  }
}
