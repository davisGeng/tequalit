// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundReponse _$RefundReponseFromJson(Map<String, dynamic> json) =>
    RefundReponse(
      hasMore: json['has_more'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => RefundItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RefundReponseToJson(RefundReponse instance) =>
    <String, dynamic>{
      'has_more': instance.hasMore,
      'items': instance.items,
    };

RefundItem _$RefundItemFromJson(Map<String, dynamic> json) => RefundItem(
      id: json['id'] as String?,
      requestId: json['request_id'] as String?,
      paymentIntentId: json['payment_intent_id'] as String?,
      paymentAttemptId: json['payment_attempt_id'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      reason: json['reason'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$RefundItemToJson(RefundItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'request_id': instance.requestId,
      'payment_intent_id': instance.paymentIntentId,
      'payment_attempt_id': instance.paymentAttemptId,
      'amount': instance.amount,
      'currency': instance.currency,
      'reason': instance.reason,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
