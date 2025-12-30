import 'package:json_annotation/json_annotation.dart';

part 'value_add_order_list_response.g.dart';

/// 根响应模型

/// 数据主体
@JsonSerializable()
class ValueAddOrderListResponse {
  @JsonKey(name: 'items')
  final List<ValueAddOrderItem>? items;

  @JsonKey(name: 'pagination')
  final Pagination? pagination;

  ValueAddOrderListResponse({required this.items, required this.pagination});

  /// 从 JSON 字符串构建模型
  factory ValueAddOrderListResponse.fromJson(Map<String, dynamic> json) => _$ValueAddOrderListResponseFromJson(json);

  /// 将模型转换为 JSON 字符串
  Map<String, dynamic> toJson() => _$ValueAddOrderListResponseToJson(this);
}

/// 订单列表项
@JsonSerializable()
class ValueAddOrderItem {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'order_number')
  final String? orderNumber;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'total_amount')
  final int? totalAmount;

  @JsonKey(name: 'total_amount_display')
  final String? totalAmountDisplay;

  @JsonKey(name: 'payable_amount')
  final int? payableAmount;

  @JsonKey(name: 'payable_amount_display')
  final String? payableAmountDisplay;

  @JsonKey(name: 'currency')
  final String? currency;

  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'paid_at')
  final String? paidAt; // 可为 null

  @JsonKey(name: 'payment_channel')
  final String? paymentChannel;

  @JsonKey(name: 'billing_type')
  final String? billingType;

  @JsonKey(name: 'device_id')
  final String? deviceId;

  @JsonKey(name: 'items')
  final List<OrderProductItem>? orderProductItems;
  @JsonKey(name: 'device_name')
  String? deviceName;
  @JsonKey(name: 'device_third_part_id')
  String? deviceThirdPartId;

  ValueAddOrderItem({
    this.id,
    this.orderNumber,
    this.status,
    this.totalAmount,
    this.totalAmountDisplay,
    this.payableAmount,
    this.payableAmountDisplay,
    this.currency,
    this.currencySymbol,
    this.createdAt,
    this.paidAt,
    this.paymentChannel,
    this.billingType,
    this.deviceId,
    this.orderProductItems,
    this.deviceName,
    this.deviceThirdPartId,
  });

  factory ValueAddOrderItem.fromJson(Map<String, dynamic> json) => _$ValueAddOrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$ValueAddOrderItemToJson(this);

  ValueAddOrderStatus getOrderStatus() {
    ValueAddOrderStatus orderStatus = ValueAddOrderStatus.fromString(status ?? "");
    return orderStatus;
  }

  String getCreateTime() {
    String outTime = createdAt ?? "";
    // 原始日期格式：yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXX
    outTime = convertTimeWithoutIntl(outTime);
    return outTime;
  }

  String getPaidTime() {
    String outTime = paidAt ?? "";
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
}

/// 订单中的产品项
@JsonSerializable()
class OrderProductItem {
  @JsonKey(name: 'plan_name_snapshot')
  final String? planNameSnapshot;

  @JsonKey(name: 'unit_price_snapshot')
  final int? unitPriceSnapshot;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'product')
  final Product? product;

  @JsonKey(name: 'provider')
  final Map<String, Object>? provider; // 类型不确定，使用 dynamic，可为 null

  @JsonKey(name: 'subscription')
  final Map<String, Object>? subscription; // 类型不确定，使用 dynamic，可为 null

  OrderProductItem({
    required this.planNameSnapshot,
    required this.unitPriceSnapshot,
    required this.quantity,
    required this.product,
    this.provider,
    this.subscription,
  });

  factory OrderProductItem.fromJson(Map<String, dynamic> json) => _$OrderProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductItemToJson(this);
}

/// 产品信息
@JsonSerializable()
class Product {
  @JsonKey(name: 'product_id')
  final String? productId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'icon_url')
  final String? iconUrl;

  Product({required this.productId, required this.name, required this.type, required this.iconUrl});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

/// 分页信息
@JsonSerializable()
class Pagination {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'limit')
  final int? limit;

  @JsonKey(name: 'offset')
  final int? offset;

  @JsonKey(name: 'has_next')
  final bool? hasNext;

  @JsonKey(name: 'has_previous')
  final bool? hasPrevious;

  Pagination({
    required this.total,
    required this.limit,
    required this.offset,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

// lib/models/order_status.dart

/// 订单状态枚举
/// 包含了所有可能的订单状态，并提供了从JSON字符串转换和获取显示名称的方法
enum ValueAddOrderStatus {
  /// 待支付
  PENDING,

  /// 处理中
  PROCESSING,

  /// 已支付
  PAID,

  /// 失败
  FAILED,

  /// 已取消
  CANCELED,

  /// 已退款
  REFUNDED,

  /// 未知状态 (用于处理后端可能返回的新状态，防止应用崩溃)
  UNKNOWN;

  /// 从JSON字符串转换为OrderStatus枚举
  /// [statusString] 是后端返回的状态字符串，如 "PENDING"
  static ValueAddOrderStatus fromString(String statusString) {
    try {
      // 尝试将字符串直接转换为对应的枚举值
      return ValueAddOrderStatus.values.byName(statusString);
    } catch (e) {
      // 如果转换失败（例如，后端返回了一个不在我们列表中的新状态），
      // 打印错误日志并返回 UNKNOWN，以保证应用的健壮性
      print('警告：未知的订单状态字符串: $statusString');
      return ValueAddOrderStatus.UNKNOWN;
    }
  }
}
