import 'package:get/get.dart';

import '../controllers/value_add_index_controller.dart';

class ValueAddIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValueAddIndexController>(
      () => ValueAddIndexController(),
    );
  }
}
