import 'package:get/get.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:value_add_web/common/widget/loadable_web_scaffold.dart';

import '../../../api/value_add_api.dart';
import '../../../common/model/load_state.dart';
import '../../../model/value_add_order_list_response.dart';
import '../../../services/log_service.dart';

class ValueAddOrderListController extends GetxController
    with LoadableWebController {
  final RxList<ValueAddOrderItem> orders = <ValueAddOrderItem>[].obs;

  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int currentPage = 1;
  final int pageSize = 10;

  RxBool isMoreDataAvailable = true.obs;

  final loadState = LoadState.idle().obs;

  List<String> deviceIds = [];
  String productType = "";
  @override
  void onInit() {
    if (Get.arguments != null) {
      productType = Get.arguments["productType"] ?? "";
    }
    super.onInit();
  }

  @override
  void onReady() async {
    refreshController.callRefresh();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onLoad() async {
    try {
      currentPage++;
      await getOrderList();
    } catch (e) {
      refreshController.finishLoad(IndicatorResult.fail);
    } finally {
      var noMore =
          isMoreDataAvailable.isTrue
              ? IndicatorResult.success
              : IndicatorResult.noMore;

      refreshController.finishLoad(noMore);
    }
  }

  Future<void> refreshData({bool showLoading = false}) async {
    if (showLoading) {
      startLoading();
    } else {
      loadState.value = LoadState.idle();
    }
    currentPage = 1;
    isMoreDataAvailable.value = false;
    try {
      await getOrderList();
      loadState.value = LoadState.success();
    } catch (e) {
      loadState.value = LoadState.failure();
    } finally {
      if (showLoading) {
        stopLoading();
      }
      await Future.microtask(() {
        Log.d("Refresh events over .device length:${orders.length}");
        refreshController.finishRefresh();
      });
    }
  }

  Future getOrderList() async {
    ValueAddOrderListResponse? res = await ValueAddApi.instance
        .getValueAddOrderList(
          page: currentPage,
          pageSize: pageSize,
          status: 'PAID,PROCESSING',
          productType: productType,
        );

    Log.d("**verifyOrder:${res?.toJson()}");
    if (res != null) {
      if (currentPage == 1) {
        orders.value = res.items ?? [];
      } else {
        orders.addAll(res.items ?? []);
      }

      if (res.pagination?.hasNext == true) {
        isMoreDataAvailable.value = true;
      } else {
        isMoreDataAvailable.value = false;
      }
    }
  }
}
