import 'package:get/get.dart';
import 'package:value_add_web/value_add/package_choose/bindings/value_add_package_choose_binding.dart';
import 'package:value_add_web/value_add/package_choose/views/value_add_package_choose_view.dart';
import 'package:value_add_web/value_add/subscription_list/bindings/value_add_subscription_list_binding.dart';
import 'package:value_add_web/value_add/subscription_list/view/value_add_subscription_list_view.dart';

import 'index/bindings/value_add_index_binding.dart';
import 'index/views/value_add_index_view.dart';
import 'order_list/bindings/value_add_order_list_binding.dart';
import 'order_list/views/value_add_order_list_view.dart';

abstract class ValueAddRoutes {
  static GetPage route() {
    return GetPage(
      name: _ValueAddRouteNames.main,
      page: () => ValueAddIndexView(),
      binding: ValueAddIndexBinding(),
      transition: Transition.fade,
      children: [
        GetPage(
          name: _ValueAddRouteNames.VALUE_ADD_PACKAGE_CHOOSE,
          page: () => ValueAddPackageChooseView(),
          binding: ValueAddPackageChooseBinding(),
          transition: Transition.rightToLeft,
        ),

        GetPage(
          name: _ValueAddRouteNames.VALUE_ADD_ORDER_LIST,
          page: () => const ValueAddOrderListView(),
          binding: ValueAddOrderListBinding(),
        ),
        // GetPage(
        //   name: _ValueAddRouteNames.CLOUD_SERVICE_ORDER_BUY,
        //   page: () => const CloudServiceOrderBuyView(),
        //   binding: CloudServiceOrderBuyBinding(),
        // ),
        GetPage(
          name: _ValueAddRouteNames.VALUE_ADD_SUBSCRIPTION_LIST,
          page: () => const ValueAddSubscriptionListView(),
          binding: ValueAddSubscriptionListBinding(),
        ),
      ],
    );
  }
}

abstract class _ValueAddRouteNames {
  _ValueAddRouteNames._();
  static const String main = '/value_add_index';

  static const VALUE_ADD_PACKAGE_CHOOSE = '/cloudServiceChoose';
  static const VALUE_ADD_ORDER_LIST = '/VALUE_ADD_ORDER_LIST';
  static const CLOUD_SERVICE_ORDER_BUY = '/cloud-service-order-buy';
  static const VALUE_ADD_CHOOSE_DEVICE = '/VALUE_ADD_CHOOSE_DEVICE';
  static const VALUE_ADD_SUBSCRIPTION_LIST = '/VALUE_ADD_SUBSCRIPTION_LIST';
}

abstract class ValueAddPaths {
  static const String main = _ValueAddRouteNames.main;

  static const VALUE_ADD_PACKAGE_CHOOSE = _ValueAddRouteNames.main + _ValueAddRouteNames.VALUE_ADD_PACKAGE_CHOOSE;
  static const VALUE_ADD_ORDER_LIST = _ValueAddRouteNames.main + _ValueAddRouteNames.VALUE_ADD_ORDER_LIST;
  static const CLOUD_SERVICE_ORDER_BUY = _ValueAddRouteNames.main + _ValueAddRouteNames.CLOUD_SERVICE_ORDER_BUY;
  static const VALUE_ADD_CHOOSE_DEVICE = _ValueAddRouteNames.main + _ValueAddRouteNames.VALUE_ADD_CHOOSE_DEVICE;
  static const VALUE_ADD_SUBSCRIPTION_LIST = _ValueAddRouteNames.main + _ValueAddRouteNames.VALUE_ADD_SUBSCRIPTION_LIST;
}
