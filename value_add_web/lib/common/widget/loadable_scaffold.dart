import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/app_theme.dart';
import '../../services/app_service.dart';

abstract mixin class LoadableController {
  final isLoading = false.obs;
  final loadingMessage = ''.obs;
  final showLoadingWidget = true.obs;

  void startLoading({String withMessage = ""}) {
    isLoading.value = true;
    loadingMessage.value = withMessage;
  }

  void stopLoading() {
    isLoading.value = false;
  }
}

/// 可加载的脚手架
/// title(二级标题栏风格)
class LoadableScaffold extends StatelessWidget {
  final String? title;
  final AppBar? appBar;
  final Color? backgroundColor;
  final bool isWrapSafeArea;
  final LoadableController? controller;
  final Widget body;
  final bool centerTitle;
  final Color titleBackgroundColor;
  final Color loadingBackgroundColor;
  final Color? loadingColor;
  final TextStyle? loadMessageTextStyle;
  final IconThemeData? iconTheme;
  final Color? titleColor;
  final List<Widget>? actions;
  final Color? bottomSafeAreaBackgroundColor;

  LoadableScaffold({
    super.key,
    this.title,
    this.appBar,
    this.backgroundColor,
    this.isWrapSafeArea = true,
    this.controller,
    this.centerTitle = true,
    Color? titleBgColor,
    this.loadingBackgroundColor = Colors.black,
    this.loadingColor = Colors.white,
    this.loadMessageTextStyle,
    this.iconTheme,
    this.titleColor,
    this.actions,
    required this.body,
    this.bottomSafeAreaBackgroundColor,
  }) : titleBackgroundColor =
           titleBgColor ?? AppTheme.current.colors.inverseTitle;

  @override
  Widget build(BuildContext context) {
    AppBar? appBar;
    if (this.appBar != null) {
      appBar = this.appBar;
    } else if (title != null) {
      appBar = AppBar(
        centerTitle: centerTitle,
        backgroundColor: titleBackgroundColor,
        iconTheme: iconTheme,
        title: Text(
          title!,
          style: AppTheme.current.textStyles.title1.copyWith(color: titleColor),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        actions: actions,
      );
    }
    Color backgroundColor =
        this.backgroundColor ?? AppTheme.current.colors.background;
    Color bottom_SafeBackColor = backgroundColor;
    if (bottomSafeAreaBackgroundColor != null) {
      bottom_SafeBackColor = bottomSafeAreaBackgroundColor ?? backgroundColor;
    }

    return Scaffold(
      appBar: appBar,
      body:
          isWrapSafeArea
              ? _safeAreaCustomWidget(
                context,
                bottom_SafeBackColor,
                backgroundColor,
              )
              : _buildBody(context),
      backgroundColor: backgroundColor,
    );
  }

  Widget _safeAreaCustomWidget(
    BuildContext context,
    Color safeAreaColor,
    Color backgroudColor,
  ) {
    final double bottomSafeHeight = MediaQuery.of(context).padding.bottom;

    return Stack(
      fit: StackFit.expand, // 让子组件填满整个屏幕
      children: [
        // 底层：底部安全区域背景（蓝色，仅占安全区域高度）
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: bottomSafeHeight, // 与底部安全区域高度一致
          child: Obx(() {
            if (controller!.isLoading.value) {
              return Container(
                color: backgroudColor, // 底部安全区域单独背景色
              );
            }
            return Container(
              color: safeAreaColor, // 底部安全区域单独背景色
            );
          }),
        ),

        // 上层：业务内容（避开安全区域）
        SafeArea(child: _buildBody(context)),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final networkStatus = AppService.instance.isNetworkAvailable;

    return Obx(() {
      List<Widget> widgets = [];

      if (!networkStatus.value) {
        widgets.add(
          Container(
            color: AppTheme.current.colors.red1,
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.error, color: AppTheme.current.colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "err_no_internet_connection".tr,
                    style: TextStyle(color: AppTheme.current.colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      widgets.add(
        Expanded(child: controller == null ? body : _buildLoadableContent()),
      );

      return Column(mainAxisSize: MainAxisSize.min, children: widgets);
    });
  }

  Widget _buildLoadableContent() {
    if (controller == null) {
      return body;
    } else {
      return Obx(() {
        final children =
            controller!.isLoading.value && controller!.showLoadingWidget.value
                ? [body, _buildLoading()]
                : [body];
        return Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: children,
        );
      });
    }
  }

  /// loading组建
  Widget _buildLoading() => Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          color: loadingBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                loadingColor ?? AppTheme.current.colors.main,
              ),
            ),
            if (controller?.loadingMessage.isNotEmpty ?? false)
              const SizedBox(height: 8),
            if (controller?.loadingMessage.isNotEmpty ?? false)
              Text(
                controller?.loadingMessage.value ?? '',
                style:
                    loadMessageTextStyle ?? AppTheme.current.textStyles.loading,
                maxLines: 1,
              ),
          ],
        ),
      ),
    ],
  );
}
