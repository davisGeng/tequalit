import 'package:get/get.dart';
import 'package:easy_refresh/easy_refresh.dart';

import '../../../api/value_add_api.dart';
import '../../../common/model/load_state.dart';
import '../../../common/widget/loadable_scaffold.dart';
import '../../../model/value_add_subscription_list_response.dart';

class ValueAddSubscriptionListController extends GetxController with LoadableController {

  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int currentPage = 1;

  final int pageSize = 10;
  RxBool isMoreDataAvailable = true.obs;

  final loadState = LoadState.idle().obs;

  List<String> deviceIds = [];

  final RxList<DeviceSubscription> subscriptions = <DeviceSubscription>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {

    super.onReady();
  }

  @override
  void onClose() {
    desposeService();
    super.onClose();
  }

  Future desposeService() async {}

  Future<void> onLoad() async {
    try {
      loadState.value = LoadState.loading();

      currentPage++;
      await getOrderList();
    } catch (e) {
      refreshController.finishLoad(IndicatorResult.fail);
    } finally {
      var noMore = isMoreDataAvailable.isTrue ? IndicatorResult.success : IndicatorResult.noMore;

      refreshController.finishLoad(noMore);
    }
  }

  Future<void> refreshData({bool showLoading = false}) async {
    if (showLoading) {
      startLoading();
    }
    currentPage = 1;
    isMoreDataAvailable.value = false;
    loadState.value = LoadState.loading();
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
        refreshController.finishRefresh();
      });
    }
  }

  Future getOrderList() async {
    // if (service == null) {
    //   await initService();
    // }

    final res = await ValueAddApi.instance.getValueAddSubscriptions(useGroupBy: true);

    if (res != null) {
      if (currentPage == 1) {
        subscriptions.value = res.items ?? [];
      } else {
        subscriptions.addAll(res.items ?? []);
      }

      if (res.pagination?.hasNext == true) {
        isMoreDataAvailable.value = true;
      } else {
        isMoreDataAvailable.value = false;
      }
    }
  }
}
