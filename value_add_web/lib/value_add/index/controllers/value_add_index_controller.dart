import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sight_sys_plugin/modules/device/valueAdd/value_add_product_response.dart';
import 'package:sightsys/app/common/model/load_state.dart';
import 'package:sightsys/app/modules/value_add/airwallex_page/plugin_resource/types/payment_result_extend.dart';
import 'package:sightsys/app/modules/value_add/airwallex_page/plugin_resource/util/airwallex_manager.dart';
import 'package:sightsys/app/modules/value_add/base/mixin/value_add_mixin.dart';
import 'package:sightsys/app/modules/value_add/value_add_routes.dart';

import 'package:sightsys/app/services/app_service.dart';
import 'package:sightsys/app/services/log_service.dart';
import 'package:sightsys/app/common/controller/route_view_controller.dart';

class ValueAddIndexController extends RouteViewController with AppServiceObserver, ValueAddMixin {
  // 翻页数据
  int currentPage = 1;
  final int pageSize = 10;
  RxBool isMoreDataAvailable = true.obs;
  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  final RxList<ValueAddProductItem> productItems = <ValueAddProductItem>[].obs;
  List<ValueAddProductItem> tempItems = [];
  final loadState = LoadState.idle().obs;
  Rx<FromPageType> fromPageType = FromPageType.valueAddIndex.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onAppear(bool isFirstAppear) {
    if (Get.arguments != null) {
      String fromType = Get.arguments["fromPageType"] ?? "";
      if (fromType == FromPageType.cloudPlayback.name) {
        fromPageType.value = FromPageType.cloudPlayback;
        // deviceIds = Get.arguments["deviceIds"] ?? "";
        // thirdPartDeviceUuid = Get.arguments["thirdPartDeviceUuid"] ?? "";
      } else if (fromType == FromPageType.data4gPairing.name) {
        fromPageType.value = FromPageType.data4gPairing;
        // deviceIds = Get.arguments["deviceIds"] ?? "";
        // thirdPartDeviceUuid = Get.arguments["thirdPartDeviceUuid"] ?? "";
      } else {
        fromPageType.value = FromPageType.valueAddIndex;
        // productId = Get.arguments["productId"] ?? "";
      }
    }
    super.onAppear(isFirstAppear);
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> refreshData() async {
    Log.d("Start refresh .");

    currentPage = 1;
    isMoreDataAvailable.value = false;
    loadState.value = LoadState.loading();
    try {
      await initService();

      await _fetchData();
      loadState.value = LoadState.success();
      await Future.microtask(() {
        Log.d("Refresh events over .");
        refreshController.finishRefresh();
      });
    } catch (e) {
      loadState.value = LoadState.failure();
      refreshController.finishRefresh();

      Log.d("error for product:${e.toString()}");
    }
  }

  Future<void> _fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    ValueAddProductResponse? response = await service?.getProductList(
      filterCountry: false,
      // productType: "CLOUD_STORAGE",
      page: currentPage,
      pageSize: pageSize,
    );
    if (response != null) {
      List<ValueAddProductItem> subItems = response.items ?? [];
      if (currentPage == 1) {
        productItems.value = subItems;
      } else {
        productItems.addAll(subItems);
      }

      if (response.pagination?.hasNext == true) {
        isMoreDataAvailable.value = true;
      } else {
        isMoreDataAvailable.value = false;
      }
    }
  }

  Future<void> loadMore() async {
    try {
      loadState.value = LoadState.loading();

      currentPage++;
      await _fetchData();
      loadState.value = LoadState.success();
    } catch (e) {
      loadState.value = LoadState.failure();

      refreshController.finishLoad(IndicatorResult.fail);
    } finally {
      var noMore = isMoreDataAvailable.isTrue ? IndicatorResult.success : IndicatorResult.noMore;

      refreshController.finishLoad(noMore);
    }
  }

  clickArrow(ValueAddProductItem item) {
    Get.toNamed(
      ValueAddPaths.VALUE_ADD_PACKAGE_CHOOSE,
      arguments: {"fromPageType": FromPageType.valueAddIndex.name, "productId": item.productId},
    );
  }

  payAction() async {
    String clientSecret =
        "eyJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2lkIjoiZTMyYWY5OTEtNzZmYy00YmFmLWE5NjUtYjFlMDJiYjc3MzMwIiwiaW50ZW50X2lkIjoiaW50X2hrZG12aDh2c2hjamYwNnlsY3QiLCJidXNpbmVzc19uYW1lIjoiZGVtbytDQVJFVEVDSCIsInR5cGUiOiJjbGllbnQtc2VjcmV0IiwicGFkYyI6IkhLIiwiaWF0IjoxNzYxODk0MTY0LCJleHAiOjE3NjE4OTc3NjR9.6IKvICLAPyedyLM7j2BIaK5OMznbzpjk5qYbDu3Mvb0";
    String intentId = "";
    String returnUrl = "";
    String orderNo = "";

    String countryCode = "US";
    String currency = "USD";

    List<String> paymentMethods = [];
    paymentMethods = ['card'];
    countryCode = "US";
    currency = "USD";

    Map<String, dynamic> map = {};
    map["id"] = intentId;
    map["client_secret"] = clientSecret;
    map["amount"] = 5;
    map['countryCode'] = countryCode;
    map["returnUrl"] = returnUrl;
    map["paymentMethods"] = paymentMethods;
    map["currency"] = currency;
    map['merchant_order_id'] = orderNo;
    map['request_id'] = UniqueKey().toString();
    map['email'] = "";

    bool isCardMethod = false;
    if (paymentMethods.length == 1) {
      if (paymentMethods[0] == "card") {
        isCardMethod = true;
      }
    }
    PaymentResultExtend resultExtend = await AirwallexManager.instance.presentEntirePaymentFlowWithIntentMap(
      isCardMethod ? AirwallexPaymentMethod.card : AirwallexPaymentMethod.entire,

      BillingMode.oneOff,
      map,
    );
    if (resultExtend.status.toLowerCase().startsWith("succ")) {
      //成功
    } else if (resultExtend.status.toLowerCase().startsWith("cancel")) {
      //取消
      Get.back(result: "fail");
      // payProgress.value = PayProgress.cancel;
    } else {
      // Get.back(result: "fail");

      // payProgress.value = PayProgress.fail;
    }
  }
}
