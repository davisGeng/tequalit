import 'dart:async';

import 'package:get/get.dart';

import '../../services/log_service.dart';

///  触摸显示/隐藏
mixin TouchToggleMixin on GetxController {
  final _kHiddenDelay = 3;
  final hiddenState = false.obs;
  Timer? _timer;

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }

  void disableHiddenAction() {
    _timer?.cancel();
    hiddenState.value = false;
  }

  void delayHiddenAction() {
    if (hiddenState.isFalse) {
      _timer?.cancel();
      _timer = Timer(Duration(seconds: _kHiddenDelay), () {
        hiddenState.value = true;
      });
    }
  }

  void onTapDown() {
    hiddenState.value = !hiddenState.value;
    _timer?.cancel();
  }

  void onTapUp() {
    delayHiddenAction();
  }

  void toggleHidden() {
    Log.d("Touch toggle mixin");

    hiddenState.value = !hiddenState.value;
    _timer?.cancel();
    delayHiddenAction();
  }
}
