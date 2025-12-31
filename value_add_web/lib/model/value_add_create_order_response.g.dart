// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_add_create_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueAddCreateOrderResponse _$ValueAddCreateOrderResponseFromJson(
        Map<String, dynamic> json) =>
    ValueAddCreateOrderResponse(
      id: json['id'] as String,
      orderNumber: json['order_number'] as String,
      status: json['status'] as String,
      totalAmount: (json['total_amount'] as num?)?.toInt(),
      totalAmountDisplay: json['total_amount_display'] as String?,
      payableAmount: (json['payable_amount'] as num?)?.toInt(),
      payableAmountDisplay: json['payable_amount_display'] as String?,
      paidAmount: (json['paid_amount'] as num?)?.toInt(),
      paidAmountDisplay: json['paid_amount_display'] as String?,
      currency: json['currency'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      createdAt: json['created_at'] as String?,
      paidAt: json['paid_at'] as String?,
      paymentChannel: json['payment_channel'] as String?,
      billingType: json['billing_type'] as String?,
      deviceId: json['device_id'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      intentId: json['intent_id'] as String?,
      env: json['env'] as String?,
      returnUrl: json['return_url'] as String?,
      metadata: json['metadata'] == null
          ? null
          : OrderMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      clientSecret: json['client_secret'] as String?,
    );

Map<String, dynamic> _$ValueAddCreateOrderResponseToJson(
        ValueAddCreateOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'status': instance.status,
      'total_amount': instance.totalAmount,
      'total_amount_display': instance.totalAmountDisplay,
      'payable_amount': instance.payableAmount,
      'payable_amount_display': instance.payableAmountDisplay,
      'paid_amount': instance.paidAmount,
      'paid_amount_display': instance.paidAmountDisplay,
      'currency': instance.currency,
      'currency_symbol': instance.currencySymbol,
      'created_at': instance.createdAt,
      'paid_at': instance.paidAt,
      'payment_channel': instance.paymentChannel,
      'billing_type': instance.billingType,
      'device_id': instance.deviceId,
      'items': instance.items,
      'intent_id': instance.intentId,
      'env': instance.env,
      'return_url': instance.returnUrl,
      'metadata': instance.metadata,
      'client_secret': instance.clientSecret,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      planNameSnapshot: json['plan_name_snapshot'] as String?,
      unitPriceSnapshot: (json['unit_price_snapshot'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'plan_name_snapshot': instance.planNameSnapshot,
      'unit_price_snapshot': instance.unitPriceSnapshot,
      'quantity': instance.quantity,
    };

OrderMetadata _$OrderMetadataFromJson(Map<String, dynamic> json) =>
    OrderMetadata(
      source: json['source'] as String?,
      deviceId: json['device_id'] as String?,
    );

Map<String, dynamic> _$OrderMetadataToJson(OrderMetadata instance) =>
    <String, dynamic>{
      'source': instance.source,
      'device_id': instance.deviceId,
    };
