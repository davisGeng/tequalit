import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:value_add_web/services/log_service.dart';

import '../../model/country.dart';
import '../../services/storage_service.dart';
import '../widget/dialog/radio_button_dialog.dart';

class LanguageManager {
  static final _instance = LanguageManager();
  static LanguageManager get instance => _instance;

  late final SharedPreferences _prefs;
  Locale? newLocale;


  Locale getDefaultLocale() {

    Locale? deviceLocale = Get.deviceLocale;
    late Locale backLocale;
    if (deviceLocale == null) {
      return const Locale("en", "US");
    }
    String languageCode = deviceLocale.languageCode;
    String scriptCode = deviceLocale.scriptCode ?? "";

    switch (languageCode) {
      case "en":
        backLocale = LanguageType.enUS.local;
        break;
      case "id":
        backLocale = LanguageType.idID.local;
        break;
      case "zh":
        if (scriptCode == "Hant") {
          //繁体
          backLocale = LanguageType.zhHant.local;
        } else {
          backLocale = LanguageType.zhHans.local;
        }

        break;
      case "es":
        backLocale = LanguageType.esES.local;
        break;
      case "pt":
      // BR 葡萄牙语【巴西】
        backLocale = LanguageType.ptBR.local;
        break;
      case "ru":
        backLocale = LanguageType.ruRU.local;
        break;
      case "vi":
        backLocale = LanguageType.viVN.local;
        break;
      case "th":
        backLocale = LanguageType.thTH.local;
        break;
      case "uk":
        backLocale = LanguageType.ukUA.local;
        break;
      default:
        backLocale = LanguageType.enUS.local; // 英语-美国
        break;
    }
    Log.d("get defaultLocale languageCode:${backLocale.languageCode},script:${backLocale.scriptCode}");
    return backLocale;
  }

  void updateLocale(String languageCode,{String countryCode = "",String scriptCode = ""}) {
    Log.d("get updateLocale languageCode:${languageCode},script:$scriptCode");

    Locale defaultLocal = getDefaultLocale();

    if(languageCode != defaultLocal.languageCode || (scriptCode.isNotEmpty && scriptCode != defaultLocal.scriptCode)){
      Locale backLocale ;

      switch (languageCode) {
        case "en":
          backLocale = LanguageType.enUS.local;
          break;
        case "id":
          backLocale = LanguageType.idID.local;
          break;
        case "zh":
          if (scriptCode == "Hant") {
            //繁体
            backLocale = LanguageType.zhHant.local;
          } else {
            backLocale = LanguageType.zhHans.local;
          }

          break;
        case "es":
          backLocale = LanguageType.esES.local;
          break;
        case "pt":
        // BR 葡萄牙语【巴西】
          backLocale = LanguageType.ptBR.local;
          break;
        case "ru":
          backLocale = LanguageType.ruRU.local;
          break;
        case "vi":
          backLocale = LanguageType.viVN.local;
          break;
        case "th":
          backLocale = LanguageType.thTH.local;
          break;
        case "uk":
          backLocale = LanguageType.ukUA.local;
          break;
        default:
          backLocale = LanguageType.enUS.local; // 英语-美国
          break;
      }
      Log.d("update locale languageCode:${backLocale.languageCode}");

      newLocale = backLocale;
      Get.updateLocale(backLocale);

    }else{
      newLocale = defaultLocal;
    }


  }

  getSupportedLocales() {
    return const [
      Locale('en', 'US'),
      Locale('id', 'ID'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
      Locale('es', 'ES'),
      Locale('pt', 'BR'),
      Locale('ru', 'RU'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'),
      Locale('vi', 'VN'),
      Locale('th', 'TH'),
      Locale('ru', 'RU')
    ];
  }

  List<RadioButtonItem> getLanguageViewShowItems() {
    return [
      RadioButtonItem.create('system_language_label'.tr, 'system_language_instruction_label'.tr),
      RadioButtonItem.create('English', 'english_instruction_label'.tr),
      RadioButtonItem.create('Bahasa Indonesia', 'indonesian_instruction_label'.tr),
      RadioButtonItem.create('简体中文', 'chinese_instruction_label'.tr),
      RadioButtonItem.create('Español', 'spanish_instruction_label'.tr),
      RadioButtonItem.create('Português(Brasil)', 'portuguese_instruction_label'.tr),
      RadioButtonItem.create('Русский', 'russian_instruction_label'.tr),
      RadioButtonItem.create('繁体中文', 'traditional_chinese_instruction_label'.tr),
      RadioButtonItem.create('Tiếng Việt', 'vietnamese_instruction_label'.tr), //越南
      RadioButtonItem.create('ภาษาไทย', 'thailand_instruction_label'.tr), // 泰国
      RadioButtonItem.create('Yкраїнська', 'ukrainian_instruction_label'.tr),
    ];
  }



  String getShowCountryName(LocalCountry? country) {
    String name = "";
    Locale? locale = Get.locale;
    if (country == null) {
      return name;
    }
    if (locale != null) {
      String languageCode = country.languageCode;
      if (languageCode.isNotEmpty) {
        if (locale.languageCode == 'zh') {
          name = country.countryNameCN;
        } else if (locale.languageCode == languageCode) {
          //本国语言
          name = country.countryName;
        } else {
          //英文
          name = country.countryNameEN;
        }
      } else {
        name = country.countryNameEN;
      }
    } else {
      name = country.countryNameEN;
    }
    return name;
  }
}

//更改时，请同步更新 storage.getLanguageType ,要顺序一致
enum LanguageType {
  systerm,
  enUS,
  idID,
  zhHans,
  esES,
  ptBR,
  ruRU,
  zhHant,
  viVN,
  thTH,
  ukUA,
}

extension LanguageExtension on LanguageType {
  Locale get local {
    switch (this) {
      case LanguageType.systerm:
        return Get.deviceLocale ?? const Locale('en', 'US');
      case LanguageType.enUS:
        return const Locale('en', 'US');
      case LanguageType.idID:
        return const Locale('id', 'ID');
      case LanguageType.zhHans:
        return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN');
      case LanguageType.esES:
        return const Locale('es', 'ES');

      case LanguageType.ptBR:
        return const Locale('pt', 'BR');
      case LanguageType.ruRU:
        return const Locale('ru', 'RU');
      case LanguageType.zhHant:
        return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK');
      case LanguageType.viVN:
        return const Locale('vi', 'VN');
      case LanguageType.thTH:
        return const Locale('th', 'TH');
      case LanguageType.ukUA:
        return const Locale('uk', 'UA');
    }
  }
}
