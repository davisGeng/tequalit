import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:value_add_web/common/utils/js_utils.dart';

import '../../assets/app_theme.dart';
import '../../services/app_service.dart';

// 假设你项目中存在的依赖（保持原有逻辑）
// 请根据实际项目调整导入路径
abstract mixin class LoadableWebController {
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

class LoadableWebScaffold extends StatelessWidget {
  /// 自定义导航栏（替代原有AppBar）
  final Widget? customNavBar;

  /// 顶部时间栏高度（Web端自定义）
  final double topBarHeight;

  /// 顶部时间栏背景色
  final Color topBarBgColor;

  /// 底部安全区域高度（Web端自定义）
  final double bottomSafeHeight;

  /// 底部安全区域背景色
  final Color bottomSafeBgColor;

  /// 页面背景色
  final Color? backgroundColor;

  /// 是否包裹自定义安全区域
  final bool isWrapSafeArea;

  /// 加载控制器
  final LoadableWebController? controller;

  /// 页面主体内容
  final Widget body;

  /// 加载中背景色
  final Color loadingBackgroundColor;

  /// 加载指示器颜色
  final Color? loadingColor;

  /// 加载提示文字样式
  final TextStyle? loadMessageTextStyle;

  final String? title;
  final Color? titleColor;
  final Widget? customLeadingWidget; //左侧自定义按钮
  final List<Widget>? actions; //右侧自定义按钮
  final Color? navBackColor;

  final double navHeight = 44;
  final VoidCallback? leadingOnTap;
  // 移除原有AppBar/title相关参数，新增自定义导航栏和安全区域参数
  const LoadableWebScaffold({
    super.key,
    this.customNavBar,
    this.title,
    this.titleColor = Colors.black,
    this.navBackColor = Colors.white,
    this.leadingOnTap,
    this.customLeadingWidget,
    this.actions,
    this.topBarHeight = 0.0, // 默认无顶部栏
    this.topBarBgColor = Colors.white,
    this.bottomSafeHeight = 0.0, // 默认无底部安全区域
    this.bottomSafeBgColor = Colors.white,
    this.backgroundColor,
    this.isWrapSafeArea = true,
    this.controller,
    this.loadingBackgroundColor = Colors.black,
    this.loadingColor = Colors.white,
    this.loadMessageTextStyle,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    // 确定页面背景色
    final Color pageBackgroundColor =
        backgroundColor ?? AppTheme.current.colors.background;

    return Scaffold(
      // 移除原生AppBar，改为在body中嵌入自定义导航栏
      backgroundColor: pageBackgroundColor,
      body:
          isWrapSafeArea
              ? _customSafeAreaWidget(context, pageBackgroundColor)
              : _buildBodyWithNavBar(context),
    );
  }

  /// 自定义安全区域Widget（适配Web端的顶部/底部栏）
  Widget _customSafeAreaWidget(
    BuildContext context,
    Color pageBackgroundColor,
  ) {
    double effectTopBarHeight =
        topBarHeight > 0
            ? topBarHeight
            : (topBarHeight < 0 ? 0 : JsUtils.instance.topBarHeight);
    double effectBottomBarHeight =
        bottomSafeHeight > 0
            ? bottomSafeHeight
            : (bottomSafeHeight < 0 ? 0 : JsUtils.instance.bottomBarHeight);
    debugPrint(
      "jsutils topH:${JsUtils.instance.topBarHeight},effetTop:$effectTopBarHeight",
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. 顶部时间栏背景（自定义高度和颜色）
        if (effectTopBarHeight > 0)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: effectTopBarHeight,
            child:
                controller != null
                    ? Obx(() {
                      // 加载中时使用页面背景色，否则使用自定义顶部栏背景色
                      return Container(
                        color:
                            controller?.isLoading.value == true
                                ? pageBackgroundColor
                                : topBarBgColor,
                      );
                    })
                    : Container(color: topBarBgColor),
          ),

        // 2. 底部安全区域背景（自定义高度和颜色）
        if (effectBottomBarHeight > 0)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: effectBottomBarHeight,
            child:
                controller != null
                    ? Obx(() {
                      // 加载中时使用页面背景色，否则使用自定义底部栏背景色
                      return Container(
                        color:
                            controller?.isLoading.value == true
                                ? pageBackgroundColor
                                : bottomSafeBgColor,
                      );
                    })
                    : Container(color: bottomSafeBgColor),
          ),

        // 3. 核心内容区域（避开顶部/底部自定义栏）
        Positioned.fill(
          top: effectTopBarHeight, // 顶部偏移对应自定义时间栏高度
          bottom: effectBottomBarHeight, // 底部偏移对应自定义安全区域高度
          child: _buildBodyWithNavBar(context),
        ),
      ],
    );
  }

  /// 构建包含自定义导航栏的主体内容
  Widget _buildBodyWithNavBar(BuildContext context) {
    Widget? topBarWidget;
    if (customNavBar != null) {
      topBarWidget = customNavBar;
    } else if (title != null) {
      Widget leftBtn =
          customLeadingWidget ??
          JsUtils.instance.buildPlatformBackIcon(leadingOnTap);
      List<Widget> rightBtns = actions ?? [];
      topBarWidget = Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: navHeight,
        color: navBackColor,
        child: Stack(
          children: [
            Positioned(top: 0, bottom: 0, left: 0, child: leftBtn),
            if (rightBtns.isNotEmpty)
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: Row(children: rightBtns),
              ),

            Center(
              child: Text(
                title ?? "",
                style: AppTheme.current.textStyles.title1.copyWith(
                  color: titleColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // 自定义导航栏（如果有）
        if (topBarWidget != null) topBarWidget,

        // 核心业务内容（占满剩余空间）
        Expanded(child: _buildCoreContent(context)),
      ],
    );
  }

  /// 构建核心业务内容（网络提示 + 加载状态 + 主体内容）
  Widget _buildCoreContent(BuildContext context) {
    final networkStatus = AppService.instance.isNetworkAvailable;
    if (controller == null) {
      return body;
    }
    return Obx(() {
      final List<Widget> widgets = [];

      // 网络异常提示
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

      // 主体内容（带加载状态）
      widgets.add(
        Expanded(child: controller == null ? body : _buildLoadableContent()),
      );

      return Column(mainAxisSize: MainAxisSize.max, children: widgets);
    });
  }

  /// 构建带加载状态的内容
  Widget _buildLoadableContent() {
    return Obx(() {
      final List<Widget> children = [body];

      // 加载中且需要显示加载组件时，叠加loading
      if (controller!.isLoading.value && controller!.showLoadingWidget.value) {
        children.add(_buildLoading());
      }

      return Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: children,
      );
    });
  }

  /// 加载组件
  Widget _buildLoading() => Center(
    child: Container(
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
  );
}
