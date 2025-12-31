import 'package:flutter/material.dart';

import 'app_theme.dart';


class TextStyles {
  final TextStyle headline0 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppTheme.current.colors.title,
  );

  final TextStyle headline1 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppTheme.current.colors.title,
  );

  final TextStyle headline2 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppTheme.current.colors.title,
  );

  final TextStyle headline2While = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppTheme.current.colors.white,
  );

  final TextStyle headline3 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppTheme.current.colors.title,
  );

  final TextStyle headline4 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: AppTheme.current.colors.title,
  );

  final TextStyle headline3While = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppTheme.current.colors.white,
  );

  final TextStyle bodyText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.text,
  );

  final TextStyle bodyTextGray = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.gray1,
  );

  final TextStyle bodyTextBold = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppTheme.current.colors.text,
  );

  final TextStyle bodyText1 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.text,
  );

  final TextStyle bodyText1Gray = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.gray1,
  );

  final TextStyle bodyText2 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.text,
  );

  final TextStyle bodyText2Gray = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.gray1,
  );

  final TextStyle bodyText2White = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.white,
  );

  final TextStyle bodyText3 = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.text,
  );

  final TextStyle bodyText3White = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.white,
  );

  final TextStyle linkText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.linkText,
    decoration: TextDecoration.underline,
  );

  final TextStyle textFieldHint = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.textFieldHint,
  );

  final TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppTheme.current.colors.white,
  );

  final TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.gray1,
  );

  final TextStyle error = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppTheme.current.colors.red1,
  );

  final TextStyle dialogTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppTheme.current.colors.dialogTitle,
  );

  final TextStyle dialogMessage = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppTheme.current.colors.dialogMessage,
  );

  /// 一级标题
  /// 如果颜色不一致请使用copyWith
  final TextStyle title0 = const TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: Color(0xFF333333),
  );

  /// 二级标题
  /// 如果颜色不一致请使用copyWith
  final TextStyle title1 = const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Color(0xFF0E0E0E),
  );

  /// List-段标题
  /// 字号:14 颜色:0xFF000000 字重:400
  final TextStyle listSection = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Color(0xFF666666),
  );

  /// List-标题
  /// 字号:16，黑色，字重:500
  final TextStyle listTitle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Color(0xFF000000),
  );

  /// List-子标题/描述
  /// 字号:12，0xFF999999，字重:400
  final TextStyle listSubtitle = const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Color(0xFF999999),
  );

  /// List-尾部文案风格
  /// 字号:14，0xFF999999，字重:400
  final TextStyle listTrailing = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Color(0xFF999999),
  );

  /// 空布局文案
  final TextStyle empty = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Color(0xFF999999),
  );

  /// loading文案
  final TextStyle loading = const TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: Color(0xFFFFFFFF),
  );

  /// 权限Tile 标题
  final TextStyle permissionTileTitleStyle =
      const TextStyle(color: Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.w600);

  /// 权限Tile 副标题
  final TextStyle permissionTileSubTitleStyle =
      const TextStyle(color: Color(0xFF999999), fontSize: 12, fontWeight: FontWeight.w400);

  /// 权限Tile 右边更多按钮颜色
  final TextStyle permissionTileMoreStyle =
      const TextStyle(color: Color(0xFF0067E0), fontSize: 12, fontWeight: FontWeight.w400);
}
