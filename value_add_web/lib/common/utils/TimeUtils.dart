import 'package:dart_extensions/dart_extensions.dart';
import 'package:intl/intl.dart';

import '../../services/log_service.dart';

class TimeUtils {
  // 获取当前时间戳（毫秒）
  static int getDayNow() {
    var nowTime = DateTime.now();
    return nowTime.millisecondsSinceEpoch;
  }

  // 将时间戳（毫秒）转换为时间日期字符串
  static String getTimeEpoch(int millisecondsSinceEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch).toString();
  }

  // 获取当前时间日期并按指定格式显示
  static String getCurrentTime() {
    var nowTime = DateTime.now();
    // 这里可以使用第三方库如 intl 来进行更灵活的格式化
    // 简单示例直接用toString
    return nowTime.toString();
  }

  static String getCurrentTimeWithFormat({String format = "yyyy-MM-dd"}) {
    // 获取当前时间
    DateTime now = DateTime.now();
    // 定义格式
    DateFormat formatter = DateFormat(format);

    return formatter.format(now);
  }

  static int getIntervalDays(String startTime, String endTime) {
    // 将字符串解析为DateTime对象
    if (startTime.isEmptyOrNull || endTime.isEmptyOrNull) {
      return 0;
    }
    DateTime dateEnd = DateTime.parse(endTime.substring(0, 10));
    DateTime dateStart = DateTime.parse(startTime.substring(0, 10));

    // 计算两个日期之间的差值
    Duration difference = dateEnd.difference(dateStart);

    // 获取天数间隔
    int days = difference.inDays;
    return days;
  }

  static DateTime getDateTimeFromFormatString(String input, {String format = "yyyy-MM-dd HH:mm:ss"}) {
    if (input.isEmpty) {
      return DateTime.now();
    }

    // 使用正则表达式提取所有数字
    final RegExp regex = RegExp(r'\d+');
    final StringBuffer buffer = StringBuffer();

    // 收集所有匹配到的数字
    for (final Match match in regex.allMatches(input)) {
      buffer.write(match.group(0));
    }

    final String digits = buffer.toString();

    // 根据目标格式确定所需的最小长度
    final int minLength = format == "yyyy-MM-dd" ? 8 : 14;

    // 长度校验：不足则直接返回空字符串
    if (digits.length < minLength) {
      return DateTime.now();
    }

    try {
      // 截取有效日期时间字符串（统一处理截取逻辑）
      final String dateTimeStr = digits.substring(0, minLength);

      // 解析年月日（共通部分）
      final int year = int.parse(dateTimeStr.substring(0, 4));
      final int month = int.parse(dateTimeStr.substring(4, 6));
      final int day = int.parse(dateTimeStr.substring(6, 8));

      DateTime dateTime;
      if (format == "yyyy-MM-dd") {
        // 仅需年月日的场景
        dateTime = DateTime(year, month, day);
      } else {
        // 需要时分秒的场景（补充解析）
        final int hour = int.parse(dateTimeStr.substring(8, 10));
        final int minute = int.parse(dateTimeStr.substring(10, 12));
        final int second = int.parse(dateTimeStr.substring(12, 14));
        dateTime = DateTime(year, month, day, hour, minute, second);
      }

      // 统一格式化输出
      return dateTime;
    } catch (e) {
      Log.d('日期时间解析错误: $e');
      return DateTime.now();
    }
  }

  /// 从字符串中提取数字并转换为日期时间格式TG202503041754400223
  /// 返回格式为 yyyy-MM-dd HH:mm:ss 的字符串
  static String extractAndFormatDateTime(String input, {String format = "yyyy-MM-dd HH:mm:ss"}) {
    if (input.isEmpty) {
      return '';
    }

    // 使用正则表达式提取所有数字
    final RegExp regex = RegExp(r'\d+');
    final StringBuffer buffer = StringBuffer();

    // 收集所有匹配到的数字
    for (final Match match in regex.allMatches(input)) {
      buffer.write(match.group(0));
    }

    final String digits = buffer.toString();

    // 根据目标格式确定所需的最小长度
    final int minLength = format == "yyyy-MM-dd" ? 8 : 14;

    // 长度校验：不足则直接返回空字符串
    if (digits.length < minLength) {
      return '';
    }

    try {
      // 截取有效日期时间字符串（统一处理截取逻辑）
      final String dateTimeStr = digits.substring(0, minLength);

      // 解析年月日（共通部分）
      final int year = int.parse(dateTimeStr.substring(0, 4));
      final int month = int.parse(dateTimeStr.substring(4, 6));
      final int day = int.parse(dateTimeStr.substring(6, 8));

      DateTime dateTime;
      if (format == "yyyy-MM-dd") {
        // 仅需年月日的场景
        dateTime = DateTime(year, month, day);
      } else {
        // 需要时分秒的场景（补充解析）
        final int hour = int.parse(dateTimeStr.substring(8, 10));
        final int minute = int.parse(dateTimeStr.substring(10, 12));
        final int second = int.parse(dateTimeStr.substring(12, 14));
        dateTime = DateTime(year, month, day, hour, minute, second);
      }

      // 统一格式化输出
      return DateFormat(format).format(dateTime);
    } catch (e) {
      Log.d('日期时间解析错误: $e');
      return '';
    }
  }

  static int compareWithCurrentTime(String dateTimeStr) {
    try {
      // 解析输入的日期时间字符串
      final DateTime targetDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeStr);

      // 获取当前时间
      final DateTime currentDateTime = DateTime.now();

      // 比较两个时间
      if (targetDateTime.isAfter(currentDateTime)) {
        return 1;
      } else if (targetDateTime.isBefore(currentDateTime)) {
        return -1;
      } else {
        return 0;
      }
    } catch (e) {
      return -100;
    }
  }

  /// 获取时间数组中最大时间并增加 addExtraSecond 秒
  static String? getMaxTimeAddExtraSeconds(List<String> timeStrings, {int addExtraSecond = 0}) {
    // 1. 将时间字符串转为DateTime对象
    List<DateTime?> dates =
        timeStrings.map((str) {
          final isoStr = str.replaceAll(' ', 'T'); // 转换为ISO格式便于解析
          return DateTime.tryParse(isoStr);
        }).toList();

    // 2. 过滤无效时间并检查是否有有效数据
    final validDates = dates.whereType<DateTime>().toList();
    if (validDates.isEmpty) return null;

    // 3. 找到最大时间并增加2秒
    final maxDate = validDates.reduce((a, b) => a.isAfter(b) ? a : b);
    final maxDateAddTwoSeconds = maxDate.add(Duration(seconds: addExtraSecond));

    // 4. 转换回原格式 "yyyy-MM-dd HH:mm:ss"
    return maxDateAddTwoSeconds.toIso8601String().replaceAll('T', ' ').split('.').first;
  }

  /// 获取某天最后一刻（23:59:59.999）的秒时间戳
  static int getEndOfDayEpochSeconds(DateTime time) {
    DateTime endTime = DateTime(time.year, time.month, time.day, 23, 59, 59);

    return (endTime.millisecondsSinceEpoch / 1000).toInt();
  }
}
