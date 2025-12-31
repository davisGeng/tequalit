// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_add_subscription_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueAddSubscriptionListResponse _$ValueAddSubscriptionListResponseFromJson(
        Map<String, dynamic> json) =>
    ValueAddSubscriptionListResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => DeviceSubscription.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValueAddSubscriptionListResponseToJson(
        ValueAddSubscriptionListResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'pagination': instance.pagination,
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

DeviceSubscription _$DeviceSubscriptionFromJson(Map<String, dynamic> json) =>
    DeviceSubscription(
      deviceId: json['device_id'] as String?,
      deviceName: json['device_name'] as String?,
      deviceThirdPartId: json['device_third_part_id'] as String?,
      subscriptions: (json['subscriptions'] as List<dynamic>?)
          ?.map((e) => Subscriptions.fromJson(e as Map<String, dynamic>))
          .toList(),
      subscriptionSummary: json['subscription_summary'] == null
          ? null
          : SubscriptionSummary.fromJson(
              json['subscription_summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceSubscriptionToJson(DeviceSubscription instance) =>
    <String, dynamic>{
      'device_id': instance.deviceId,
      'device_name': instance.deviceName,
      'device_third_part_id': instance.deviceThirdPartId,
      'subscriptions': instance.subscriptions,
      'subscription_summary': instance.subscriptionSummary,
    };

SubscriptionSummary _$SubscriptionSummaryFromJson(Map<String, dynamic> json) =>
    SubscriptionSummary(
      totalCount: (json['total_count'] as num?)?.toInt(),
      activeCount: (json['active_count'] as num?)?.toInt(),
      canceledCount: (json['canceled_count'] as num?)?.toInt(),
      expiredCount: (json['expired_count'] as num?)?.toInt(),
      suspendedCount: (json['suspended_count'] as num?)?.toInt(),
      trialCount: (json['trial_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubscriptionSummaryToJson(
        SubscriptionSummary instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'active_count': instance.activeCount,
      'canceled_count': instance.canceledCount,
      'expired_count': instance.expiredCount,
      'suspended_count': instance.suspendedCount,
      'trial_count': instance.trialCount,
    };

Subscriptions _$SubscriptionsFromJson(Map<String, dynamic> json) =>
    Subscriptions(
      id: json['id'] as String?,
      plan: json['plan'] == null
          ? null
          : SubscriptionPlan.fromJson(json['plan'] as Map<String, dynamic>),
      status: json['status'] as String?,
      currentPeriodStart: json['current_period_start'] as String?,
      currentPeriodEnd: json['current_period_end'] as String?,
      autoRenew: json['auto_renew'] as bool?,
      createdAt: json['created_at'] as String?,
      role: json['role'] as String?,
      allocatedAt: json['allocated_at'] as String?,
    );

Map<String, dynamic> _$SubscriptionsToJson(Subscriptions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plan': instance.plan,
      'status': instance.status,
      'current_period_start': instance.currentPeriodStart,
      'current_period_end': instance.currentPeriodEnd,
      'auto_renew': instance.autoRenew,
      'created_at': instance.createdAt,
      'role': instance.role,
      'allocated_at': instance.allocatedAt,
    };

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) =>
    SubscriptionPlan(
      planId: json['plan_id'] as String?,
      name: json['name'] as String?,
      productType: json['product_type'] as String?,
      productName: json['product_name'] as String?,
      attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Object),
      ),
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => Prices.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionPlanToJson(SubscriptionPlan instance) =>
    <String, dynamic>{
      'plan_id': instance.planId,
      'name': instance.name,
      'product_type': instance.productType,
      'product_name': instance.productName,
      'attributes': instance.attributes,
      'prices': instance.prices,
    };

Prices _$PricesFromJson(Map<String, dynamic> json) => Prices(
      priceId: json['price_id'] as String?,
      currency: json['currency'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      unitAmount: (json['unit_amount'] as num?)?.toInt(),
      interval: json['interval'] as String?,
    );

Map<String, dynamic> _$PricesToJson(Prices instance) => <String, dynamic>{
      'price_id': instance.priceId,
      'currency': instance.currency,
      'currency_symbol': instance.currencySymbol,
      'unit_amount': instance.unitAmount,
      'interval': instance.interval,
    };
