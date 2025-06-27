// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intents_list_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentsListReponse _$PaymentIntentsListReponseFromJson(
        Map<String, dynamic> json) =>
    PaymentIntentsListReponse(
      hasMore: json['has_more'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentIntentsListReponseToJson(
        PaymentIntentsListReponse instance) =>
    <String, dynamic>{
      'has_more': instance.hasMore,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      latestPaymentAttempt: json['latest_payment_attempt'] == null
          ? null
          : LatestPaymentAttempt.fromJson(
              json['latest_payment_attempt'] as Map<String, dynamic>),
      id: json['id'] as String?,
      requestId: json['request_id'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      merchantOrderId: json['merchant_order_id'] as String?,
      descriptor: json['descriptor'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'latest_payment_attempt': instance.latestPaymentAttempt,
      'id': instance.id,
      'request_id': instance.requestId,
      'amount': instance.amount,
      'currency': instance.currency,
      'merchant_order_id': instance.merchantOrderId,
      'descriptor': instance.descriptor,
      'metadata': instance.metadata,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      foo: json['foo'] as String?,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'foo': instance.foo,
    };

LatestPaymentAttempt _$LatestPaymentAttemptFromJson(
        Map<String, dynamic> json) =>
    LatestPaymentAttempt(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$LatestPaymentAttemptToJson(
        LatestPaymentAttempt instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
