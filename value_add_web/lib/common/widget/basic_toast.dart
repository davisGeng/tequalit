import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

abstract class BasicToast {
  BasicToast._();

  static void loading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..userInteractions = false;

    EasyLoading.show(dismissOnTap: false);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }

  static void error(String msg, {int duration = 2}) {
    EasyLoading.instance.errorWidget = SizedBox(
      width: 16,
      height: 16,
      child: IconButton(
        icon: Icon(Icons.close, size: 12, weight: 700), // 系统关闭图标（叉号）
        color: Colors.white, // 图标颜色（白色，与红色背景对比）
        onPressed: () {
          // 按钮点击回调（如关闭弹窗、提示等逻辑）
          // print("Payment failed dialog closed");
        },
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red), // 按钮背景色（红色）
          shape: MaterialStateProperty.all(CircleBorder()), // 圆形形状
          padding: MaterialStateProperty.all(EdgeInsets.all(0)), // 内边距（调整按钮大小）
          fixedSize: MaterialStateProperty.all(Size(16, 16)),
        ),
      ),
    );
    EasyLoading.showError(msg, duration: Duration(seconds: duration));
  }

  static void customerError(String msg, {int duration = 2}) {
    EasyLoading.instance.errorWidget = SizedBox(
      width: 16,
      height: 16,
      child: IconButton(
        icon: Icon(Icons.close, size: 12, weight: 700), // 系统关闭图标（叉号）
        color: Colors.white, // 图标颜色（白色，与红色背景对比）
        onPressed: () {
          // 按钮点击回调（如关闭弹窗、提示等逻辑）
          // print("Payment failed dialog closed");
        },
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red), // 按钮背景色（红色）
          shape: MaterialStateProperty.all(CircleBorder()), // 圆形形状
          padding: MaterialStateProperty.all(EdgeInsets.all(0)), // 内边距（调整按钮大小）
          fixedSize: MaterialStateProperty.all(Size(16, 16)),
        ),
      ),
    );
    // EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    // EasyLoading.instance.backgroundColor = Colors.black.withOpacity(0.6);
    // EasyLoading.instance.indicatorColor = Colors.grey;
    // EasyLoading.instance.textColor = Colors.white;
    // EasyLoading.instance.progressColor = Colors.grey;
    EasyLoading.showError(msg, duration: Duration(seconds: duration));
  }

  static void info(String msg, {int duration = 2}) {
    EasyLoading.showInfo(msg, duration: Duration(seconds: duration));
  }
}
