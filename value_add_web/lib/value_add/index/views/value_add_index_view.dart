import 'dart:io';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sightsys/app/modules/value_add/base/mixin/value_add_mixin.dart';
import 'package:sightsys/app/modules/value_add/value_add_routes.dart';
import 'package:sightsys/app/modules/value_add/widget/value_service_card.dart';
import '../controllers/value_add_index_controller.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:sightsys/app/common/widget/empty_view.dart';
import 'package:sightsys/assets/app_theme.dart';
import '../../../../../assets/assets.gen.dart';
import '../../../../common/controller/route_view_controller.dart';
import '../../../../common/widget/build_base_widget.dart';

///
class ValueAddIndexView extends GetView<ValueAddIndexController> {
  ValueAddIndexView({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return RouteView(
      controller: controller,
      child: BuildBaseWidget.buildScaffold(
        appBar: _buildAppBar(context),
        backgroundColor: AppTheme.current.colors.inverseBackground,
        body: _buidBody(context),
      ),
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
            await controller.refreshData();
          },
        );
      } else if (controller.productItems.isEmpty && controller.loadState.value.isSuccess) {
        return EmptyView(
          description: ''.tr,
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
    onRefresh: () => controller.refreshData(),
    onLoad: () => controller.loadMore(),
    child: _buildList(context),
  );

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      // 隐藏左侧默认返回键（适用于首页）
      automaticallyImplyLeading: false,

      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity, // 占满可用宽度
        child: Row(
          children: [
            // 左侧图标
            Obx(() {
              if (controller.fromPageType.value != FromPageType.valueAddIndex) {
                return Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios, color: Colors.black, size: 24)
                    .onTap(() {
                      Get.back();
                    })
                    .marginOnly(right: 8);
              }
              return SizedBox();
            }),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('services_page_title'.tr, style: AppTheme.current.textStyles.title0),
                  _buildRightBtn(context),
                ],
              ),
            ),
          ],
        ),
      ),

      centerTitle: true,
      backgroundColor: AppTheme.current.colors.inverseBackground,
    );
  }

  Widget _buildRightBtn(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(maxHeight: 34, minHeight: 34, minWidth: 34),
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.iconServiceEffect.image(width: 16, height: 16, fit: BoxFit.fill).marginOnly(bottom: 4),
            Text('my_plan_btn'.tr, style: TextStyle(fontSize: 9)),
          ],
        ),
        onTap: () {
          Get.toNamed(ValueAddPaths.VALUE_ADD_SUBSCRIPTION_LIST);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context) => ListView.separated(
    padding: const EdgeInsets.only(left: 24, right: 24),
    itemCount: controller.productItems.length,
    itemBuilder:
        (context, index) => ValueServiceCard(
          item: controller.productItems[index],
          index: index,
          radius: 5,
          onTapArrow: (value) {
            controller.clickArrow(value);
          },
        ),
    separatorBuilder: (context, index) => Container(height: 0, color: Colors.transparent),
  );
}
