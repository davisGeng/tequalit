// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_add_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueAddProductResponse _$ValueAddProductResponseFromJson(
  Map<String, dynamic> json,
) => ValueAddProductResponse(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => ValueAddProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  pagination:
      json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ValueAddProductResponseToJson(
  ValueAddProductResponse instance,
) => <String, dynamic>{
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

ValueAddProductItem _$ValueAddProductItemFromJson(Map<String, dynamic> json) =>
    ValueAddProductItem(
      productId: json['product_id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      serviceStatus: json['service_status'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
      iconUrl: json['icon_url'] as String?,
      displayConfig: (json['display_config'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Object),
      ),
      plans:
          (json['plans'] as List<dynamic>?)
              ?.map((e) => Plans.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ValueAddProductItemToJson(
  ValueAddProductItem instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'name': instance.name,
  'type': instance.type,
  'description': instance.description,
  'service_status': instance.serviceStatus,
  'display_order': instance.displayOrder,
  'icon_url': instance.iconUrl,
  'display_config': instance.displayConfig,
  'plans': instance.plans,
};

Plans _$PlansFromJson(Map<String, dynamic> json) => Plans(
  planId: json['plan_id'] as String?,
  name: json['name'] as String?,
  provider: (json['provider'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as Object),
  ),
  attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as Object),
  ),
  availability: (json['availability'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as Object),
  ),
  prices:
      (json['prices'] as List<dynamic>?)
          ?.map((e) => Prices.fromJson(e as Map<String, dynamic>))
          .toList(),
  paymentConfig:
      json['payment_config'] == null
          ? null
          : PaymentConfig.fromJson(
            json['payment_config'] as Map<String, dynamic>,
          ),
  description: json['description'] as String?,
  isRecommended: json['is_recommended'] as bool?,
  isUnlimited: json['is_unlimited'] as bool?,
  supportedCountries:
      (json['supported_countries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  matchedDeviceProductIds:
      (json['matched_device_product_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$PlansToJson(Plans instance) => <String, dynamic>{
  'plan_id': instance.planId,
  'name': instance.name,
  'provider': instance.provider,
  'attributes': instance.attributes,
  'availability': instance.availability,
  'prices': instance.prices,
  'payment_config': instance.paymentConfig,
  'description': instance.description,
  'is_recommended': instance.isRecommended,
  'is_unlimited': instance.isUnlimited,
  'supported_countries': instance.supportedCountries,
  'matched_device_product_ids': instance.matchedDeviceProductIds,
};

Prices _$PricesFromJson(Map<String, dynamic> json) => Prices(
  priceId: json['price_id'] as String?,
  currency: json['currency'] as String?,
  unitAmount: (json['unit_amount'] as num?)?.toInt(),
  interval: json['interval'] as String?,
  currencySymbol: json['currency_symbol'] as String?,
);

Map<String, dynamic> _$PricesToJson(Prices instance) => <String, dynamic>{
  'price_id': instance.priceId,
  'currency': instance.currency,
  'currency_symbol': instance.currencySymbol,
  'unit_amount': instance.unitAmount,
  'interval': instance.interval,
};

Availability _$AvailabilityFromJson(Map<String, dynamic> json) => Availability(
  mcc: (json['mcc'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$AvailabilityToJson(Availability instance) =>
    <String, dynamic>{'mcc': instance.mcc};

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
  dataLimitGb: (json['data_limit_gb'] as num?)?.toInt(),
  dataUnit: json['data_unit'] as String?,
  dataTotal: (json['data_total'] as num?)?.toInt(),
  activeType: json['active_type'] as String?,
  isContract: json['is_contract'] as bool?,
  minOrderCycle: (json['min_order_cycle'] as num?)?.toInt(),
  validityPeriod: (json['validity_period'] as num?)?.toInt(),
  tugeProductCode: json['tuge_product_code'] as String?,
  tugeProductType: json['tuge_product_type'] as String?,
  storageDays: json['storage_days'] as String?,
  recordingType: json['recording_type'] as String?,
);

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'data_limit_gb': instance.dataLimitGb,
      'data_unit': instance.dataUnit,
      'data_total': instance.dataTotal,
      'active_type': instance.activeType,
      'is_contract': instance.isContract,
      'min_order_cycle': instance.minOrderCycle,
      'validity_period': instance.validityPeriod,
      'tuge_product_code': instance.tugeProductCode,
      'tuge_product_type': instance.tugeProductType,
      'storage_days': instance.storageDays,
      'recording_type': instance.recordingType,
    };

DisplayConfig _$DisplayConfigFromJson(Map<String, dynamic> json) =>
    DisplayConfig();

Map<String, dynamic> _$DisplayConfigToJson(DisplayConfig instance) =>
    <String, dynamic>{};

PaymentConfig _$PaymentConfigFromJson(
  Map<String, dynamic> json,
) => PaymentConfig(
  supportedPaymentChannels:
      (json['supported_payment_channels'] as List<dynamic>?)
          ?.map(
            (e) => SupportedPaymentChannels.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  supportedBillingTypes:
      (json['supported_billing_types'] as List<dynamic>?)
          ?.map(
            (e) => SupportedBillingTypes.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$PaymentConfigToJson(PaymentConfig instance) =>
    <String, dynamic>{
      'supported_payment_channels': instance.supportedPaymentChannels,
      'supported_billing_types': instance.supportedBillingTypes,
    };

SupportedBillingTypes _$SupportedBillingTypesFromJson(
  Map<String, dynamic> json,
) => SupportedBillingTypes(
  code: json['code'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$SupportedBillingTypesToJson(
  SupportedBillingTypes instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'description': instance.description,
};

SupportedPaymentChannels _$SupportedPaymentChannelsFromJson(
  Map<String, dynamic> json,
) => SupportedPaymentChannels(
  code: json['code'] as String?,
  name: json['name'] as String?,
  icon: json['icon'] as String?,
  isDefault: json['is_default'] as bool?,
);

Map<String, dynamic> _$SupportedPaymentChannelsToJson(
  SupportedPaymentChannels instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'icon': instance.icon,
  'is_default': instance.isDefault,
};

CloudGoodsBanners _$CloudGoodsBannersFromJson(Map<String, dynamic> json) =>
    CloudGoodsBanners(
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CloudGoodsBannersToJson(CloudGoodsBanners instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
