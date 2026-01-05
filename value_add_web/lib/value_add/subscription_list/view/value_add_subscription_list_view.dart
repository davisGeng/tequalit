import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sightsys/app/modules/value_add/subscription_list/controllers/value_add_subscription_list_controller.dart';
import 'package:sightsys/app/modules/value_add/widget/value_add_subscription_card.dart';
import 'package:sightsys/assets/assets.gen.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:sightsys/app/common/widget/empty_view.dart';
import 'package:sightsys/app/common/widget/loadable_scaffold.dart';

import '../../../../../../assets/app_theme.dart';

class ValueAddSubscriptionListView extends GetView<ValueAddSubscriptionListController> {
  const ValueAddSubscriptionListView({super.key});
  @override
  Widget build(BuildContext context) {
    return LoadableScaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppTheme.current.colors.inverseBackground,
      body: _buidBody(context),
      // Obx(() => _buildRefreshView(context)),
      // Column(children: <Widget>[Expanded(child: ), _buildBottomView()]),
      controller: controller,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(12, 12, 12, 1)),

        onPressed: () {
          Get.back();
        },
      ).marginOnly(left: 10),
      title: Text('my_plan_btn'.tr, style: AppTheme.current.textStyles.title1),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: <Widget>[],
    );
  }

  Widget _buidBody(BuildContext context) {
    return Obx(() {
      if (controller.loadState.value.isFailure) {
        return EmptyView(
          description: 'general_err'.tr,
          topImage: Assets.images.imgDeviceConnectError.image(width: 150, height: 150),
          showBtn: true,
          bottomBtn: true,
          bottomParentBgColor: Colors.white,
          btnUseWidthDoubleInfinity: true,
          btnTitle: 'retry_btn'.tr,
          onTap: () async {
            await controller.refreshData(showLoading: true);
          },
        );
      } else if (controller.subscriptions.isEmpty && controller.loadState.value.isSuccess) {
        return EmptyView(
          description: 'no_active_plans_label'.tr,
          topImage: Assets.images.imgDeviceConnectEmpty.image(width: 150, height: 150),
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
