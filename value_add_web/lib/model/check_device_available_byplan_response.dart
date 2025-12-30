import 'package:json_annotation/json_annotation.dart';
part 'check_device_available_byplan_response.g.dart';

@JsonSerializable()
class CheckDeviceAvailableByplanResponse {
  @JsonKey(name: 'results')
  List<DeviceAvailableResults>? results;
  @JsonKey(name: 'summary')
  Summary? summary;

  CheckDeviceAvailableByplanResponse({this.results, this.summary});

  factory CheckDeviceAvailableByplanResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$CheckDeviceAvailableByplanResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckDeviceAvailableByplanResponseToJson(this);
}

@JsonSerializable()
class Summary {
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'compatible')
  int? compatible;
  @JsonKey(name: 'incompatible')
  int? incompatible;

  Summary({this.total, this.compatible, this.incompatible});

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryToJson(this);
}

@JsonSerializable()
class DeviceAvailableResults {
  @JsonKey(name: 'device_id')
  String? deviceId;
  @JsonKey(name: 'third_part_deviceId')
  String? thirdPartDeviceId;
  @JsonKey(name: 'device_name')
  String? deviceName;
  @JsonKey(name: 'model')
  dynamic model;
  @JsonKey(name: 'firmware_version')
  String? firmwareVersion;
  @JsonKey(name: 'compatible')
  bool compatible;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'iccid')
  String? iccid;

  DeviceAvailableResults({
    this.deviceId,
    this.thirdPartDeviceId,
    this.deviceName,
    this.model,
    this.firmwareVersion,
    required this.compatible,
    this.message,
    this.iccid,
  });

  factory DeviceAvailableResults.fromJson(Map<String, dynamic> json) =>
      _$DeviceAvailableResultsFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceAvailableResultsToJson(this);
}
