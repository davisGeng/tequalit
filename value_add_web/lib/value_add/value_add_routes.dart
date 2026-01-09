import 'package:get/get.dart';
import 'package:value_add_web/WebPageSecond.dart';
import 'package:value_add_web/main.dart';
import 'package:value_add_web/value_add/package_choose/bindings/value_add_package_choose_binding.dart';
import 'package:value_add_web/value_add/package_choose/views/value_add_package_choose_view.dart';
import 'package:value_add_web/value_add/subscription_list/bindings/value_add_subscription_list_binding.dart';
import 'package:value_add_web/value_add/subscription_list/view/value_add_subscription_list_view.dart';

import 'base/Webtoreatcts.dart';
import 'index/bindings/value_add_index_binding.dart';
import 'index/views/value_add_index_view.dart';
import 'order_list/bindings/value_add_order_list_binding.dart';
import 'order_list/views/value_add_order_list_view.dart';

abstract class ValueAddRoutes {
  static GetPage route() {
    return GetPage(
      name: _ValueAddRouteNames.main,
      page: () => HomePage(),
      // binding: ValueAddIndexBinding(),
      transition: Transition.fade,
      children: [
        GetPage(
          name: _ValueAddRouteNames.valueAddPackageChoose,
          page: () => ValueAddPackageChooseView(),
          binding: ValueAddPackageChooseBinding(),
          transition: Transition.rightToLeft,
        ),

        GetPage(
          name: _ValueAddRouteNames.valueAddOrderList,
          page: () => const ValueAddOrderListView(),
          binding: ValueAddOrderListBinding(),
          transition: Transition.rightToLeft,
        ),

        GetPage(
          name: _ValueAddRouteNames.valueAddSubscriptionList,
          page: () => const ValueAddSubscriptionListView(),
          binding: ValueAddSubscriptionListBinding(),
          transition: Transition.fade,
        ),
        GetPage(name: _ValueAddRouteNames.second, page: () => WebPageSecond()),
        GetPage(name: _ValueAddRouteNames.third, page: () => Webtoreatcts()),
      ],
    );
  }
}

// 1. 父路由名称改为独立模块路径（避免和全局'/'冲突）
abstract class _ValueAddRouteNames {
  _ValueAddRouteNames._();
  // 父路由：独立模块路径（Web端URL前缀）
  static const String main = '/value-add';

  // 子路由：小写+短横线（符合Web URL规范）
  static const valueAddPackageChoose = '/cloud-service-choose';
  static const valueAddOrderList = '/value-add-order-list';
  static const valueAddChooseDevice = '/value-add-choose-device';
  static const valueAddSubscriptionList = '/value-add-subscription-list';
  static const second = '/second';
  static const third = '/third';
}

// 2. 路径拼接（避免双斜杠）
abstract class ValueAddPaths {
  static const String main = _ValueAddRouteNames.main;

  // 拼接父路由+子路由（此时路径为：/value-add/cloud-service-choose）
  static const valueAddPackageChoose =
      '${_ValueAddRouteNames.main}${_ValueAddRouteNames.valueAddPackageChoose}';
  static const valueAddOrderList =
      '${_ValueAddRouteNames.main}${_ValueAddRouteNames.valueAddOrderList}';
  // 其他子路由同理...
  static const valueAddChooseDevice =
      '${_ValueAddRouteNames.main}${_ValueAddRouteNames.valueAddChooseDevice}';
  static const valueAddSubscriptionList =
      '${_ValueAddRouteNames.main}${_ValueAddRouteNames.valueAddSubscriptionList}';
  static const second =
      '${_ValueAddRouteNames.main}${_ValueAddRouteNames.second}';
  static const third =
      '${_ValueAddRouteNames.main}${_ValueAddRouteNames.third}';
}
