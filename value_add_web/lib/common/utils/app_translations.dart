import 'package:get/get.dart';

import '../../translations/en_us.dart';
import '../../translations/es_es.dart';
import '../../translations/id_ID.dart';
import '../../translations/pt_BR.dart';
import '../../translations/ru_RU.dart';
import '../../translations/th_TH.dart';
import '../../translations/uk_UA.dart';
import '../../translations/vi_VN.dart';
import '../../translations/zh_HK.dart';
import '../../translations/zh_cn.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'id_ID': IdID.translations,
        'es_ES': EsEs.translations,
        'pt_BR': PtBR.translations,
        'ru_RU': RuRU.translations,
        'vi_VN': ViVN.translations,
        'th_TH': ThTH.translations,
        'uk_UA': UkUA.translations,
        'zh_HK': ZhHK.translations,
        'zh_TW': ZhHK.translations,
        'zh_MO': ZhHK.translations,
        'zh': ZhCn.translations,
        'en_US': EnUs.translations,
      };
}
