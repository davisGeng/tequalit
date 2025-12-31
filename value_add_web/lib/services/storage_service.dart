import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/utils/language_manager.dart';

class StorageService extends GetxService {
  static final _instance = StorageService._();
  static StorageService get instance => _instance;

  late final SharedPreferences _prefs;

  StorageService._();

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(StorageKey key, String value) async {
    return await _prefs.setString(key.value, value);
  }

  Future<bool> setBool(StorageKey key, bool value) async {
    return await _prefs.setBool(key.value, value);
  }

  Future<bool> setStringList(StorageKey key, List<String> value) async {
    return await _prefs.setStringList(key.value, value);
  }

  String getString(StorageKey key) {
    return _prefs.getString(key.value) ?? '';
  }

  bool getBool(StorageKey key) {
    return _prefs.getBool(key.value) ?? false;
  }

  List<String> getStringList(StorageKey key) {
    return _prefs.getStringList(key.value) ?? [];
  }

  Future<bool> remove(StorageKey key) async {
    return await _prefs.remove(key.value);
  }

  Future<void> saveLocale(Locale? locale) async {
    if (locale == null) {
      await _prefs.remove('locale');
      return;
    }
    await _prefs.setString('locale', '${locale.languageCode}_${locale.countryCode}');
  }

  Locale? getLocale() {
    String? localeString = _prefs.getString('locale');
    if (localeString != null) {
      List<String> parts = localeString.split('_');
      if (parts.length > 1 && parts[1].isNotEmpty) {
        return Locale(parts[0], parts[1]);
      }
      return Locale(parts[0]);
    }
    return null;
  }

  Future<void> saveLanguageType(LanguageType type) async {
    await _prefs.setString('languageType', type.name);
  }

  LanguageType getLanguageType() {
    String? name = _prefs.getString('languageType');
    LanguageType type = LanguageType.systerm;
    if (name != null) {
      switch (name) {
        case "systerm":
          type = LanguageType.systerm;
          break;
        case "enUS":
          type = LanguageType.enUS;
          break;
        case "idID":
          type = LanguageType.idID;
          break;
        case "zhHans":
          type = LanguageType.zhHans;
          break;
        case "esES":
          type = LanguageType.esES;
          break;

        case "ptBR":
          type = LanguageType.ptBR;
          break;
        case "ruRU":
          type = LanguageType.ruRU;
          break;
        case "zhHant":
          type = LanguageType.zhHant;
          break;
        case "viVN":
          type = LanguageType.viVN;
          break;
        case "thTH":
          type = LanguageType.thTH;
          break;
        case "ukUA":
          type = LanguageType.ukUA;
          break;
        default:
          type = LanguageType.systerm;
      }
    }
    return type;
  }
}

class StorageKey {
  final String _key;

  const StorageKey.make(this._key);

  String get value => _key;

  @override
  int get hashCode => _key.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is StorageKey && runtimeType == other.runtimeType && _key == other._key;
}
