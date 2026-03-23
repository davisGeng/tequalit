import 'dart:html' as html; // Web端专属：必须导入，用于获取URL参数
import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:value_add_web/common/utils/language_manager.dart';
// import 'package:value_add_web/services/log_service.dart';
import 'dart:js' as js;
import 'dart:convert';

import 'package:value_add_web/common/utils/text_utils.dart';
import 'package:value_add_web/common/widget/basic_toast.dart';

// 给enum添加常量字符串属性typeName（编译时常量）
enum FromType { native, paymentWeb, unknown }

enum MessageType { nativeMessage, nativeDeviceList, paymentResult, unknown }

/// Web端URL Locale解析工具类
class JsUtils {
  static final _instance = JsUtils();
  static JsUtils get instance => _instance;

  String flutterAppChannel = "flutter_app_web_channel";

  int deviceCount = 0;
  String userToken = "";
  bool hadUpdateDevice = false;
  List<Map<String, dynamic>> deviceMaps = [];

  String platform = "android";
  double topBarHeight = 0;
  double bottomBarHeight = 0;

  /// 从URL参数中解析Locale，无参数返回null
  Future init() async {
    final urlParams = WebParamParser.parseUrlParams();
    if (urlParams.isNotEmpty) {
      // 获取具体参数
      String languageCode = WebParamParser.getParam("languageCode") ?? "";
      String countryCode = urlParams['countryCode'] ?? "";
      String scriptCode = urlParams['scriptCode'] ?? "";
      userToken = urlParams['userToken'] ?? "";
      platform = urlParams['platform'] ?? "";

      topBarHeight = TextUtils.stringToDouble(urlParams['topBarHeight'] ?? "");
      bottomBarHeight = TextUtils.stringToDouble(urlParams['bottomBarHeight'] ?? "");

      debugPrint("urlParams: userToken:$userToken,topH:$topBarHeight,boH:$bottomBarHeight");
      if (languageCode.isNotEmpty) {
        LanguageManager.instance.updateLocale(languageCode, countryCode: countryCode, scriptCode: scriptCode);
      }
    }
    // deviceMaps = [
    //   {
    //     "deviceId": "ubuntu_esxi-308793a3-cae9-4734-bee9-6c71eb6edbee",
    //     "firmwareVersion": "1.0.96",
    //     "deviceName": "hmm",
    //     "deviceThirdPartId": "120001014120366d",
    //     "uuid": "120001014120366d",
    //   },
    //   {
    //     "deviceId": "ubuntu_esxi-3feab686-966f-4656-9293-1fed935677f9",
    //     "firmwareVersion": "1.0.96",
    //     "deviceName": "uty",
    //     "deviceThirdPartId": "6c2c392a057bba4372lrsa",
    //     "uuid": "6c2c392a057bba4372lrsa",
    //   },
    // ];
    //传入platform
    _registerMessageListener(isIos: platform.equalsIgnoreCase(TargetPlatform.iOS.name));
  }

  /// 核心1：注册JS全局方法，供原生A调用（接收A的消息）
  void _registerMessageListener({bool isIos = false}) {
    // 向浏览器window对象挂载JS方法：receiveNativeMessage
    // js.context["receiveMessage"] = (String jsonStr) {
    //   // 解析原生A传来的JSON字符串
    //   final Map<String, dynamic> data = json.decode(jsonStr);
    //   debugPrint("✅ Web-B收到的消息：$data");
    //   _handleMessage(data);
    // };
    // js.context["receiveNativeDeviceList"] = (String jsonStr) {
    //   // 解析原生A传来的JSON字符串
    //   List<Map<String, dynamic>> _deviceList = List<Map<String, dynamic>>.from(json.decode(jsonStr));
    //   // deviceMaps = _deviceList;

    //   debugPrint("✅ Web-B收到原生A的消息：${_deviceList.length}");
    // };

    // ✅ 正确方式：监听 window 的 message 事件，App postmessage
    html.window.addEventListener('message', (html.Event event) {
      try {
        final html.MessageEvent msgEvent = event as html.MessageEvent;
        debugPrint("📦 收到原生消息：${msgEvent.data}");

        String jsonStr = msgEvent.data as String;
        Map<String, dynamic> parsedData = jsonDecode(jsonStr);

        _handleParsedData(parsedData);
      } catch (e, stack) {
        debugPrint("❌ 处理 message 事件异常：$e\n堆栈：$stack");
      }
    });
    // web 监听已设置
    if (isIos) {
      sendMessageToNativeIOS(type: "jsReady");
    } else {
      sendMessageToNative(type: "jsReady");
    }
  }

  /// Web → 发送消息到App
  void sendMessageToNative({String type = "toast"}) {
    // ========== ✅ 第一步：检查APP通道是否注册（核心） ==========
    if (js.context[flutterAppChannel] == null) {
      debugPrint("❌ 检查失败：APP未注册 $flutterAppChannel 通道，终止发送");
      return; // 通道不存在，直接终止方法
    }
    // 1. 构造消息体（格式不变，与A端约定一致）
    final Map<String, dynamic> sendData = {"type": type, "data": "我是Web-B发来的消息，请求原生显示提示", "from": "flutter_web_b"};
    String jsonStr = json.encode(sendData);

    // ✅ 正确写法（分两步调用：先获取通道对象，再调用postMessage）
    js.JsObject channel = js.context[flutterAppChannel];
    channel.callMethod("postMessage", [jsonStr]);

    debugPrint("✅ Web-B已向原生A发送消息：$sendData");
  }

  // Web → 发送消息到App
  void sendMessageToNativeIOS({String type = "toast"}) {
    // ========== ✅ 第一步：检查APP通道是否注册（核心） ==========
    js.JsObject? webkit = js.context["webkit"] as js.JsObject?;
    if (webkit == null) {
      debugPrint("❌ 环境不支持：webkit 对象不存在（非WKWebView环境）");
      return;
    }

    js.JsObject? messageHandlers = webkit["messageHandlers"] as js.JsObject?;
    if (messageHandlers == null) {
      debugPrint("❌ 检查失败：webkit.messageHandlers 不存在");
      return;
    }
    // 检查目标通道是否存在
    if (messageHandlers[flutterAppChannel] == null) {
      debugPrint("❌ 检查失败：APP未注册 $flutterAppChannel 通道");
      return;
    }

    final Map<String, dynamic> sendData = {"type": type, "data": "我是Web-B发来的消息，请求原生显示提示", "from": "flutter_web_b"};
    String jsonStr = json.encode(sendData);

    js.JsObject channel = messageHandlers[""] as js.JsObject;
    channel.callMethod("postMessage", [jsonStr]);
    debugPrint("✅ Web-B已向原生A发送消息：$sendData");
  }

  Widget buildPlatformBackIcon(VoidCallback? onTap) {
    void onBackPressed() {
      Get.back();
    }

    if (platform.equalsIgnoreCase(TargetPlatform.iOS.name)) {
      // 直接判断 TargetPlatform 类型，比对比 name 更安全
      return IconButton(
        icon: const Icon(CupertinoIcons.back, size: 24, color: Colors.black),
        onPressed: onTap ?? onBackPressed, // 绑定点击事件
        padding: EdgeInsets.zero, // 可选：移除 IconButton 默认内边距，贴合原生样式
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44), // 符合原生点击区域规范
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

  /// 业务逻辑处理：区分 Map/数组类型
  void _handleParsedData(Map<String, dynamic> dataMap) {
    // 安全读取 type 字段（避免空值）
    final String type = dataMap["type"] ?? "unknown";
    debugPrint("🔑 消息类型：$type");

    // 安全读取 data 字段（兼容 data 是 Map/数组/null）
    final dynamic data = dataMap["data"];
    if (data == null) {
      debugPrint("⚠️ data 字段为空");
      return;
    }

    // 按 type 分支处理
    switch (type) {
      case "user_info":
        if (data is Map<String, dynamic>) {
          // final String name = data["name"] ?? "未知";
          // final int age = data["age"] ?? 0;
          // final bool isVip = data["is_vip"] ?? false;
          // debugPrint("👤 用户信息：name=$name, age=$age, isVip=$isVip");
        } else if (data is List<dynamic>) {
          // 安全过滤：只保留符合类型的元素，避免崩溃
          deviceMaps =
              data
                  .where((item) {
                    // 校验元素是 Map 且键为 String 类型
                    return item is Map<String, dynamic>;
                  })
                  .cast<Map<String, dynamic>>()
                  .toList();
          debugPrint("📜 列表数据：$data");
        } else {
          debugPrint("❌ user_info 的 data 不是 Map：$data");
        }
        break;

      case "submit_form":
        if (data is Map<String, dynamic>) {
          final String formId = data["form_id"] ?? "";
          final String content = data["content"] ?? "";
          debugPrint("📝 表单提交：formId=$formId, content=$content");
        }
        break;

      case "list_data":
        if (data is List<dynamic>) {
          debugPrint("📜 列表数据：$data");
        }
        break;

      default:
        debugPrint("⚠️ 未匹配的消息类型：$type，data：$data");
        break;
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
