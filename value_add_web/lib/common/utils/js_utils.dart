import 'dart:html' as html; // Web端专属：必须导入，用于获取URL参数
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:value_add_web/common/utils/language_manager.dart';
// import 'package:value_add_web/services/log_service.dart';
import 'dart:js' as js;
import 'dart:convert';

import 'package:value_add_web/common/utils/text_utils.dart';

/// Web端URL Locale解析工具类
class JsUtils {
  static final _instance = JsUtils();
  static JsUtils get instance => _instance;

  int deviceCount = 0;
  String userToken = "";
  bool hadUpdateDevice = false;
  List<Map<String, dynamic>> deviceMaps = [];

  String appPlatform = "android";
  double topBarHeight = 0;
  double bottomBarHeight = 0;

  /// 从URL参数中解析Locale，无参数返回null
  void init() {
    final urlParams = WebParamParser.parseUrlParams();
    if (urlParams.isNotEmpty) {
      // 获取具体参数
      String languageCode = WebParamParser.getParam("languageCode") ?? "";
      String countryCode = urlParams['countryCode'] ?? "";
      String scriptCode = urlParams['scriptCode'] ?? "";
      userToken = urlParams['userToken'] ?? "";
      appPlatform = urlParams['appPlatform'] ?? "";
      String topBarHeightString = urlParams['topBarHeight'] ?? "";
      String bottomBarHeightString = urlParams['bottomBarHeight'] ?? "";
      topBarHeight = TextUtils.stringToDouble(topBarHeightString);
      bottomBarHeight = TextUtils.stringToDouble(bottomBarHeightString);

      debugPrint(
        "urlParams: userToken:$userToken,topH:$topBarHeightString,boH:$bottomBarHeightString",
      );
      if (languageCode.isNotEmpty) {
        LanguageManager.instance.updateLocale(
          languageCode,
          countryCode: countryCode,
          scriptCode: scriptCode,
        );
      }
    }
    deviceMaps = [
      {
        "deviceId": "ubuntu_esxi-e11d94dc-3396-4398-89ec-63e364d4c234",
        "firmwareVersion": "1.0.96",
        "deviceName": "hm2",
        "deviceThirdPartId": "6cfc926ee1e6877380nbao",
        "uuid": "1122312000233",
      },
    ];
    _registerNativeMessageListener();
  }

  /// 核心1：注册JS全局方法，供原生A调用（接收A的消息）
  void _registerNativeMessageListener() {
    // 向浏览器window对象挂载JS方法：receiveNativeMessage
    js.context["receiveNativeMessage"] = (String jsonStr) {
      // 解析原生A传来的JSON字符串
      final Map<String, dynamic> data = json.decode(jsonStr);
      debugPrint("✅ Web-B收到原生A的消息：$data");
    };
    js.context["receiveNativeDeviceList"] = (String jsonStr) {
      // 解析原生A传来的JSON字符串
      List<Map<String, dynamic>> _deviceList = List<Map<String, dynamic>>.from(
        json.decode(jsonStr),
      );
      // deviceMaps = _deviceList;

      debugPrint("✅ Web-B收到原生A的消息：${_deviceList.length}");
    };
    sendMessageToNative(type: "ready");
  }

  /// 【已修复】Web-B → 发送消息到原生A（正确调用原生注册的通道）
  void sendMessageToNative({String type = "toast"}) {
    // ========== ✅ 第一步：检查APP通道是否注册（核心） ==========
    if (js.context["flutter_app_web_channel"] == null) {
      debugPrint("❌ 检查失败：APP未注册 flutter_app_web_channel 通道，终止发送");
      return; // 通道不存在，直接终止方法
    }
    // 1. 构造消息体（格式不变，与A端约定一致）
    final Map<String, dynamic> sendData = {
      "type": type,
      "content": "我是Web-B发来的消息，请求原生显示提示",
      "from": "flutter_web_b",
    };
    String jsonStr = json.encode(sendData);

    // ✅ 正确写法（分两步调用：先获取通道对象，再调用postMessage）
    js.JsObject channel = js.context["flutter_app_web_channel"];
    channel.callMethod("postMessage", [jsonStr]);

    debugPrint("✅ Web-B已向原生A发送消息：$sendData");
  }

  /// 核心3：Web-B 一键返回原生A（URL Scheme协议跳转，最优方案）
  void backToNativeApp() {
    debugPrint("🚀 Web-B触发返回原生A");
    // 调用浏览器JS，跳转自定义Scheme协议（A端会拦截该请求）
    js.context.callMethod("open", ["flutterapp://backToNative"]);
    // 进阶：带参数返回 → flutterapp://backToNative?params={"id":123,"name":"test"}
    // js.context.callMethod("open", ["flutterapp://backToNative?params=${Uri.encodeComponent(json.encode({"id":123}))}"]);
  }

  Widget buildPlatformBackIcon(VoidCallback? onTap) {
    void onBackPressed() {
      Get.back();
    }

    if (appPlatform == TargetPlatform.iOS.name) {
      // 直接判断 TargetPlatform 类型，比对比 name 更安全
      return IconButton(
        icon: const Icon(CupertinoIcons.back, size: 24, color: Colors.black),
        onPressed: onTap ?? onBackPressed, // 绑定点击事件
        padding: EdgeInsets.zero, // 可选：移除 IconButton 默认内边距，贴合原生样式
        constraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ), // 符合原生点击区域规范
      );
    } else {
      // 安卓风格可点击返回图标
      return IconButton(
        icon: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
        onPressed: onTap ?? onBackPressed, // 绑定点击事件
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      );
    }
  }
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
