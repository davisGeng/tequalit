import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

abstract class SupportAccountType {
  SupportAccountType._();

  static const String both = 'BOTH';
  static const String email = 'EMAIL';
  static const String mobile = 'MOBILE';

  static List<String> valuesOf(String type) {
    if (type == both) {
      return [email, mobile];
    } else {
      return [type];
    }
  }

  static String trOf(String type) {
    if (type == email) {
      return 'email_label'.tr;
    } else if (type == mobile) {
      return 'phone_label'.tr;
    } else {
      return type;
    }
  }
}

@JsonSerializable()
class Country {
  @JsonKey(name: 'country_code')
  String? countryCode;

  @JsonKey(name: 'country_name')
  String? countryName;

  @JsonKey(name: 'phone_prefix')
  String? phonePrefix;

  @JsonKey(name: 'registration_method')
  String? registrationMethod;

  @JsonKey(name: 'api_base_url')
  String? apiBaseUrl;

  Country({this.countryCode, this.countryName, this.phonePrefix, this.registrationMethod, this.apiBaseUrl});

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

class LocalCountry {
  final String countryName;
  final String countryNameEN;
  final String countryNameCN;
  final String languageCode;
  String countryCode;
  String registrationMethod;
  final String phonePrefix;
  String? apiBaseUrl;
  LocalCountry(
      {required this.countryName,
      required this.countryNameEN,
      required this.countryNameCN,
      required this.languageCode,
      required this.countryCode,
      required this.registrationMethod,
      required this.phonePrefix,
      this.apiBaseUrl});

  // 工厂方法：从 JSON 映射创建 Country 对象
  factory LocalCountry.fromJson(Map<String, dynamic> json) {
    return LocalCountry(
      countryName: json['countryName'] ?? '',
      countryNameEN: json['countryNameEN'] ?? '',
      countryNameCN: json['countryNameCN'] ?? '',
      languageCode: json['languageCode'] ?? '',
      countryCode: json['countryCode'] ?? '',
      registrationMethod: json['registrationMethod'] ?? '',
      phonePrefix: json['phonePrefix'] ?? '',
      apiBaseUrl: json['apiBaseUrl'] ?? '',
    );
  }

  // 可选：将 Country 对象转换为 JSON 映射
  Map<String, dynamic> toJson() {
    return {
      'countryName': countryName,
      'countryNameEN': countryNameEN,
      'countryNameCN': countryNameCN,
      'languageCode': languageCode,
      'countryCode': countryCode,
      'registrationMethod': registrationMethod,
      'phonePrefix': phonePrefix,
      'apiBaseUrl': apiBaseUrl
    };
  }
}

class LocalCountryManager {
  // 私有构造函数
  LocalCountryManager._privateConstructor();

  // 单例实例
  static final LocalCountryManager instance = LocalCountryManager._privateConstructor();

  // 国家数据缓存
  List<LocalCountry>? _defaultCountries;

  // 获取默认国家列表
  Future<List<LocalCountry>> getDefaultCountries() async {
    _defaultCountries ??= await loadCountriesFromAssets();
    return _defaultCountries!;
  }

  // 解析 JSON 字符串为 Country 列表
  List<LocalCountry> parseCountries(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => LocalCountry.fromJson(json)).toList();
  }

  // 从 assets 加载并解析 JSON 文件
  Future<List<LocalCountry>> loadCountriesFromAssets() async {
    final String jsonString = await rootBundle.loadString('assets/data/login_local_country.json');
    return parseCountries(jsonString);
  }
}

/// 默认国家
const String defaultCountryCode = "US";

/// 默认语言
const String defaultLanguageCode = "en";

/// 默认可选国家信息
final List<Country> defaultCountrys = [
  Country()
    ..countryName = "中国"
    ..countryCode = "CN"
    ..phonePrefix = "+86"
    ..registrationMethod = SupportAccountType.both,
  Country()
    ..countryName = "United States"
    ..countryCode = "US"
    ..phonePrefix = "+1"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Canada"
    ..countryCode = "CA"
    ..phonePrefix = "+1"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Japan"
    ..countryCode = "JP"
    ..phonePrefix = "+81"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "South Korean"
    ..countryCode = "KR"
    ..phonePrefix = "+82"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Mexico"
    ..countryCode = "MX"
    ..phonePrefix = "+52"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "India"
    ..countryCode = "IN"
    ..phonePrefix = "+91"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Turkey"
    ..countryCode = "TR"
    ..phonePrefix = "+90"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Vietnam"
    ..countryCode = "VN"
    ..phonePrefix = "+84"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Thailand"
    ..countryCode = "TH"
    ..phonePrefix = "+66"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Germany"
    ..countryCode = "DE"
    ..phonePrefix = "+49"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Italy"
    ..countryCode = "IT"
    ..phonePrefix = "+39"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "France"
    ..countryCode = "FR"
    ..phonePrefix = "+33"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "United Kingdom"
    ..countryCode = "GB"
    ..phonePrefix = "+44"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Brazil"
    ..countryCode = "BR"
    ..phonePrefix = "+55"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Chile"
    ..countryCode = "CL"
    ..phonePrefix = "+56"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Indonesia"
    ..countryCode = "ID"
    ..phonePrefix = "+62"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Russia"
    ..countryCode = "RU"
    ..phonePrefix = "+7"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "United Arab Emirates"
    ..countryCode = "AE"
    ..phonePrefix = "+971"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Spain"
    ..countryCode = "ES"
    ..phonePrefix = "+34"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Peru"
    ..countryCode = "PE"
    ..phonePrefix = "+51"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "South Africa"
    ..countryCode = "ZA"
    ..phonePrefix = "+27"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Brunei Darussalam"
    ..countryCode = "BN"
    ..phonePrefix = "+673"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Ukraine"
    ..countryCode = "UA"
    ..phonePrefix = "+380"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Saudi Arabia"
    ..countryCode = "SA"
    ..phonePrefix = "+966"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Argentina"
    ..countryCode = "AR"
    ..phonePrefix = "+54"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Senegal"
    ..countryCode = "SN"
    ..phonePrefix = "+221"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Romania"
    ..countryCode = "RO"
    ..phonePrefix = "+40"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Oman"
    ..countryCode = "OM"
    ..phonePrefix = "+968"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Kuwait"
    ..countryCode = "KW"
    ..phonePrefix = "+965"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Bahrain"
    ..countryCode = "BH"
    ..phonePrefix = "+973"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Kyrgyzstan"
    ..countryCode = "KG"
    ..phonePrefix = "+996"
    ..registrationMethod = SupportAccountType.email,
  Country()
    ..countryName = "Guatemala"
    ..countryCode = "GT"
    ..phonePrefix = "+502"
    ..registrationMethod = SupportAccountType.email,
];
