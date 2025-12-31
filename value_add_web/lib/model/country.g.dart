// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      countryCode: json['country_code'] as String?,
      countryName: json['country_name'] as String?,
      phonePrefix: json['phone_prefix'] as String?,
      registrationMethod: json['registration_method'] as String?,
      apiBaseUrl: json['api_base_url'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'country_code': instance.countryCode,
      'country_name': instance.countryName,
      'phone_prefix': instance.phonePrefix,
      'registration_method': instance.registrationMethod,
      'api_base_url': instance.apiBaseUrl,
    };
