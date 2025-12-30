import 'package:json_annotation/json_annotation.dart';
import 'package:value_add_web/model/value_add_product_response.dart';
part 'value_add_support_device_plans_response.g.dart';

@JsonSerializable()
class ValueAddSupportDevicePlansResponse {
  @JsonKey(name: 'items')
  List<Plans>? items;
  @JsonKey(name: 'pagination')
  Pagination? pagination;

  ValueAddSupportDevicePlansResponse({this.items, this.pagination});

  factory ValueAddSupportDevicePlansResponse.fromJson(Map<String, dynamic> json) => _$ValueAddSupportDevicePlansResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValueAddSupportDevicePlansResponseToJson(this);
}
