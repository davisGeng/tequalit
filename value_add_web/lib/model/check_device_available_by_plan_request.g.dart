// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_device_available_by_plan_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckDeviceAvailableByPlanRequest _$CheckDeviceAvailableByPlanRequestFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['devices'],
  );
  return CheckDeviceAvailableByPlanRequest(
    devices: (json['devices'] as List<dynamic>)
        .map((e) => SimpleDevice.fromJson(e as Map<String, dynamic>))
        .toList(),
    planId: json['plan_id'] as String?,
  );
}

Map<String, dynamic> _$CheckDeviceAvailableByPlanRequestToJson(
        CheckDeviceAvailableByPlanRequest instance) =>
    <String, dynamic>{
      'devices': instance.devices,
      'plan_id': instance.planId,
    };

SimpleDevice _$SimpleDeviceFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['device_id', 'firmware_version'],
  );
  return SimpleDevice(
    firmwareVersion: json['firmware_version'] as String,
    deviceId: json['device_id'] as String,
    model: json['model'] as String?,
  );
}

Map<String, dynamic> _$SimpleDeviceToJson(SimpleDevice instance) =>
    <String, dynamic>{
      'device_id': instance.deviceId,
      'model': instance.model,
      'firmware_version': instance.firmwareVersion,
    };
