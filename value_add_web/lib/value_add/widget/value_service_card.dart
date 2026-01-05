import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dart_extensions/dart_extensions.dart';

import '../../common/utils/image_utils.dart';
import '../../gen/assets.gen.dart';
import '../../model/value_add_product_response.dart';

class ValueServiceCard extends StatelessWidget {
  final int index;
  final double radius;
  final ValueAddProductItem item;
  final bool isHead;
  final bool isTrail;
  final ValueChanged<ValueAddProductItem>? onTapArrow;

  const ValueServiceCard({
    Key? key,
    required this.item,
    required this.index,
    this.isHead = false,
    this.isTrail = false,
    this.radius = 5,
    this.onTapArrow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Radius tl = Radius.circular(radius);
    Radius tr = Radius.circular(radius);
    Radius bl = Radius.circular(radius);
    Radius br = Radius.circular(radius);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 15, top: 17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: tl, topRight: tr, bottomLeft: bl, bottomRight: br),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getImage(item.iconUrl ?? ""),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name ?? "", style: TextStyle(fontSize: 22)).marginOnly(bottom: 10),
                    Text(
                      item.description ?? "",
                      style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                width: 76,
                height: 40,
                padding: EdgeInsets.only(right: 15),
                alignment: Alignment.centerRight,
                child:
                    item.serviceStatus.equalsIgnoreCase("AVAILABLE")
                        ? Assets.images.iconServiceRightArrow.image(width: 40, height: 40, fit: BoxFit.fill).onTap(() {
                          onTapArrow?.call(item);
                        })
                        : null,
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              !item.serviceStatus.equalsIgnoreCase("AVAILABLE")
                  ? Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF0067E0),
                      borderRadius: BorderRadius.only(topLeft: tl, bottomRight: br),
                    ),
                    width: 76,
                    height: 20,
                    child: Text('coming_soon_label'.tr, style: TextStyle(fontSize: 10, color: Colors.white)),
                  )
                  : SizedBox(height: 17),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getImage(String imageUrl) {
    // imageUrl = "https://img0.baidu.com/it/u=3012106961,3443669333&fm=253&fmt=auto&app=138&f=JPG?w=500&h=500";
    // "https://api.iconify.design/ri/wechat-pay-fill.svg?height=64&color=%2307C160";
    String placeHolder = "";
    if (item.type == "CLOUD_STORAGE") {
      placeHolder = "icon_service_cloud";
    } else if (item.type == "4G_DATA") {
      placeHolder = "icon_service_4g";
    } else {
      placeHolder = "";
    }
    return ImageUtils.netImage(imageUrl, 70, 50, placeHolder: placeHolder).marginOnly(bottom: 15);
  }
}
