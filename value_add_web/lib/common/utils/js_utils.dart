import 'dart:html' as html; // Web端专属：必须导入，用于获取URL参数
import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:value_add_web/common/utils/language_manager.dart';
// import 'package:value_add_web/services/log_service.dart';
import 'dart:js' as js;
import 'dart:convert';

import 'package:value_add_web/common/utils/text_utils.dart';

// 给enum添加常量字符串属性typeName（编译时常量）
enum FromType { native, paymentWeb, unknown }

enum MessageType { nativeMessage, nativeDeviceList, paymentResult, unknown }

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
        "deviceId": "ubuntu_esxi-308793a3-cae9-4734-bee9-6c71eb6edbee",
        "firmwareVersion": "1.0.96",
        "deviceName": "hmm",
        "deviceThirdPartId": "120001014120366d",
        "uuid": "120001014120366d",
      },
    ];
    _registerMessageListener();
  }

  // {
  //   fromeType:"",
  //   messageType:"",
  //   status:"",
  //   data:""
  // }
  /// 核心1：注册JS全局方法，供原生A调用（接收A的消息）
  void _registerMessageListener() {
    // 向浏览器window对象挂载JS方法：receiveNativeMessage
    js.context["receiveMessage"] = (String jsonStr) {
      // 解析原生A传来的JSON字符串
      final Map<String, dynamic> data = json.decode(jsonStr);
      debugPrint("✅ Web-B收到的消息：$data");
      _handleMessage(data);
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

  void _handleMessage(Map<String, dynamic> data) {
    String fromType = data["fromeType"] ?? "";
    if (fromType.equalsIgnoreCase(FromType.native.name)) {
      String messageType = data['messageType'] ?? "";
      if (messageType.equalsIgnoreCase(MessageType.nativeMessage.name)) {
      } else if (messageType.equalsIgnoreCase(
        MessageType.nativeDeviceList.name,
      )) {
      } else {}
    } else if (fromType.equalsIgnoreCase(FromType.paymentWeb.name)) {
    } else {}
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

class WebParamsStore extends GetxController {
  // 响应式变量（.obs），支持实时更新UI
  RxString paymentStatus = '未收到'.obs;
  RxString timestamp = ''.obs;

  // 👉 定义带参数的构造方法（解决你的核心问题）
  // {String? paymentStatus, String? timestamp} 是可选参数，避免实例化时必须传值
  WebParamsStore({String? paymentStatus, String? timestamp}) {
    // 如果传入了参数，就初始化响应式变量
    if (paymentStatus != null) {
      this.paymentStatus.value = paymentStatus;
    }
    if (timestamp != null) {
      this.timestamp.value = timestamp;
    }
  }

  // 更新参数的方法（供其他页面调用）
  void updateStatus(String status, String time) {
    paymentStatus.value = status;
    timestamp.value = time;
  }

  // 可选：清空参数的方法（比如重新跳转B前重置）
  void clear() {
    paymentStatus.value = '未收到';
    timestamp.value = '';
  }
}
