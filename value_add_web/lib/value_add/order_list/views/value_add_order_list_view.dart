import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_refresh/easy_refresh.dart';

import '../../../../../../assets/app_theme.dart';
import '../../../assets/assets.gen.dart';
import '../../../common/utils/text_utils.dart';
import '../../../common/widget/empty_view.dart';
import '../../../common/widget/loadable_scaffold.dart';
import '../../../model/value_add_order_list_response.dart';
import '../controllers/value_add_order_list_controller.dart';

class ValueAddOrderListView extends GetView<ValueAddOrderListController> {
  const ValueAddOrderListView({super.key});
  @override
  Widget build(BuildContext context) {
    return LoadableScaffold(
      appBar: _buildAppBar(context),
      backgroundColor: AppTheme.current.colors.inverseBackground,
      body: _buildBody(context),
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
      title: Text('orders_nav_title'.tr, style: AppTheme.current.textStyles.title1),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: <Widget>[],
    );
  }

  Widget _buildBody(BuildContext context) {
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
      } else if (controller.orders.isEmpty && controller.loadState.value.isSuccess) {
        return EmptyView(
          description: 'orders_no_histry_warning_label'.tr,
          topImage: Assets.images.imgDeviceConnectEmpty.image(width: 150, height: 150),
          showBtn: false,
        );
      }
      return _buildRefreshView(context);
    });
  }

  Widget _buildRefreshView(BuildContext context) => EasyRefresh(
    controller: controller.refreshController,
    refreshOnStart: false,
    header: const CupertinoHeader(),
    footer: const CupertinoFooter(emptyWidget: SizedBox.shrink()),
    onRefresh: () => controller.refreshData(),
    onLoad: () => controller.onLoad(),
    child: Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: _buildList(context),
    ),
  );
  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.orders.length,
      itemBuilder: (context, index) {
        return Obx(() {
          return OrderItemView(
            order: controller.orders[index],
            index: index,
            callback: () {
              // controller.selectIndex.value = index;
            },
          );
        });
      },
    );
  }
}

class OrderItemView extends StatelessWidget {
  final ValueAddOrderItem order;
  final int index;
  final VoidCallback callback;

  const OrderItemView({super.key, required this.order, required this.index, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 20),
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8)), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  // alignment: Alignment.topCenter,
                  child: Text(
                    getPackageName(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                buildRow('plan_validity_label'.tr, '${getInterval()} ${'plan_days_label'.tr}', 0),
                buildRow('orders_order_id_label'.tr, TextUtils.getStringWithOption(order.orderNumber), 0),
                buildRow('payment_method_menu_title'.tr, TextUtils.getStringWithOption(order.paymentChannel), 0),

                buildRow('orders_order_date_label'.tr, TextUtils.getStringWithOption(order.getPaidTime()), 0),
                buildRow('orders_deviceid_label'.tr, TextUtils.getStringWithOption(order.deviceThirdPartId), 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                        children: [
                          TextSpan(
                            text: TextUtils.getStringWithOption(order.totalAmountDisplay),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0B6288)),
                          ),
                          TextSpan(
                            text: TextUtils.getStringWithOption(order.currency),
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0B6288)),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      TextUtils.getStringWithOption(order.status),
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF0B6288)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String dataPriceValue() {
    return '${TextUtils.getStringWithOption(order.totalAmountDisplay)}${TextUtils.getStringWithOption(order.currency)}';
  }

  Widget buildRow(String label, String value, double bottomMargin) {
    return Container(
      // color: Colors.white,
      margin: EdgeInsets.only(bottom: bottomMargin),
      child: Row(
        children: [
          Text(
            label,
            style: AppTheme.current.textStyles.listTrailing.copyWith(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.53,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 15, color: Color(0xFF666666), height: 1.53),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  String getPackageName() => order.orderProductItems?.firstOrNull?.planNameSnapshot ?? "";
  String getInterval() {
    String billingType = order.billingType ?? "";
    return billingType == 'month' ? "30" : (billingType == 'year' ? "365" : "7");
  }

  OrderProductItem? productItem() {}
}
