import 'dart:io';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:value_add_web/common/utils/js_utils.dart';
import 'package:value_add_web/common/widget/loadable_web_scaffold.dart';
import '../../../assets/app_theme.dart';
import '../../../common/widget/empty_view.dart';
import '../../../services/log_service.dart';
import '../../value_add_routes.dart';
import '../../widget/value_service_card.dart';
import '../controllers/value_add_index_controller.dart';
import 'package:easy_refresh/easy_refresh.dart';
import '../../../../../assets/assets.gen.dart';
import '../../../../common/controller/route_view_controller.dart';

///
class ValueAddIndexView extends GetView<ValueAddIndexController> {
  const ValueAddIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      JsUtils.instance.sendMessageToNative(type: 'show_tab');
    });
    return RouteView(
      controller: controller,
      child: LoadableWebScaffold(
        body: _buidBody(context),
        customNavBar: _buildAppBar(context),
        topBarBgColor: Colors.transparent,
        // 底部安全区域配置（Web端自定义）
        bottomSafeHeight: -1,
        backgroundColor: AppTheme.current.colors.inverseBackground,
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

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity, // 占满可用宽度
      color: Colors.transparent,
      height: 44,
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
          Get.toNamed(ValueAddPaths.valueAddSubscriptionList);
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
