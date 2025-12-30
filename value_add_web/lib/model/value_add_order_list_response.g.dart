// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_add_order_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueAddOrderListResponse _$ValueAddOrderListResponseFromJson(
  Map<String, dynamic> json,
) => ValueAddOrderListResponse(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => ValueAddOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  pagination:
      json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ValueAddOrderListResponseToJson(
  ValueAddOrderListResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'pagination': instance.pagination,
};

ValueAddOrderItem _$ValueAddOrderItemFromJson(Map<String, dynamic> json) =>
    ValueAddOrderItem(
      id: json['id'] as String?,
      orderNumber: json['order_number'] as String?,
      status: json['status'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toInt(),
      totalAmountDisplay: json['total_amount_display'] as String?,
      payableAmount: (json['payable_amount'] as num?)?.toInt(),
      payableAmountDisplay: json['payable_amount_display'] as String?,
      currency: json['currency'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      createdAt: json['created_at'] as String?,
      paidAt: json['paid_at'] as String?,
      paymentChannel: json['payment_channel'] as String?,
      billingType: json['billing_type'] as String?,
      deviceId: json['device_id'] as String?,
      orderProductItems:
          (json['items'] as List<dynamic>?)
              ?.map((e) => OrderProductItem.fromJson(e as Map<String, dynamic>))
              .toList(),
      deviceName: json['device_name'] as String?,
      deviceThirdPartId: json['device_third_part_id'] as String?,
    );

Map<String, dynamic> _$ValueAddOrderItemToJson(ValueAddOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'status': instance.status,
      'total_amount': instance.totalAmount,
      'total_amount_display': instance.totalAmountDisplay,
      'payable_amount': instance.payableAmount,
      'payable_amount_display': instance.payableAmountDisplay,
      'currency': instance.currency,
      'currency_symbol': instance.currencySymbol,
      'created_at': instance.createdAt,
      'paid_at': instance.paidAt,
      'payment_channel': instance.paymentChannel,
      'billing_type': instance.billingType,
      'device_id': instance.deviceId,
      'items': instance.orderProductItems,
      'device_name': instance.deviceName,
      'device_third_part_id': instance.deviceThirdPartId,
    };

OrderProductItem _$OrderProductItemFromJson(Map<String, dynamic> json) =>
    OrderProductItem(
      planNameSnapshot: json['plan_name_snapshot'] as String?,
      unitPriceSnapshot: (json['unit_price_snapshot'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      product:
          json['product'] == null
              ? null
              : Product.fromJson(json['product'] as Map<String, dynamic>),
      provider: (json['provider'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Object),
      ),
      subscription: (json['subscription'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Object),
      ),
    );

Map<String, dynamic> _$OrderProductItemToJson(OrderProductItem instance) =>
    <String, dynamic>{
      'plan_name_snapshot': instance.planNameSnapshot,
      'unit_price_snapshot': instance.unitPriceSnapshot,
      'quantity': instance.quantity,
      'product': instance.product,
      'provider': instance.provider,
      'subscription': instance.subscription,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  productId: json['product_id'] as String?,
  name: json['name'] as String?,
  type: json['type'] as String?,
  iconUrl: json['icon_url'] as String?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'product_id': instance.productId,
  'name': instance.name,
  'type': instance.type,
  'icon_url': instance.iconUrl,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  total: (json['total'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  offset: (json['offset'] as num?)?.toInt(),
  hasNext: json['has_next'] as bool?,
  hasPrevious: json['has_previous'] as bool?,
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'limit': instance.limit,
      'offset': instance.offset,
      'has_next': instance.hasNext,
      'has_previous': instance.hasPrevious,
    };
