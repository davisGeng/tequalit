import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:value_add_web/common/widget/loadable_web_scaffold.dart';

import '../../../../../../assets/app_theme.dart';
import '../../../assets/assets.gen.dart';
import '../../../common/utils/js_utils.dart';
import '../../../common/widget/empty_view.dart';
import '../../widget/value_add_subscription_card.dart';
import '../controllers/value_add_subscription_list_controller.dart';

class ValueAddSubscriptionListView
    extends GetView<ValueAddSubscriptionListController> {
  const ValueAddSubscriptionListView({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      JsUtils.instance.sendMessageToNative(type: 'hide_tab');
    });
    return LoadableWebScaffold(
      title: 'my_plan_btn'.tr,
      bottomSafeHeight: -1,
      leadingOnTap: () {
        JsUtils.instance.sendMessageToNative(type: 'show_tab');
        Get.back();
      },
      backgroundColor: AppTheme.current.colors.inverseBackground,
      body: _buidBody(context),
      controller: controller,
    );
  }

  Widget _buidBody(BuildContext context) {
    return Obx(() {
      if (controller.loadState.value.isFailure) {
        return EmptyView(
          description: 'general_err'.tr,
          topImage: Assets.images.imgDeviceConnectError.image(
            width: 150,
            height: 150,
          ),
          showBtn: true,
          bottomBtn: true,
          bottomParentBgColor: Colors.white,
          btnUseWidthDoubleInfinity: true,
          btnTitle: 'retry_btn'.tr,
          onTap: () async {
            await controller.refreshData(showLoading: true);
          },
        );
      } else if (controller.subscriptions.isEmpty &&
          controller.loadState.value.isSuccess) {
        return EmptyView(
          description: 'no_active_plans_label'.tr,
          topImage: Assets.images.imgDeviceConnectEmpty.image(
            width: 150,
            height: 150,
          ),
          showBtn: false,
        );
      }
      return _buildRefreshView(context);
    });
  }

  Widget _buildRefreshView(BuildContext context) => EasyRefresh(
    controller: controller.refreshController,
    refreshOnStart: true,
    header: const CupertinoHeader(),
    footer: const CupertinoFooter(emptyWidget: SizedBox.shrink()),
    onRefresh: () async {
      controller.refreshData();
    },
    onLoad: () => controller.onLoad(),
    child: Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: _buildList(context),
    ),
  );

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.subscriptions.length,
      itemBuilder: (context, index) {
        return Obx(() {
          return ValueAddSubscriptionCard(
            item: controller.subscriptions[index],
            index: index,
            selectIndex: 0,
            onTap: (value) {},
          );
        });
      },
    );
  }
}
