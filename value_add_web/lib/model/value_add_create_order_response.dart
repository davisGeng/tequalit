import 'package:json_annotation/json_annotation.dart';

part 'value_add_create_order_response.g.dart';

/// 增值服务创建订单的响应模型
@JsonSerializable()
class ValueAddCreateOrderResponse {
  /// 订单唯一标识符
  final String id;

  /// 订单编号
  @JsonKey(name: 'order_number')
  final String orderNumber;

  /// 订单状态 (例如: PENDING, PAID, FAILED)
  final String status;

  /// 订单总金额 (单位：分)
  @JsonKey(name: 'total_amount')
  final int? totalAmount;

  /// 订单总金额（带货币符号的字符串显示）
  @JsonKey(name: 'total_amount_display')
  final String? totalAmountDisplay;

  /// 应付金额 (单位：分)
  @JsonKey(name: 'payable_amount')
  final int? payableAmount;

  /// 应付金额（带货币符号的字符串显示）
  @JsonKey(name: 'payable_amount_display')
  final String? payableAmountDisplay;

  /// 已支付金额 (单位：分)，未支付时为 null
  @JsonKey(name: 'paid_amount')
  final int? paidAmount;

  /// 已支付金额（带货币符号的字符串显示），未支付时为 null
  @JsonKey(name: 'paid_amount_display')
  final String? paidAmountDisplay;

  /// 货币代码 (例如: USD, CNY)
  final String? currency;

  /// 货币符号 (例如: $, ¥)
  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;

  /// 订单创建时间
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// 订单支付时间，未支付时为 null
  @JsonKey(name: 'paid_at')
  final String? paidAt;

  /// 支付渠道 (例如: airwallex, stripe, paypal)
  @JsonKey(name: 'payment_channel')
  final String? paymentChannel;

  /// 计费周期类型 (例如: month, year)
  @JsonKey(name: 'billing_type')
  final String? billingType;

  /// 设备 ID
  @JsonKey(name: 'device_id')
  final String? deviceId;

  /// 订单项列表
  final List<OrderItem>? items;

  /// 支付意向 ID，用于对接支付网关
  @JsonKey(name: 'intent_id')
  final String? intentId;

  /// 环境 (例如: prod, test, dev)
  final String? env;

  /// 支付完成后跳转的 URL
  @JsonKey(name: 'return_url')
  final String? returnUrl;

  /// 附加元数据
  final OrderMetadata? metadata;

  /// 客户端密钥，用于在客户端确认支付
  @JsonKey(name: 'client_secret')
  final String? clientSecret;

  /// 构造函数
  ValueAddCreateOrderResponse({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.totalAmount,
    required this.totalAmountDisplay,
    required this.payableAmount,
    required this.payableAmountDisplay,
    this.paidAmount,
    this.paidAmountDisplay,
    required this.currency,
    required this.currencySymbol,
    required this.createdAt,
    this.paidAt,
    required this.paymentChannel,
    required this.billingType,
    required this.deviceId,
    required this.items,
    required this.intentId,
    required this.env,
    required this.returnUrl,
    required this.metadata,
    required this.clientSecret,
  });

  /// 从 JSON 字符串构建 [ValueAddCreateOrderResponse] 对象
  factory ValueAddCreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$ValueAddCreateOrderResponseFromJson(json);

  /// 将 [ValueAddCreateOrderResponse] 对象转换为 JSON 字符串
  Map<String, dynamic> toJson() => _$ValueAddCreateOrderResponseToJson(this);

  String getCreateTime() {
    String outTime = createdAt ?? "";
    // 原始日期格式：yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXX
    outTime = convertTimeWithoutIntl(outTime);
    return outTime;
  }

  String getPaidTime() {
    String outTime = paidAt ?? "";
    // 原始日期格式：yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXX
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

  // 辅助方法：单数数字前补零（确保格式统一为两位数）
  String _addZero(int num) {
    return num < 10 ? "0$num" : num.toString();
  }
}

/// 订单中的商品项
@JsonSerializable()
class OrderItem {
  /// 套餐名称快照
  @JsonKey(name: 'plan_name_snapshot')
  final String? planNameSnapshot;

  /// 单价快照 (单位：分)
  @JsonKey(name: 'unit_price_snapshot')
  final int? unitPriceSnapshot;

  /// 数量
  final int? quantity;

  /// 构造函数
  OrderItem({required this.planNameSnapshot, required this.unitPriceSnapshot, required this.quantity});

  /// 从 JSON 字符串构建 [OrderItem] 对象
  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  /// 将 [OrderItem] 对象转换为 JSON 字符串
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

/// 订单的元数据
@JsonSerializable()
class OrderMetadata {
  /// 订单来源 (例如: mobile_app, web)
  final String? source;

  /// 设备 ID
  @JsonKey(name: 'device_id')
  final String? deviceId;

  /// 构造函数
  OrderMetadata({required this.source, required this.deviceId});

  /// 从 JSON 字符串构建 [OrderMetadata] 对象
  factory OrderMetadata.fromJson(Map<String, dynamic> json) => _$OrderMetadataFromJson(json);

  /// 将 [OrderMetadata] 对象转换为 JSON 字符串
  Map<String, dynamic> toJson() => _$OrderMetadataToJson(this);
}
