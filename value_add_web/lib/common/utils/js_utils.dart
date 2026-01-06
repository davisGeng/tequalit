import 'dart:html' as html; // Web端专属：必须导入，用于获取URL参数
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:value_add_web/common/utils/language_manager.dart';
import 'package:value_add_web/services/log_service.dart';
import 'dart:js' as js;
import 'dart:convert';

/// Web端URL Locale解析工具类
class JsUtils {

  static final _instance = JsUtils();
  static JsUtils get instance => _instance;

  int deviceCount = 0;
  /// 从URL参数中解析Locale，无参数返回null
  void init(){

    final urlParams = WebParamParser.parseUrlParams();
    if(urlParams.isNotEmpty){
      // 获取具体参数
      String languageCode = WebParamParser.getParam("languageCode") ?? "";
      String countryCode = urlParams['countryCode'] ?? "";
      String scriptCode = urlParams['scriptCode'] ?? "";
      if(languageCode.isNotEmpty){
        LanguageManager.instance.updateLocale(languageCode,countryCode: countryCode,scriptCode: scriptCode);
      }


    }


    // _registerNativeMessageListener();
  }
  void _registerNativeMessageListener(){

    // 向浏览器window对象挂载JS方法：receiveNativeMessage
    js.context["receiveNativeMessage"] = (String jsonStr) {
      debugPrint("✅ Web-收到原生App的消息jsonStr：$jsonStr");

      if(jsonStr.isNotEmpty){
        // 解析原生A传来的JSON字符串
        final Map<String, dynamic> data = json.decode(jsonStr);
        debugPrint("✅ Web-收到原生App的消息：$data");

        String languageCode = data['languageCode'] ?? "";
        String countryCode = data['countryCode'] ?? "";
        String scriptCode = data['scriptCode'] ?? "";
        print("pare not null:lanCode:${languageCode}");

        if(languageCode.isNotEmpty){
          LanguageManager.instance.updateLocale(languageCode,countryCode: countryCode,scriptCode: scriptCode);
        }

      }


    };
  }
  //  Locale parseLocaleFromUrl() {
  //   // 1. 获取Web端当前URL的所有查询参数
  //   final queryParams = html.window.location.search;
  //   Log.d("parseLocal form App url:$queryParams");
  //   print("pare null ::${queryParams}");
  //
  //   if (queryParams == null){
  //     Locale? deviceLocale = Get.deviceLocale;
  //     Log.d("parseLocal form deviceLocal :${deviceLocale?.languageCode}");
  //
  //     if (deviceLocale == null) {
  //       return const Locale("en", "US");
  //     }else{
  //       return deviceLocale;
  //     }
  //   }else{
  //
  //     // 2. 解析locale参数值（如：?locale=zh_CN → zh_CN）
  //     final params = Uri.parse(queryParams).queryParameters;
  //     final languageCode = params['languageCode'] ?? "";
  //     final countryCode = params['countryCode'] ?? "";
  //     final scriptCode = params['scriptCode'] ?? "";
  //     print("pare not null:lanCode:${languageCode}");
  //
  //     Locale backLocale = LanguageManager.instance.getDeviceLocale(languageCode,countryCode: countryCode,scriptCode: scriptCode);
  //     return backLocale;
  //   }
  //
  // }
}

class WebParamParser {
  // 解析URL中所有查询参数，返回键值对
  static Map<String, String> parseUrlParams() {
    final searchParams = html.window.location.search;
    if (searchParams == null) return {};
    // 自动解析URL查询参数（含编码解码）
    return Uri.parse(searchParams).queryParameters;
  }

  // 快捷获取指定参数（支持默认值）
  static String? getParam(String key, {String? defaultValue}) {
    return parseUrlParams()[key] ?? defaultValue;
  }
}
