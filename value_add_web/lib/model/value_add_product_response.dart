import 'package:json_annotation/json_annotation.dart';
part 'value_add_product_response.g.dart';

@JsonSerializable()
class ValueAddProductResponse {
  @JsonKey(name: 'items')
  List<ValueAddProductItem>? items;
  @JsonKey(name: 'pagination')
  Pagination? pagination;

  ValueAddProductResponse({this.items, this.pagination});

  factory ValueAddProductResponse.fromJson(Map<String, dynamic> json) => _$ValueAddProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValueAddProductResponseToJson(this);
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
class ValueAddProductItem {
  @JsonKey(name: 'product_id')
  String? productId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'service_status')
  String? serviceStatus;
  @JsonKey(name: 'display_order')
  int? displayOrder;
  @JsonKey(name: 'icon_url')
  String? iconUrl;
  @JsonKey(name: 'display_config')
  Map<String, Object>? displayConfig;
  @JsonKey(name: 'plans')
  List<Plans>? plans;

  ValueAddProductItem({
    this.productId,
    this.name,
    this.type,
    this.description,
    this.serviceStatus,
    this.displayOrder,
    this.iconUrl,
    this.displayConfig,
    this.plans,
  });

  factory ValueAddProductItem.fromJson(Map<String, dynamic> json) => _$ValueAddProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ValueAddProductItemToJson(this);
}

@JsonSerializable()
class Plans {
  @JsonKey(name: 'plan_id')
  String? planId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'provider')
  Map<String, Object>? provider;
  @JsonKey(name: 'attributes')
  Map<String, Object>? attributes;
  @JsonKey(name: 'availability')
  Map<String, Object>? availability;
  @JsonKey(name: 'prices')
  List<Prices>? prices;
  @JsonKey(name: 'payment_config')
  PaymentConfig? paymentConfig;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'is_recommended')
  bool? isRecommended;
  @JsonKey(name: 'is_unlimited')
  bool? isUnlimited;
  @JsonKey(name: 'supported_countries')
  List<String>? supportedCountries;

  @JsonKey(name: 'matched_device_product_ids')
  List<String>? matchedDeviceProductIds;

  Plans({
    this.planId,
    this.name,
    this.provider,
    this.attributes,
    this.availability,
    this.prices,
    this.paymentConfig,
    this.description,
    this.isRecommended,
    this.isUnlimited,
    this.supportedCountries,
    this.matchedDeviceProductIds,
  });

  factory Plans.fromJson(Map<String, dynamic> json) => _$PlansFromJson(json);

  Map<String, dynamic> toJson() => _$PlansToJson(this);

  // 支持动态传入需要转换的 key 列表
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

  Prices({this.priceId, this.currency, this.unitAmount, this.interval, this.currencySymbol});

  factory Prices.fromJson(Map<String, dynamic> json) => _$PricesFromJson(json);

  Map<String, dynamic> toJson() => _$PricesToJson(this);
}

@JsonSerializable()
class Availability {
  @JsonKey(name: 'mcc')
  List<String>? mcc;
  Availability({this.mcc});
  factory Availability.fromJson(Map<String, dynamic> json) => _$AvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);
}

@JsonSerializable()
class Attributes {
  @JsonKey(name: 'data_limit_gb')
  int? dataLimitGb;
  @JsonKey(name: 'data_unit')
  String? dataUnit;
  @JsonKey(name: 'data_total')
  int? dataTotal;
  @JsonKey(name: 'active_type')
  String? activeType;
  @JsonKey(name: 'is_contract')
  bool? isContract;
  @JsonKey(name: 'min_order_cycle')
  int? minOrderCycle;
  @JsonKey(name: 'validity_period')
  int? validityPeriod;
  @JsonKey(name: 'tuge_product_code')
  String? tugeProductCode;
  @JsonKey(name: 'tuge_product_type')
  String? tugeProductType;

  @JsonKey(name: 'storage_days')
  String? storageDays;

  @JsonKey(name: 'recording_type')
  String? recordingType;

  Attributes({
    this.dataLimitGb,
    this.dataUnit,
    this.dataTotal,
    this.activeType,
    this.isContract,
    this.minOrderCycle,
    this.validityPeriod,
    this.tugeProductCode,
    this.tugeProductType,
    this.storageDays,
    this.recordingType,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}

@JsonSerializable()
class DisplayConfig {
  DisplayConfig();

  factory DisplayConfig.fromJson(Map<String, dynamic> json) => _$DisplayConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DisplayConfigToJson(this);
}

@JsonSerializable()
class PaymentConfig {
  @JsonKey(name: 'supported_payment_channels')
  List<SupportedPaymentChannels>? supportedPaymentChannels;
  @JsonKey(name: 'supported_billing_types')
  List<SupportedBillingTypes>? supportedBillingTypes;

  PaymentConfig({this.supportedPaymentChannels, this.supportedBillingTypes});

  factory PaymentConfig.fromJson(Map<String, dynamic> json) => _$PaymentConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentConfigToJson(this);
}

@JsonSerializable()
class SupportedBillingTypes {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;

  SupportedBillingTypes({this.code, this.name, this.description});

  factory SupportedBillingTypes.fromJson(Map<String, dynamic> json) => _$SupportedBillingTypesFromJson(json);

  Map<String, dynamic> toJson() => _$SupportedBillingTypesToJson(this);
}

@JsonSerializable()
class SupportedPaymentChannels {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'icon')
  String? icon;
  @JsonKey(name: 'is_default')
  bool? isDefault;

  SupportedPaymentChannels({this.code, this.name, this.icon, this.isDefault});

  factory SupportedPaymentChannels.fromJson(Map<String, dynamic> json) => _$SupportedPaymentChannelsFromJson(json);

  Map<String, dynamic> toJson() => _$SupportedPaymentChannelsToJson(this);
}

@JsonSerializable()
class CloudGoodsBanners {
  @JsonKey(name: 'imageUrl')
  String? imageUrl;
  @JsonKey(name: 'description')
  String? description;

  CloudGoodsBanners({this.imageUrl, this.description});

  factory CloudGoodsBanners.fromJson(Map<String, dynamic> json) => _$CloudGoodsBannersFromJson(json);

  Map<String, dynamic> toJson() => _$CloudGoodsBannersToJson(this);
}

enum ValueAddProductServiceType { cloudStorage, data4G, bundle }

extension ValueAddProductServiceTypeName on ValueAddProductServiceType {
  String get typeName {
    switch (this) {
      case ValueAddProductServiceType.cloudStorage:
        return "CLOUD_STORAGE";
      case ValueAddProductServiceType.data4G:
        return "4G_DATA";
      case ValueAddProductServiceType.bundle:
        return "BUNDLE";
    }
  }
}
