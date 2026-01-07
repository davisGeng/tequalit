import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:value_add_web/common/widget/loadable_web_scaffold.dart';

import '../../../../../../assets/app_theme.dart';
import '../../../../../../assets/assets.gen.dart';
import '../../../common/controller/route_view_controller.dart';
import '../../../common/widget/basic_button.dart';
import '../../../common/widget/empty_view.dart';
import '../../widget/value_add_device_choose_card.dart';
import '../controllers/value_add_device_choose_controller.dart';

class ValueAddDeviceChooseView extends GetView<ValueAddDeviceChooseController> {
  const ValueAddDeviceChooseView({super.key});
  @override
  Widget build(BuildContext context) {
    return RouteView(
      controller: controller,
      child: LoadableWebScaffold(
        title: 'cloud_recording_nav_title'.tr,
        backgroundColor: AppTheme.current.colors.inverseBackground,
        body: Obx(() {
          if (controller.payProgress.value == PayProgress.undo) {
            return _buildRefreshView(context);
          }
          return _buildPayResultView(context);
        }),
        controller: controller,
      ),
    );
  }

  Widget _buildRefreshView(BuildContext context) => EasyRefresh(
    controller: controller.refreshController,
    refreshOnStart: true,
    header: const CupertinoHeader(),
    footer: const CupertinoFooter(emptyWidget: SizedBox.shrink()),
    onRefresh: () => controller.refreshData(),
    onLoad: null,
    child: Obx(() {
      Widget _bottomView = _buildBottomView(context);

      if (controller.loadState.value.isFailure) {
        return Column(
          children: [
            Expanded(
              child: EmptyView(
                description: 'general_err'.tr,
                topImage: Assets.images.imgDeviceConnectError.image(
                  width: 150,
                  height: 150,
                ),
                showBtn: false,
              ),
            ),
            _bottomView,
          ],
        );
      } else if (controller.devices.isEmpty &&
          controller.loadState.value.isSuccess) {
        return EmptyView(
          description: 'device_list_empty_label'.tr,
          topImage: Assets.images.imgDeviceConnectEmpty.image(
            width: 150,
            height: 150,
          ),
        );
      } else if (controller.devices.isNotEmpty &&
          controller.loadState.value.isSuccess) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.devices.isEmpty
                          ? ''
                          : 'choose_device_instruction'.tr,
                      style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
                    ).marginOnly(top: 20, bottom: 8),
                    Expanded(child: _buildList(context)),
                  ],
                ),
              ),
            ),

            _bottomView,
          ],
        );
      }
      return _buildList(context);
    }),
  );
  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.devices.length,
      itemBuilder: (context, index) {
        return Obx(() {
          return ValueAddDeviceChooseCard(
            index: index,
            selectIndex: controller.selectIndex.value,
            item: controller.devices[index],
            isLast: index == controller.devices.length - 1,
            onTap: (value) {
              controller.updateSelectIndex(index);
            },
          );
        });
      },
    );
  }

  Widget _buildBottomView(BuildContext context) {
    return Obx(() {
      if (controller.loadState.value.isSuccess) {
        return Container(
          color: Colors.white,

          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          width: double.maxFinite,
          height: 72,
          alignment: Alignment.center,
          child: BasicButton(
            style: BasicButtonStyle.blue,
            title: 'next_step_btn'.tr,
            onPressed:
                controller.doneBtnEnable.value
                    ? () async {
                      await controller.choosePaymentMethodDialog(context);
                    }
                    : null,
            height: 44,
            useWidthDoubleInfinity: true,
          ),
        );
      } else if (controller.loadState.value.isFailure) {
        return Container(
          color: Colors.white,

          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          width: double.maxFinite,
          height: 72,
          alignment: Alignment.center,
          child: BasicButton(
            style: BasicButtonStyle.blue,
            title: 'retry_btn'.tr,
            onPressed: () async {
              await controller.choosePaymentMethodDialog(context);
            },
            height: 44,
            useWidthDoubleInfinity: true,
          ),
        );
      }
      return SizedBox();
    });
  }

  Widget _buildPayResultView(BuildContext context) {
    return Obx(() {
      AssetGenImage image;
      String status;
      String description;
      if (controller.payProgress.value == PayProgress.fail) {
        image = Assets.images.failure;
        status = "general_err".tr;
        description = "";
      } else {
        image = Assets.images.iconPaySuccess;

        status = "success_payment_msg".tr;
        description = "success_payment_content".tr;
      }
      return Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image
                      .image(width: 130, height: 130, fit: BoxFit.fill)
                      .marginOnly(bottom: 35),
                  Text(
                    status,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ).marginOnly(bottom: 20),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
            _buildResultBottomView(context),
          ],
        ),
      );
    });
  }

  Widget _buildResultBottomView(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
      width: double.maxFinite,
      height: 72,
      alignment: Alignment.center,
      child: Obx(
        () => BasicButton(
          style: BasicButtonStyle.black1,
          title:
              controller.payProgress.value == PayProgress.fail
                  ? 'retry_btn'.tr
                  : 'done_btn'.tr,
          onPressed: () {
            if (controller.payProgress.value == PayProgress.success) {
              Get.back();
            } else if (controller.payProgress.value == PayProgress.fail) {
              controller.subOrder(
                context,
                controller.suborderResponse?.paymentChannel,
                true,
              );
            }
          },
          height: 44,
          useWidthDoubleInfinity: true,
        ),
      ),
    );
  }
}
