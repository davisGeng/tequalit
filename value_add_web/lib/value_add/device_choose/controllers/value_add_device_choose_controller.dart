import 'dart:io';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/model/load_state.dart';
import '../../../common/widget/loadable_scaffold.dart';
import '../../../model/check_device_available_by_plan_response.dart';
import '../../../model/value_add_create_order_response.dart';
import '../../../model/value_add_product_response.dart';


enum PayProgress { undo, success, fail, cancel }

class ValueAddDeviceChooseController extends RouteViewController
    with LoadableController {
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
  // RxBool isMoreDataAvailable = false.obs;
  final selectIndex = (-1).obs;
  final payProgress = PayProgress.undo.obs;

  final doneBtnEnable = false.obs;

  ValueAddCreateOrderResponse? suborderResponse;

  bool openPaymentWeb = false;

  String userRegion = "";
  final loadState = LoadState.idle().obs;

  @override
  void onInit() {
    AppService.instance.addObserver(this);
    showLoadingWidget.value = false;
    super.onInit();
  }

  @override
  void onReady() async {
    await initService(initAirwallex: true);
    super.onReady();
  }

  @override
  void onClose() {
    AppService.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void onAppear(bool isFirstAppear) {
    Log.d("goAirwallexAndPayOrder back onAppear :showWeb:$openPaymentWeb");
    if (suborderResponse != null && openPaymentWeb) {
      retryGetPayDetail();
      // checkOrderStatus(suborderResponse?.orderNumber);
    }
    super.onAppear(isFirstAppear);
  }

  @override
  void onDisAppear(bool isLastDisAppear, bool isHidden) {
    Log.d("goAirwallexAndPayOrder back onDisAppear");

    super.onDisAppear(isLastDisAppear, isHidden);
  }

  @override
  void onAppPause() {
    Log.d("goAirwallexAndPayOrder back onAppPause");
    super.onAppPause();
  }

  @override
  void onAppResume() {
    Log.d("goAirwallexAndPayOrder back onAppResume");
    //todo ios 待测试流程
    super.onAppResume();
  }

  @override
  void onAppInfoUpdated() {
    super.onAppInfoUpdated();
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
    await initService();
    final deviceMaps =
        await DeviceService.instance.getFirmwareVersionsOfDevices();
    if (deviceMaps.isNotEmpty) {
      final res = await service?.getValueAddAvailableDeviceByPlan(
        plans.planId ?? "",
        deviceMaps,
      );
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
    await choosePaymentMethodAction(context, plans, (
      channelCode,
      isRepay,
    ) async {
      subOrder(context, channelCode, isRepay);
    });
  }

  // 下单
  Future subOrder(
    BuildContext context,
    String? channelCode,
    bool isRepayOrder,
  ) async {
    if (channelCode == null) {
      return;
    }

    startLoading();
    await initService();

    try {
      DeviceAvailableResults device = devices[selectIndex.value];
      if (!isRepayOrder) {
        suborderResponse = await service?.createOrder(
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
    try {
      if (suborderResponse == null) {
        BasicSnack.error("create_order_failed_err".tr);
        return;
      }
      SupavizPaymentManager.instance.addLocalCloudStorageOrder(
        orderNo: suborderResponse?.orderNumber ?? "",
        platform: channelCode,
      );

      //开始支付
      if (channelCode.contains("paypal")) {
        Log.d("paypal hmOrderId:${suborderResponse?.orderNumber}");

        //跳转网页m suborderResponse?.packageValue ??
        await PrivacyPolicyHelper.openWebViewPageWithUrl(
          context,
          "paypal_label".tr,
          "",
          // "https://www.paypal.com/checkoutnow?token=4WS556916Y4460845",
        );
        openPaymentWeb = true;
        Log.d("webview end **");
      } else if (channelCode.contains("airwallex")) {
        //ios 结果返回在appear 里捕获
        openPaymentWeb = true;
        // if (Platform.isIOS) {
        //   stopLoading();
        // }
        PaymentResultExtend? resultExtend = await SupavizPaymentManager.instance
            .payWithAirwallexV1(
              orderNumber: suborderResponse?.orderNumber ?? "",
              totalAmount: suborderResponse?.totalAmount ?? 0,
              currency: suborderResponse?.currency ?? "",
              intentId: suborderResponse?.intentId ?? "",
              clientSecret: suborderResponse?.clientSecret ?? "",
              returnUrl: suborderResponse?.returnUrl ?? "",
            );

        openPaymentWeb = false;
        Log.d(
          "**subscripbeGoodsAction: orderNo:${suborderResponse?.orderNumber},result:${resultExtend.toString()}",
        );

        if (resultExtend == null) {
          Log.d(
            "**subscripbeGoodsAction: orderNo:${suborderResponse?.orderNumber},result:null",
          );

          Get.back(result: "fail");
          return;
        }
        await Future.delayed(Duration(seconds: 1));
        if (resultExtend.status.toLowerCase().startsWith("succ")) {
          Log.d(
            "**subscripbeGoodsAction: orderNo:${suborderResponse?.orderNumber},result: ssss,payprogress:${payProgress.value.name}",
          );
          //todo  ios 进入当前页面，第一个支付弹窗被下拉消失后，第二次支付成功或者失败，或者下拉消失时会自动返回上级页面

          //成功
          payProgress.value = PayProgress.success;
        } else {
          Log.d(
            "**subscripbeGoodsAction: orderNo:${suborderResponse?.orderNumber},result:fffff",
          );

          //fail
          Get.back(result: "fail");
        }
      }
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
    try {
      String paymentChannel = suborderResponse?.paymentChannel ?? "";
      if (paymentChannel.contains("airwallex")) {
        RetrievePaymentIntentReponse res = await AirwallexManager.instance
            .retrieveAPaymentIntent(suborderResponse?.intentId ?? "");
        Log.i(
          "retryGetPayDetail with intentId:${suborderResponse?.intentId} res:${res.toJson()}",
        );
        Log.i(
          "retryGetPayDetail with last attemp:${res.latestPaymentAttempt?.toJson()} }",
        );

        String status = res.status ?? "";
        //         出现在Intent刚创建的场景下，一般代表支付请求已创建，但客户尚未执行任何操作。
        // 备注：若confirm过后看到该状态代表此次消费者的购买行为失败。如果需要了解是失败原因 可通过查询Intent接口返回的“latest_payment_attempt.failure_code”来判断。
        if (status.equalsIgnoreCase("REQUIRES_PAYMENT_METHOD")) {
          LatestPaymentAttempt? latestPaymentAttempt = res.latestPaymentAttempt;

          if (latestPaymentAttempt != null) {
            String attemptStatus = latestPaymentAttempt.status ?? "";
            String failureCode = latestPaymentAttempt.failureCode ?? "";
            // authentication_declined: 人脸或者3D验证失败
            // issuer_declined 授权失败
            if (failureCode.isNotEmpty ||
                attemptStatus.equalsIgnoreCase("failed")) {
              Get.back(result: attemptStatus);
            } else {
              // BasicToast.error("general_err".tr);
              Get.back(result: "fail");
            }
          } else {
            Get.back(result: "fail");
          }
        } else if (status.equalsIgnoreCase("SUCCEEDED")) {
          payProgress.value = PayProgress.success;
        } else {
          Get.back(result: "fail");
        }
      } else {
        //paypal
        Get.back(result: "fail");
      }
    } catch (e) {
      stopLoading();
    } finally {
      stopLoading();
    }
  }
}
