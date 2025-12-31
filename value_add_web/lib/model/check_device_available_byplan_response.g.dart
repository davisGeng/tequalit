// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_device_available_byplan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckDeviceAvailableByplanResponse _$CheckDeviceAvailableByplanResponseFromJson(
        Map<String, dynamic> json) =>
    CheckDeviceAvailableByplanResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map(
              (e) => DeviceAvailableResults.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: json['summary'] == null
          ? null
          : Summary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckDeviceAvailableByplanResponseToJson(
        CheckDeviceAvailableByplanResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'summary': instance.summary,
    };

Summary _$SummaryFromJson(Map<String, dynamic> json) => Summary(
      total: (json['total'] as num?)?.toInt(),
      compatible: (json['compatible'] as num?)?.toInt(),
      incompatible: (json['incompatible'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'total': instance.total,
      'compatible': instance.compatible,
      'incompatible': instance.incompatible,
    };

DeviceAvailableResults _$DeviceAvailableResultsFromJson(
        Map<String, dynamic> json) =>
    DeviceAvailableResults(
      deviceId: json['device_id'] as String?,
      thirdPartDeviceId: json['third_part_deviceId'] as String?,
      deviceName: json['device_name'] as String?,
      model: json['model'],
      firmwareVersion: json['firmware_version'] as String?,
      compatible: json['compatible'] as bool,
      message: json['message'] as String?,
      iccid: json['iccid'] as String?,
    );

Map<String, dynamic> _$DeviceAvailableResultsToJson(
        DeviceAvailableResults instance) =>
    <String, dynamic>{
      'device_id': instance.deviceId,
      'third_part_deviceId': instance.thirdPartDeviceId,
      'device_name': instance.deviceName,
      'model': instance.model,
      'firmware_version': instance.firmwareVersion,
      'compatible': instance.compatible,
      'message': instance.message,
      'iccid': instance.iccid,
    };
