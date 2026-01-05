import 'package:get/get.dart';
import 'package:sightsys/app/modules/value_add/order_list/controllers/value_add_order_list_controller.dart';

class ValueAddOrderListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValueAddOrderListController>(() => ValueAddOrderListController());
  }
}
