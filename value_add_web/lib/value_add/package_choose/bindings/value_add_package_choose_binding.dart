import 'package:get/get.dart';

import '../controllers/value_add_package_choose_controller.dart';

class ValueAddPackageChooseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValueAddPackageChooseController>(() => ValueAddPackageChooseController());
  }
}
