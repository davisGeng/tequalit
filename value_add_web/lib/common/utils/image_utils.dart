import 'package:flutter/material.dart';

class ImageUtils {
  static Widget netImage(
    String imageUrl,
    double width,
    double height, {
    BoxFit fit = BoxFit.fill,
    String placeHolder = "",
  }) {
    placeHolder = placeHolder.isEmpty ? "img_default" : placeHolder;
    return Image.asset('assets/images/$placeHolder.png', width: width, height: height, fit: fit);
    // return FadeInImage.assetNetwork(
    //   placeholder: 'assets/images/$placeHolder.png', // 本地占位图
    //   image: imageUrl, // 网络图片
    //   width: width,
    //   height: height,
    //   fit: fit,
    // );
  }
}
