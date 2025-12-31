import 'dart:math';

import 'package:flutter/material.dart';

import '../../assets/app_theme.dart';
import '../../assets/assets.gen.dart';
import '../utils/text_utils.dart';

class BasicButton extends StatefulWidget {
  final BasicButtonStyle style;
  final String title;
  final VoidCallback? onPressed;
  final double width;
  final double? height;
  final bool? useWidthDoubleInfinity; //默认使用
  final EdgeInsets? boxPadding; // 默认为null
  final bool? useCustomBorderRadius; //默认不使用
  final double? customBorderRadius; // 默认0

  bool get enabled => onPressed != null;

  const BasicButton({
    super.key,
    required this.style,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.height,
    this.useWidthDoubleInfinity = true,
    this.boxPadding = EdgeInsets.zero,
    this.useCustomBorderRadius = false,
    this.customBorderRadius = 0,
  });

  factory BasicButton.styled(
    BasicButtonStyle style, {
    required String title,
    required VoidCallback? onPressed,
    double? width,
    double? height,
    bool? useWidthDoubleInfinity,
    EdgeInsets? boxPadding,
    bool? useCustomBorderRadius,
    double? customBorderRadius,
  }) {
    return BasicButton(
      style: style,
      title: title,
      onPressed: onPressed,
      width: width ?? double.infinity,
      height: height ?? style.defaultHeight,
      useWidthDoubleInfinity: useWidthDoubleInfinity,
      boxPadding: boxPadding,
      useCustomBorderRadius: useCustomBorderRadius,
      customBorderRadius: customBorderRadius,
    );
  }

  @override
  State<BasicButton> createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.enabled;
    final color = widget.style.color;
    final disabledColor = widget.style.disabledColor;
    final width = widget.width;
    final height = widget.height ?? widget.style.defaultHeight;
    final useWidthDoubleInfinity = widget.useWidthDoubleInfinity ?? true;
    final boxPadding = widget.boxPadding ?? EdgeInsets.zero;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPressed,
      child: Semantics(
        button: true,
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(
            Size(_resetBoxWidth(width, useWidthDoubleInfinity, boxPadding, enabled), height),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(widget.useCustomBorderRadius == true ? widget.customBorderRadius ?? 0 : height * 0.5),
              ),
              color: enabled ? color : disabledColor,
              border: widget.style.border,
            ),
            child: _buildContent(enabled),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool enabled) {
    final accessory = enabled ? widget.style.accessoryWidget : widget.style.disabledAccesoryWidget;
    List<Widget> children = [_buildTitle(enabled)];
    if (accessory != null) {
      children.add(const SizedBox(width: 2));
      children.add(accessory);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildTitle(bool enabled) {
    return Text(widget.title, style: enabled ? widget.style.textStyle : widget.style.disabledTextStyle);
  }

  double _resetBoxWidth(double width, bool useWidthDoubleInfinity, EdgeInsets boxPadding, bool enabled) {
    double backWid = width;
    if (!useWidthDoubleInfinity && width != double.infinity) {
      double calculateWidth = TextUtils.calculateSingleLineWidth(
        text: widget.title,
        style: enabled ? widget.style.textStyle : widget.style.disabledTextStyle,
      );
      if (boxPadding != EdgeInsets.zero) {
        double pWidth = calculateWidth + boxPadding.left + boxPadding.right;
        backWid = max(width, pWidth);
      } else {
        backWid = calculateWidth;
      }
    }
    return backWid;
  }
}

enum BasicButtonStyle {
  linkButton,
  hollowSmall,
  hollowBlue,
  hollowGray,
  whiteBackgroundRedText,
  white0,
  white1,
  white2,
  white3,
  white4,
  black1,
  black2,
  gray1,
  gray2,
  red1,
  red2,
  red3,
  red4,
  blue;

  double get defaultHeight {
    switch (this) {
      case linkButton:
        return 44;
      case hollowSmall:
        return 28;
      case hollowBlue:
      case hollowGray:
        return 34;
      case whiteBackgroundRedText:
      case white0:
      case white1:
        return 44;
      case white2:
        return 34;
      case white3:
        return 28;
      case white4:
        return 28;
      case black1:
        return 44;
      case black2:
        return 34;
      case gray1:
        return 28;
      case gray2:
        return 44;
      case red1:
        return 44;
      case red2:
        return 34;
      case red3:
        return 28;
      case red4:
        return 28;
      case blue:
        return 44;
    }
  }

  Color get color {
    switch (this) {
      case linkButton:
        return AppTheme.current.colors.transparent;
      case hollowSmall:
        return AppTheme.current.colors.transparent;
      case hollowGray:
        return AppTheme.current.colors.transparent;
      case hollowBlue:
        return AppTheme.current.colors.blue2;
      case whiteBackgroundRedText:
      case white0:
        return AppTheme.current.colors.white;
      case white1:
      case white2:
      case white3:
      case white4:
        return AppTheme.current.colors.blue2;
      case black1:
      case black2:
        return AppTheme.current.colors.black;
      case gray1:
      case gray2:
        return AppTheme.current.colors.black.withOpacity(0.4);
      case red1:
      case red2:
      case red3:
      case red4:
        return const Color(0xFFFFF1F1);
      case blue:
        return const Color(0xFF0067E0);
    }
  }

  Color get disabledColor {
    switch (this) {
      case linkButton:
        return AppTheme.current.colors.gray2;
      case hollowSmall:
        return AppTheme.current.colors.transparent;
      case hollowGray:
        return AppTheme.current.colors.transparent;
      case hollowBlue:
        return AppTheme.current.colors.gray2;
      case whiteBackgroundRedText:
      case white0:
        return AppTheme.current.colors.white;
      case white1:
      case white2:
      case white3:
      case white4:
        return AppTheme.current.colors.blue2;
      case black1:
      case black2:
        return AppTheme.current.colors.black;
      case gray1:
      case gray2:
        return AppTheme.current.colors.black.withOpacity(0.4);
      case red1:
      case red2:
      case red3:
      case red4:
        return const Color(0xFFFFF1F1);
      case blue:
        return AppTheme.current.colors.disableBackground;
    }
  }

  TextStyle get textStyle {
    final Color color;
    final double fontSize;
    final FontWeight fontWeight;
    switch (this) {
      case linkButton:
        return TextStyle(
          color: AppTheme.current.colors.blue1,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
          decorationColor: AppTheme.current.colors.blue1,
        );
      case hollowSmall:
        return TextStyle(color: AppTheme.current.colors.white, fontSize: 12, fontWeight: FontWeight.w400);
      case hollowGray:
        return TextStyle(color: AppTheme.current.colors.gray1, fontSize: 14, fontWeight: FontWeight.w400);
      case hollowBlue:
        return TextStyle(color: AppTheme.current.colors.black, fontSize: 14, fontWeight: FontWeight.w400);
      case whiteBackgroundRedText:
        color = AppTheme.current.colors.red1;
        fontSize = 16;
        fontWeight = FontWeight.w400;
      case white0:
      case white1:
        color = AppTheme.current.colors.black;
        fontSize = 16;
        fontWeight = FontWeight.w400;
      case white2:
        color = AppTheme.current.colors.black;
        fontSize = 14;
        fontWeight = FontWeight.w400;
      case white3:
        color = const Color(0xFF0067E0);
        fontSize = 12;
        fontWeight = FontWeight.w400;
      case white4:
        color = const Color(0xFF0067E0);
        fontSize = 12;
        fontWeight = FontWeight.w400;
      case black1:
        color = AppTheme.current.colors.white;
        fontSize = 16;
        fontWeight = FontWeight.w400;
      case black2:
        color = AppTheme.current.colors.white;
        fontSize = 14;
        fontWeight = FontWeight.w400;
      case gray1:
        color = AppTheme.current.colors.white;
        fontSize = 12;
        fontWeight = FontWeight.w400;
      case gray2:
        color = AppTheme.current.colors.white;
        fontSize = 16;
        fontWeight = FontWeight.w500;
      case red1:
        color = AppTheme.current.colors.red1;
        fontSize = 16;
        fontWeight = FontWeight.w400;
      case red2:
        color = AppTheme.current.colors.red1;
        fontSize = 14;
        fontWeight = FontWeight.w400;
      case red3:
        color = AppTheme.current.colors.red1;
        fontSize = 12;
        fontWeight = FontWeight.w400;
      case red4:
        color = AppTheme.current.colors.red1;
        fontSize = 12;
        fontWeight = FontWeight.w400;
      case blue:
        return TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400);
    }
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  TextStyle get disabledTextStyle {
    final Color color;
    final double fontSize;
    final FontWeight fontWeight;
    switch (this) {
      case linkButton:
        return TextStyle(
          color: AppTheme.current.colors.gray1,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
        );
      case hollowSmall:
        return TextStyle(color: AppTheme.current.colors.gray1, fontSize: 12, fontWeight: FontWeight.w400);
      case hollowGray:
        return TextStyle(color: AppTheme.current.colors.gray2, fontSize: 14, fontWeight: FontWeight.w400);
      case hollowBlue:
        return TextStyle(color: AppTheme.current.colors.gray1, fontSize: 14, fontWeight: FontWeight.w400);
      case whiteBackgroundRedText:
      case white0:
      case white1:
        color = AppTheme.current.colors.gray1;
        fontSize = 16;
        fontWeight = FontWeight.w400;
      case white2:
        color = AppTheme.current.colors.gray1;
        fontSize = 14;
        fontWeight = FontWeight.w400;
      case white3:
        color = AppTheme.current.colors.gray1;
        fontSize = 12;
        fontWeight = FontWeight.w400;
      case white4:
        color = AppTheme.current.colors.gray1;
        fontSize = 12;
        fontWeight = FontWeight.w400;
      case black1:
        color = const Color(0xFF666666);
        fontSize = 16;
        fontWeight = FontWeight.w400;
      case black2:
        color = const Color(0xFF666666);
        fontSize = 14;
        fontWeight = FontWeight.w400;
      case gray1:
        color = AppTheme.current.colors.gray1;
        fontSize = 12;
        fontWeight = FontWeight.w400;
      case gray2:
        color = AppTheme.current.colors.gray1;
        fontSize = 10;
        fontWeight = FontWeight.w500;
      case red1:
        color = AppTheme.current.colors.gray1;
        fontSize = 16;
        fontWeight = FontWeight.w400;
      case red2:
        color = AppTheme.current.colors.gray1;
        fontSize = 14;
        fontWeight = FontWeight.w400;
      case red3:
        color = AppTheme.current.colors.gray1;
        fontSize = 12;
        fontWeight = FontWeight.w400;
      case red4:
        color = AppTheme.current.colors.gray1;
        fontSize = 12;
        fontWeight = FontWeight.w400;

      case blue:
        color = AppTheme.current.colors.white;
        fontSize = 14;
        fontWeight = FontWeight.w400;
    }
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  BoxBorder? get border {
    switch (this) {
      case hollowSmall:
        return Border.all(color: Colors.white, width: 1);
      case hollowGray:
        return Border.all(color: AppTheme.current.colors.gray1, width: 1);
      case hollowBlue:
        return null;
      case gray1:
      case gray2:
        return Border.all(color: AppTheme.current.colors.white, width: 0.5);
      default:
        return null;
    }
  }

  Widget? get accessoryWidget {
    if (this == white3) {
      return Assets.images.iconBasicButtonArrowBlue.image(width: 8, height: 8);
    } else if (this == red3) {
      return Assets.images.iconBasicButtonArrowRed.image(width: 8, height: 8);
    }
    return null;
  }

  Widget? get disabledAccesoryWidget {
    if (this == white3 || this == red3) {
      return Assets.images.iconBasicButtonArrowDisabled.image(width: 8, height: 8);
    }
    return null;
  }
}
