import 'package:get/get.dart';

import '../controllers/value_add_order_list_controller.dart';

class ValueAddOrderListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValueAddOrderListController>(() => ValueAddOrderListController());
  }
}
