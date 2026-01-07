import 'package:flutter/material.dart';

class TextUtils {
  /// 计算给定文本在指定样式和约束条件下的宽度
  static double calculateWidth({
    required String text,
    TextStyle? style,
    double maxWidth = double.infinity,
    TextAlign textAlign = TextAlign.start,
    TextDirection textDirection = TextDirection.ltr,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: textDirection,
      textAlign: textAlign,
      maxLines: maxLines,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout(maxWidth: maxWidth);

    return textPainter.size.width;
  }

  /// 计算单行文本的宽度
  static double calculateSingleLineWidth({
    required String text,
    TextStyle? style,
    TextDirection textDirection = TextDirection.ltr,
  }) {
    return calculateWidth(
      text: text,
      style: style,
      maxLines: 1,
      textDirection: textDirection,
    );
  }

  // static String getStringWithOption(String? string) {
  //   if(string == null || string.isEmpty){
  //     return "";
  //   } else {
  //     return string;
  //   }
  // }
  static String getStringWithOption(String? string) {
    if (string == null || string.isEmpty) {
      return "";
    } else {
      return string;
    }
  }

  // 提取数字并转换为 num 类型（int 或 double）
  static List<String> extractNumbersAsNum(String text) {
    final regex = RegExp(r'(\d+\.?\d*|\.\d+)');
    return regex.allMatches(text).map((match) {
      String numStr = match.group(0)!;
      // 包含小数点则解析为 double，否则解析为 int
      return numStr;
    }).toList();
  }

  static double stringToDouble(String? str, {double defaultValue = 0.0}) {
    // 处理 null 或空字符串
    if (str == null || str.isEmpty) {
      return defaultValue;
    }
    // 安全转换，失败返回兜底值
    return double.tryParse(str) ?? defaultValue;
  }
}
