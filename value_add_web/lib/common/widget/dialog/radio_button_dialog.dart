import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/app_theme.dart';
import '../basic_button.dart';
import 'basic_dialog.dart';

abstract mixin class RadioButtonItem {
  String get title;
  String get subtitle;

  static RadioButtonItem create(String title, String subtitle) {
    return _RadioButtonItem(title, subtitle);
  }
}

final class _RadioButtonItem implements RadioButtonItem {
  @override
  final String title;
  @override
  final String subtitle;
  const _RadioButtonItem(this.title, this.subtitle);
}

final class RadioButtonController<T extends RadioButtonItem> {
  final List<T> _items;

  RadioButtonController({
    required List<T> items,
    int? index,
  })  : _items = items,
        _index = Rx<int?>(index);

  int? get index {
    return _index.value;
  }

  T? get item {
    final index = this.index;
    if (index == null) {
      return null;
    }
    return _items[index];
  }

  final Rx<int?> _index;
}

class RadioButtonDialog extends StatelessWidget {
  final String title;
  final RadioButtonController controller;
  final VoidCallback? onEnterPressed;
  final VoidCallback? onCancelPressed;

  const RadioButtonDialog({
    super.key,
    required this.title,
    required this.controller,
    this.onEnterPressed,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BasicDialog(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 10),
          _buildRadioList(),
          const SizedBox(height: 30),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return SizedBox(
      height: kToolbarHeight,
      child: Center(child: Text(title, style: AppTheme.current.textStyles.dialogTitle)),
    );
  }

  _RadioButtonList _buildRadioList() {
    return _RadioButtonList(controller: controller);
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BasicButton(
            title: 'confirm_btn'.tr,
            onPressed: () {
              if (onEnterPressed == null) {
                Get.back();
              } else {
                onEnterPressed!();
              }
            },
            style: BasicButtonStyle.black1,
          ),
          const SizedBox(height: 10),
          BasicButton(
            title: 'cancel_btn'.tr,
            onPressed: () {
              if (onCancelPressed == null) {
                Get.back();
              } else {
                onCancelPressed!();
              }
            },
            style: BasicButtonStyle.white1,
          ),
        ],
      ),
    );
  }
}

class _RadioButtonList extends StatelessWidget {
  final RadioButtonController controller;

  const _RadioButtonList({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: controller._items.map((item) {
            return RadioListTile<int>(
              title: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: AppTheme.current.textStyles.listTitle),
                        if (item.subtitle.trim().isNotEmpty)
                          Text(item.subtitle, style: AppTheme.current.textStyles.listSubtitle),
                      ],
                    ),
                  ),
                ],
              ),
              value: controller._items.indexWhere((element) => element.title == item.title),
              groupValue: controller._index.value,
              onChanged: (value) => controller._index.value = value,
              controlAffinity: ListTileControlAffinity.trailing,
            );
          }).toList(),
        ));
  }
}
