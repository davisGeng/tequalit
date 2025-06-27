// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_cancel_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentCancelReponse _$PaymentIntentCancelReponseFromJson(
        Map<String, dynamic> json) =>
    PaymentIntentCancelReponse(
      id: json['id'] as String?,
      requestId: json['request_id'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      status: json['status'] as String?,
      merchantOrderId: json['merchant_order_id'] as String?,
      descriptor: json['descriptor'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PaymentIntentCancelReponseToJson(
        PaymentIntentCancelReponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'request_id': instance.requestId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'merchant_order_id': instance.merchantOrderId,
      'descriptor': instance.descriptor,
      'metadata': instance.metadata,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      foo: json['foo'] as String?,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'foo': instance.foo,
    };
