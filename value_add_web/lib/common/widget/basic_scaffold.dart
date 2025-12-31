import 'package:flutter/material.dart';

import '../../assets/app_theme.dart';

class BasicScaffold extends StatelessWidget {
  final String? title;
  final AppBar? appBar;
  final Color? backgroundColor;
  final bool bodyWrapSafeArea;
  final Widget body;
  final Color titleBackgroundColor;
  final bool centerTitle;

  BasicScaffold({
    super.key,
    this.title,
    this.appBar,
    this.backgroundColor,
    this.bodyWrapSafeArea = true,
    required this.body,
    this.centerTitle = true,
    Color? titleBgColor,
  }) : titleBackgroundColor = titleBgColor ?? AppTheme.current.colors.inverseTitle;

  @override
  Widget build(BuildContext context) {
    AppBar? appBar;
    if (this.appBar != null) {
      appBar = this.appBar;
    } else if (title != null) {
      appBar = AppBar(
        title: Text(title!, style: AppTheme.current.textStyles.title1),
        centerTitle: centerTitle,
        backgroundColor: titleBackgroundColor,
      );
    }
    Color backgroundColor = this.backgroundColor ?? AppTheme.current.colors.background;
    return Scaffold(
        appBar: appBar, body: bodyWrapSafeArea ? SafeArea(child: body) : body, backgroundColor: backgroundColor);
  }
}
