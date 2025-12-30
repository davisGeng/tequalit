// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_add_service_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueAddServiceItem _$ValueAddServiceItemFromJson(Map<String, dynamic> json) =>
    ValueAddServiceItem(
      pkid: json['pkid'] as String?,
      createTime: json['createTime'] as String?,
      imageUrl: json['imageUrl'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      isAvailable: json['isAvailable'] as String?,
    );

Map<String, dynamic> _$ValueAddServiceItemToJson(
  ValueAddServiceItem instance,
) => <String, dynamic>{
  'pkid': instance.pkid,
  'createTime': instance.createTime,
  'imageUrl': instance.imageUrl,
  'title': instance.title,
  'description': instance.description,
  'isAvailable': instance.isAvailable,
};
