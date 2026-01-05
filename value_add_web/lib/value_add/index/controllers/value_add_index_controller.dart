import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/value_add_api.dart';
import '../../../common/controller/route_view_controller.dart';
import '../../../common/model/load_state.dart';
import '../../../model/value_add_product_response.dart';
import '../../../services/log_service.dart';
import '../../value_add_routes.dart';

class ValueAddIndexController extends RouteViewController  {
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
    ValueAddProductResponse? response = await ValueAddApi.instance.getProductList(
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


}
