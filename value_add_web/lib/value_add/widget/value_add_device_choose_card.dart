import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

import '../../assets/assets.gen.dart';
import '../../model/check_device_available_by_plan_response.dart';

class ValueAddDeviceChooseCard extends StatelessWidget {
  final int index;
  final int selectIndex;
  final bool isLast;
  final double radius;
  final DeviceAvailableResults item;
  final ValueChanged<int>? onTap;

  const ValueAddDeviceChooseCard({
    Key? key,
    required this.item,
    required this.index,
    required this.selectIndex,
    this.radius = 5,
    this.isLast = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: index == 0 ? Radius.circular(radius) : Radius.zero,
          topRight: index == 0 ? Radius.circular(radius) : Radius.zero,
          bottomLeft: isLast ? Radius.circular(radius) : Radius.zero,
          bottomRight: isLast ? Radius.circular(radius) : Radius.zero,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 223,
                child: Row(
                  children: [
                    Assets.images.iconBleDevice.image(width: 40, height: 40, fit: BoxFit.fill).marginOnly(right: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.deviceName ?? "",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).marginOnly(bottom: 4),
                          Text(
                            'DID:${item.thirdPartDeviceId}',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF999999)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (item.compatible)
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child:
                      selectIndex == index
                          ? Assets.images.iconCheckboxSingleSelected.image(width: 20, height: 20, fit: BoxFit.fill)
                          : Assets.images.iconRadioBox.image(width: 20, height: 20),
                ),

              if (!item.compatible)
                Expanded(
                  flex: Get.locale?.languageCode == "zh" ? 42 : 90,
                  child: Text(
                    "not_supported_label".tr,
                    textAlign: TextAlign.end,
                    softWrap: true, // 关键：允许折行
                    style: TextStyle(fontSize: 11, color: Color(0xFF666666)), // 可自定义样式
                    // overflow: TextOverflow.clip, // 可选：溢出时裁剪（也可根据需求用其他值）
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          if (!isLast) Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        ],
      ),
    ).onTap(() {
      if (item.compatible) {
        onTap?.call(index);
      }
    });
  }
}
