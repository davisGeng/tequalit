import 'package:get/get.dart';
import 'package:value_add_web/WebPageSecond.dart';
import 'package:value_add_web/routes/routes.dart';



abstract class ValueAddRoutes {
  static GetPage route() {
    return GetPage(
      name: _ValueAddRouteNames.main,
      page: () => WebPageSecond(),
      // binding: ValueAddIndexBinding(),
      transition: Transition.fade,
      children: [
        // GetPage(
        //   name: _ValueAddRouteNames.VALUE_ADD_PACKAGE_CHOOSE,
        //   page: () => ValueAddPackageChooseView(),
        //   binding: ValueAddPackageChooseBinding(),
        //   transition: Transition.rightToLeft,
        // ),
        //
        // GetPage(
        //   name: _ValueAddRouteNames.VALUE_ADD_ORDER_LIST,
        //   page: () => const ValueAddOrderListView(),
        //   binding: ValueAddOrderListBinding(),
        // ),
        //
        // GetPage(
        //   name: _ValueAddRouteNames.VALUE_ADD_SUBSCRIPTION_LIST,
        //   page: () => const ValueAddSubscriptionListView(),
        //   binding: ValueAddSubscriptionListBinding(),
        // ),
      ],
    );
  }
}

abstract class _ValueAddRouteNames {
  _ValueAddRouteNames._();
  static const String main = '/';

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
