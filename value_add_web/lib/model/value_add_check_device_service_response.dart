import 'package:json_annotation/json_annotation.dart';
part 'value_add_check_device_service_response.g.dart';

@JsonSerializable()
class ValueAddCheckDeviceServiceResponse {
  @JsonKey(name: 'has_entitlement')
  bool? hasEntitlement;
  @JsonKey(name: 'services')
  Services? services;

  ValueAddCheckDeviceServiceResponse({this.hasEntitlement, this.services});

  factory ValueAddCheckDeviceServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ValueAddCheckDeviceServiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValueAddCheckDeviceServiceResponseToJson(this);
}

@JsonSerializable()
class Services {
  @JsonKey(name: 'CLOUD_STORAGE')
  ServiceDetail? cloudStorage;
  @JsonKey(name: 'BUNDLE')
  ServiceDetail? bundle;
  @JsonKey(name: '4G_DATA')
  ServiceDetail? data4G;

  Services({this.cloudStorage, this.bundle, this.data4G});

  factory Services.fromJson(Map<String, dynamic> json) => _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}

@JsonSerializable()
class ServiceDetail {
  @JsonKey(name: 'plan_name')
  String? planName;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'period_end_date')
  String? periodEndDate;
  @JsonKey(name: 'attributes')
  Map<String, Object>? attributes;

  ServiceDetail({this.planName, this.status, this.periodEndDate, this.attributes});

  factory ServiceDetail.fromJson(Map<String, dynamic> json) => _$ServiceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDetailToJson(this);

  Map<String, Object>? getAttribute() {
    if (attributes == null) return null;

    Map<String, Object> map = Map.from(attributes!);

    void convertDoubleToInt(String key) {
      final dynamic value = map[key];
      if (value is double && value == value.toInt()) {
        map[key] = value.toInt();
      }
    }

    List<String> convertKeys = const ["duration_days", "data_total", "storage_days"];
    // 遍历 key 列表处理
    for (final key in convertKeys) {
      convertDoubleToInt(key);
    }

    return map;
  }
}
