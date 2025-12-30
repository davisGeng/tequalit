// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_add_support_device_plans_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueAddSupportDevicePlansResponse _$ValueAddSupportDevicePlansResponseFromJson(
  Map<String, dynamic> json,
) => ValueAddSupportDevicePlansResponse(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Plans.fromJson(e as Map<String, dynamic>))
          .toList(),
  pagination:
      json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ValueAddSupportDevicePlansResponseToJson(
  ValueAddSupportDevicePlansResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'pagination': instance.pagination,
};
