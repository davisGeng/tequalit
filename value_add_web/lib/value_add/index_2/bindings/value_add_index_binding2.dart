import '../controllers/value_add_index_controller2.dart';
import 'package:get/get.dart';

class ValueAddIndexBinding2 extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValueAddIndexController2>(() => ValueAddIndexController2());
  }
}
