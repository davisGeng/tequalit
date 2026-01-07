import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../assets/app_theme.dart';
import '../../../assets/assets.gen.dart';
import '../../../common/controller/route_view_controller.dart';
import '../../../common/utils/js_utils.dart';
import '../../../common/widget/basic_button.dart';
import '../../../common/widget/empty_view.dart';
import '../../../common/widget/loadable_web_scaffold.dart';
import '../../value_add_routes.dart';
import '../../widget/value_add_4g_package_card.dart';
import '../../widget/value_add_package_card.dart';
import '../controllers/value_add_package_choose_controller.dart';

class ValueAddPackageChooseView
    extends GetView<ValueAddPackageChooseController> {
  const ValueAddPackageChooseView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      JsUtils.instance.sendMessageToNative(type: 'hide_tab');
    });
    return RouteView(
      controller: controller,

      child: LoadableWebScaffold(
        title: 'cloud_recording_nav_title'.tr,
        actions: [
          IconButton(
            icon: Assets.images.iconServiceCloudEffect.image(
              width: 24,
              height: 24,
            ),
            onPressed: () async {
              await Get.toNamed(
                ValueAddPaths.valueAddOrderList,
                arguments: {'productType': controller.productType},
              );
            },
          ),
        ],
        leadingOnTap: () {
          JsUtils.instance.sendMessageToNative(type: 'show_tab');

          Get.back();
        },
        body: Container(
          color: AppTheme.current.colors.inverseBackground,
          child: _buildBody(context),
        ),

        controller: controller,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Color.fromRGBO(12, 12, 12, 1),
        ),

        onPressed: () {
          Navigator.pop(context);
        },
      ).marginOnly(left: 10),
      title: Text(
        'cloud_recording_nav_title'.tr,
        style: AppTheme.current.textStyles.title1,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          icon: Assets.images.iconServiceCloudEffect.image(
            width: 24,
            height: 24,
          ),
          onPressed: () async {
            await Get.toNamed(
              ValueAddPaths.valueAddOrderList,
              arguments: {'productType': controller.productType},
            );
          },
        ).marginOnly(right: 10),
      ],
      scrolledUnderElevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      Widget _banner;
      _banner = SizedBox();

      // if (controller.banners.isEmpty) {
      //   _banner = SizedBox();
      // } else {
      //   _banner = _buildBannerView(context);
      // }
      Widget _bottomView;
      if (controller.plansList.isEmpty) {
        _bottomView = SizedBox();
      } else {
        _bottomView = _buildBottomView(context);
      }
      if (controller.loadState.value.isFailure) {
        return Column(
          children: [
            _banner,
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
      } else if (controller.plansList.isEmpty &&
          controller.loadState.value.isSuccess) {
        return Column(
          children: [
            Expanded(
              child: EmptyView(
                description: 'no_available_plans_label'.tr,
                topImage: Assets.images.imgDeviceConnectEmpty.image(
                  width: 150,
                  height: 150,
                ),
                showBtn: false,
              ),
            ),
            _bottomView,
          ],
        );
      }
      return Column(
        children: [Expanded(child: _buildList(context, _banner)), _bottomView],
      );
    });
  }

  Widget _buildList(BuildContext context, Widget banner) {
    // return Obx(() {

    List<Widget> widgets = [];
    widgets.add(banner);

    for (int index = 0; index < controller.plansList.length; index++) {
      if (controller.productType.equalsIgnoreCase("4G_DATA")) {
        widgets.add(
          ValueAdd4gPackageCard(
            parentIndex: index,
            parentIsLast: index == controller.plansList.length - 1,
            selectPlanTag: controller.selectPlanTag.value,
            item: controller.plansList[index],
            onTapArrow: (value) {
              controller.updateSelectPlanTag(value);
            },
          ),
        );
      } else {
        widgets.add(
          ValueAddPackageCard(
            parentIndex: index,
            parentIsLast: index == controller.plansList.length - 1,
            selectPlanTag: controller.selectPlanTag.value,
            item: controller.plansList[index],
            onTapArrow: (value) {
              controller.updateSelectPlanTag(value);
            },
          ),
        );
      }
    }
    return ListView(children: widgets);
    // });
  }

  Widget _buildBannerView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 10),
          padding: EdgeInsets.only(left: 24, right: 24),
          width: double.maxFinite,
          height: 188,
          child: Text("data"),
          // CardSwiper(
          //   controller: controller.swiperController,
          //   cardsCount:
          //       controller.banners.isNotEmpty ? controller.banners.length : 0,
          //   onSwipe: controller.onSwipe,
          //   onUndo: controller.onUndo,
          //   numberOfCardsDisplayed: 1,
          //   allowedSwipeDirection: AllowedSwipeDirection.symmetric(
          //     horizontal: false,
          //     vertical: false,
          //   ),
          //   backCardOffset: const Offset(0, 0),
          //   padding: EdgeInsets.zero,
          //   cardBuilder: (
          //     context,
          //     index,
          //     horizontalThresholdPercentage,
          //     verticalThresholdPercentage,
          //   ) {
          //     if (controller.banners[index].imageUrl ==
          //         ValueAddProductServiceType.data4G.typeName) {
          //       return GestureDetector(
          //         child: SizedBox(
          //           height: 188,
          //           child: Assets.images.iconServiceData4gBanner.image(
          //             width: double.maxFinite,
          //             height: 188,
          //             fit: BoxFit.fill,
          //           ),
          //         ),
          //         onTap: () {},
          //       );
          //     } else {
          //       return GestureDetector(
          //         child: SizedBox(
          //           height: 188,
          //           child: Assets.images.iconServiceCloudBanner.image(
          //             width: double.maxFinite,
          //             height: 188,
          //             fit: BoxFit.fill,
          //           ),
          //         ),
          //         onTap: () {},
          //       );
          //     }
          //   },
          // ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            controller
                    .banners[controller.selectSwiperIndex.value]
                    .description ??
                "",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomView(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      width: double.maxFinite,
      height: 72,
      child:
          controller.loadState.value.isFailure
              ? BasicButton(
                style: BasicButtonStyle.blue,
                title: 'retry_btn'.tr,
                onPressed: () async {
                  await controller.refreshData(showLoading: true);
                },
                height: 44,
                useWidthDoubleInfinity: true,
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '${controller.selectCurrentSymbol.value}${_showPrice(controller.selectUnitAmount.value)}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: controller.selectCurrent.value,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BasicButton(
                    style: BasicButtonStyle.blue,
                    title: "subscribe_btn_in_buy_page".tr,
                    useCustomBorderRadius: false,
                    useWidthDoubleInfinity: false,
                    height: 40,
                    width: 120,
                    boxPadding: EdgeInsets.only(left: 15, right: 15),
                    onPressed: () async {
                      controller.clickSubcription(context);
                    },
                  ),
                ],
              ),
    );
  }

  String _showPrice(int unitAmount) {
    String price = "";
    if (unitAmount > -1) {
      double tPrice = unitAmount / 100.0;
      price = tPrice.toString();
    }
    return price;
  }
}
