import 'package:json_annotation/json_annotation.dart';
part 'value_add_subscription_list_response.g.dart';

@JsonSerializable()
class ValueAddSubscriptionListResponse {
  @JsonKey(name: 'items')
  List<DeviceSubscription>? items;
  @JsonKey(name: 'pagination')
  Pagination? pagination;

  ValueAddSubscriptionListResponse({this.items, this.pagination});

  factory ValueAddSubscriptionListResponse.fromJson(Map<String, dynamic> json) =>
      _$ValueAddSubscriptionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValueAddSubscriptionListResponseToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'limit')
  int? limit;
  @JsonKey(name: 'offset')
  int? offset;
  @JsonKey(name: 'has_next')
  bool? hasNext;
  @JsonKey(name: 'has_previous')
  bool? hasPrevious;

  Pagination({this.total, this.limit, this.offset, this.hasNext, this.hasPrevious});

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class DeviceSubscription {
  @JsonKey(name: 'device_id')
  String? deviceId;
  @JsonKey(name: 'device_name')
  String? deviceName;
  @JsonKey(name: 'device_third_part_id')
  String? deviceThirdPartId;
  @JsonKey(name: 'subscriptions')
  List<Subscriptions>? subscriptions;
  @JsonKey(name: 'subscription_summary')
  SubscriptionSummary? subscriptionSummary;

  DeviceSubscription({
    this.deviceId,
    this.deviceName,
    this.deviceThirdPartId,
    this.subscriptions,
    this.subscriptionSummary,
  });

  factory DeviceSubscription.fromJson(Map<String, dynamic> json) => _$DeviceSubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceSubscriptionToJson(this);
}

@JsonSerializable()
class SubscriptionSummary {
  @JsonKey(name: 'total_count')
  int? totalCount;
  @JsonKey(name: 'active_count')
  int? activeCount;
  @JsonKey(name: 'canceled_count')
  int? canceledCount;
  @JsonKey(name: 'expired_count')
  int? expiredCount;
  @JsonKey(name: 'suspended_count')
  int? suspendedCount;
  @JsonKey(name: 'trial_count')
  int? trialCount;

  SubscriptionSummary({
    this.totalCount,
    this.activeCount,
    this.canceledCount,
    this.expiredCount,
    this.suspendedCount,
    this.trialCount,
  });

  factory SubscriptionSummary.fromJson(Map<String, dynamic> json) => _$SubscriptionSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionSummaryToJson(this);
}

@JsonSerializable()
class Subscriptions {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'plan')
  SubscriptionPlan? plan;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'current_period_start')
  String? currentPeriodStart;
  @JsonKey(name: 'current_period_end')
  String? currentPeriodEnd;
  @JsonKey(name: 'auto_renew')
  bool? autoRenew;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'role')
  String? role;
  @JsonKey(name: 'allocated_at')
  String? allocatedAt;

  Subscriptions({
    this.id,
    this.plan,
    this.status,
    this.currentPeriodStart,
    this.currentPeriodEnd,
    this.autoRenew,
    this.createdAt,
    this.role,
    this.allocatedAt,
  });

  factory Subscriptions.fromJson(Map<String, dynamic> json) => _$SubscriptionsFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionsToJson(this);

  String getCurrentPeriodStart() {
    String outTime = currentPeriodStart ?? "";
    // 原始日期格式：2025-11-10T15:51:55.395858+08:00
    outTime = convertTimeWithoutIntl(outTime);
    return outTime;
  }

  String getCurrentPeriodEnd() {
    String outTime = currentPeriodEnd ?? "";
    // 原始日期格式：2025-11-10T15:51:55.395858+08:00
    outTime = convertTimeWithoutIntl(outTime);
    return outTime;
  }

  String convertTimeWithoutIntl(String originalTime) {
    try {
      String subString = originalTime.substring(0, 19);
      subString = subString.replaceAll("T", " ");
      return subString;
    } catch (e) {
      print("时间转换失败：$e");
      return ""; // 异常时返回空字符串（可根据需求调整）
    }
  }

  int calculateDaysDifference() {
    
    try {
      // 2. 解析时间字符串为 DateTime 对象（Dart 原生支持 ISO 8601 格式）
      final DateTime date1 = DateTime.parse(currentPeriodStart??"");
      final DateTime date2 = DateTime.parse(currentPeriodEnd??"");

      // 3. 计算两个时间的差值（Duration 对象）
      final Duration difference = date2.difference(date1);

      // 4. 转换为天数（三种常用方式）
      // 方式1：按「总秒数/86400」取精确天数（含小数，如 4.8 天）
      final double exactDays = difference.inSeconds / 86400;
      // 方式2：按「完整24小时」取整（向下取整，如 4 天）
      final int fullDays = difference.inDays;
      // // 方式3：按「日历天」取整（向上取整，如不足1天算1天）
      // final int ceilDays = (exactDays).ceil();

      // 输出结果
      print("原始时间1：$date1");
      print("原始时间2：$date2");

      print("完整24小时天数：$fullDays 天");
      return fullDays;
    } catch (e) {
      // 处理时间解析失败（如格式错误）
      print("时间解析失败：$e");
      return -1;
    }
  }

}

@JsonSerializable()
class SubscriptionPlan {
  @JsonKey(name: 'plan_id')
  String? planId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'product_type')
  String? productType;
  @JsonKey(name: 'product_name')
  String? productName;
  @JsonKey(name: 'attributes')
  Map<String, Object>? attributes;
  @JsonKey(name: 'prices')
  List<Prices>? prices;

  SubscriptionPlan({this.planId, this.name, this.productType, this.productName, this.attributes, this.prices});

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionPlanToJson(this);
  Map<String, Object>? getAttribute() {
    if (attributes == null) return null;

    Map<String, Object> map = Map.from(attributes!);

    void convertDoubleToInt(String key) {
      final dynamic value = map[key];
      if (value is double && value == value.toInt()) {
        map[key] = value.toInt();
      }
    }

    List<String> convertKeys = const ["duration_days", "data_total", "validity_period"];
    // 遍历 key 列表处理
    for (final key in convertKeys) {
      convertDoubleToInt(key);
    }

    return map;
  }
}

@JsonSerializable()
class Prices {
  @JsonKey(name: 'price_id')
  String? priceId;
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'currency_symbol')
  String? currencySymbol;
  @JsonKey(name: 'unit_amount')
  int? unitAmount;
  @JsonKey(name: 'interval')
  String? interval;

  Prices({this.priceId, this.currency, this.currencySymbol, this.unitAmount, this.interval});

  factory Prices.fromJson(Map<String, dynamic> json) => _$PricesFromJson(json);

  Map<String, dynamic> toJson() => _$PricesToJson(this);
}
