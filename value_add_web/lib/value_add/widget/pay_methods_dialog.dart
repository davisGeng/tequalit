import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/assets.gen.dart';
import '../../common/utils/image_utils.dart';
import '../../common/widget/basic_button.dart';
import '../../model/value_add_product_response.dart';

class PayMethodsDialog extends StatefulWidget {
  int selectIndex;
  final List<SupportedPaymentChannels> platforms;
  final double radius;
  final ValueChanged<int>? onTap;

  PayMethodsDialog({super.key, required this.platforms, this.selectIndex = 0, this.radius = 10, this.onTap});

  // 创建对应的 State 对象
  @override
  State<PayMethodsDialog> createState() => _PayMethodsDialog();
}

class _PayMethodsDialog extends State<PayMethodsDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(minHeight: 100, maxHeight: 350),
      padding: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.radius),
          topRight: Radius.circular(widget.radius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          SizedBox(height: 15),
          _buildList(context),
          BasicButton(
            style: BasicButtonStyle.blue,
            title: 'pay_now_btn'.tr,
            onPressed: () {
              widget.onTap?.call(widget.selectIndex);
            },
            height: 44,
            // boxPadding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          ).marginOnly(top: 30, bottom: 10 + 34),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          // color: Colors.orange,
          height: 70,
          child: Text(
            'payment_method_menu_title'.tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: double.maxFinite,
          height: 70,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1))),
          child: Assets.images.iconClose.image(width: 16, height: 16, fit: BoxFit.fill, color: Colors.grey).onTap(() {
            Get.back();
          }),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.platforms.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _getMethodIcon(widget.platforms[index]),
                  Text(widget.platforms[index].name ?? "", style: TextStyle(fontSize: 16)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectIndex = index;
                  });
                },
                child:
                    widget.selectIndex == index
                        ? Assets.images.iconCheckboxSingleSelected.image(width: 24, height: 24, fit: BoxFit.fill)
                        : Assets.images.iconRadioBox.image(width: 24, height: 24, fit: BoxFit.fill),
              ),
            ],
          ).marginOnly(top: 15);
        },
      ),
    );
  }

  Widget _getMethodIcon(SupportedPaymentChannels method) {

    return ImageUtils.netImage(method.icon ?? "", 40, 40, fit: BoxFit.fill).marginOnly(right: 14);
  }
}
