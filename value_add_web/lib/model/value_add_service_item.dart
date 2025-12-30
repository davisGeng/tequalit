import 'package:json_annotation/json_annotation.dart';
part 'value_add_service_item.g.dart';

@JsonSerializable()
class ValueAddServiceItem {
  @JsonKey(name: 'pkid')
  String? pkid;
  @JsonKey(name: 'createTime')
  String? createTime;
  @JsonKey(name: 'imageUrl')
  String? imageUrl;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'isAvailable')
  String? isAvailable;

  ValueAddServiceItem({this.pkid, this.createTime, this.imageUrl, this.title, this.description, this.isAvailable});

  factory ValueAddServiceItem.fromJson(Map<String, dynamic> json) => _$ValueAddServiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$ValueAddServiceItemToJson(this);
}