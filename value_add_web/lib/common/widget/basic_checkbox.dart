import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/app_theme.dart';

final class BasicCheckbox extends StatelessWidget {
  final RxBool value;
  const BasicCheckbox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Checkbox(
        value: value.value,
        onChanged: (v) => value.value = !value.value,
        activeColor: AppTheme.current.colors.main,
        shape: const CircleBorder()));
  }
}
