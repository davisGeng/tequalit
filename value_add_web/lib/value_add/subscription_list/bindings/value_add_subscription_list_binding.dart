import 'package:get/get.dart';

import '../controllers/value_add_subscription_list_controller.dart';

class ValueAddSubscriptionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValueAddSubscriptionListController>(() => ValueAddSubscriptionListController());
  }
}
