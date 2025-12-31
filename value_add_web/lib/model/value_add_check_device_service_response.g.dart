// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_add_check_device_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueAddCheckDeviceServiceResponse _$ValueAddCheckDeviceServiceResponseFromJson(
        Map<String, dynamic> json) =>
    ValueAddCheckDeviceServiceResponse(
      hasEntitlement: json['has_entitlement'] as bool?,
      services: json['services'] == null
          ? null
          : Services.fromJson(json['services'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValueAddCheckDeviceServiceResponseToJson(
        ValueAddCheckDeviceServiceResponse instance) =>
    <String, dynamic>{
      'has_entitlement': instance.hasEntitlement,
      'services': instance.services,
    };

Services _$ServicesFromJson(Map<String, dynamic> json) => Services(
      cloudStorage: json['CLOUD_STORAGE'] == null
          ? null
          : ServiceDetail.fromJson(
              json['CLOUD_STORAGE'] as Map<String, dynamic>),
      bundle: json['BUNDLE'] == null
          ? null
          : ServiceDetail.fromJson(json['BUNDLE'] as Map<String, dynamic>),
      data4G: json['4G_DATA'] == null
          ? null
          : ServiceDetail.fromJson(json['4G_DATA'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
      'CLOUD_STORAGE': instance.cloudStorage,
      'BUNDLE': instance.bundle,
      '4G_DATA': instance.data4G,
    };

ServiceDetail _$ServiceDetailFromJson(Map<String, dynamic> json) =>
    ServiceDetail(
      planName: json['plan_name'] as String?,
      status: json['status'] as String?,
      periodEndDate: json['period_end_date'] as String?,
      attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Object),
      ),
    );

Map<String, dynamic> _$ServiceDetailToJson(ServiceDetail instance) =>
    <String, dynamic>{
      'plan_name': instance.planName,
      'status': instance.status,
      'period_end_date': instance.periodEndDate,
      'attributes': instance.attributes,
    };
