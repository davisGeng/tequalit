import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/app_theme.dart';

abstract class BasicSnack {
  BasicSnack._();

  static const int _defaultDuration = 2;
  static const SnackPosition _defaultPosition = SnackPosition.TOP;
  static const double _defaultOpacity = 0.8;

  static void show(String title, String message,
      {int duration = _defaultDuration, SnackPosition position = _defaultPosition, VoidCallback? onClosed}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      duration: Duration(seconds: duration),
      backgroundColor: AppTheme.current.colors.gray1.withOpacity(_defaultOpacity),
      colorText: AppTheme.current.colors.white,
      icon: Icon(Icons.message, color: AppTheme.current.colors.white),
      isDismissible: true,
      snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED && onClosed != null) {
          onClosed();
        }
      },
    );
  }

  static void success(String message,
      {int duration = _defaultDuration, SnackPosition position = _defaultPosition, VoidCallback? onClosed}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'success_label'.tr,
      message,
      snackPosition: position,
      duration: Duration(seconds: duration),
      backgroundColor: AppTheme.current.colors.green1.withOpacity(_defaultOpacity),
      colorText: AppTheme.current.colors.white,
      icon: Icon(Icons.check_circle, color: AppTheme.current.colors.white),
      isDismissible: true,
      snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED && onClosed != null) {
          onClosed();
        }
      },
    );
  }

  static void error(String message,
      {int duration = _defaultDuration, SnackPosition position = _defaultPosition, VoidCallback? onClosed}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'failed_label'.tr,
      message,
      snackPosition: position,
      duration: Duration(seconds: duration + 1),
      backgroundColor: AppTheme.current.colors.red1.withOpacity(_defaultOpacity),
      colorText: AppTheme.current.colors.white,
      icon: Icon(Icons.cancel, color: AppTheme.current.colors.white),
      isDismissible: true,
      snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED && onClosed != null) {
          onClosed();
        }
      },
    );
  }

  static void info(String message,
      {int duration = _defaultDuration, SnackPosition position = _defaultPosition, VoidCallback? onClosed}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'info_label'.tr,
      message,
      snackPosition: position,
      duration: Duration(seconds: duration),
      backgroundColor: AppTheme.current.colors.blue1.withOpacity(_defaultOpacity),
      colorText: AppTheme.current.colors.white,
      icon: Icon(Icons.info, color: AppTheme.current.colors.white),
      isDismissible: true,
      snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED && onClosed != null) {
          onClosed();
        }
      },
    );
  }
}
