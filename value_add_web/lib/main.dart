import './common/widget/basic_toast.dart';
import './value_add/value_add_routes.dart';
import 'dart:convert';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:value_add_web/common/utils/js_utils.dart';
import 'package:value_add_web/services/app_service.dart';
import 'package:value_add_web/services/storage_service.dart';

import 'api/value_add_api.dart';
import 'assets/app_theme.dart';
import 'common/utils/app_translations.dart';
import 'common/utils/language_manager.dart';
import 'dart:html' as html; // 核心：用于解析URL的hash和参数

void main() async {
  await AppTask.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SightSys',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, primary: AppTheme.current.colors.main),
        useMaterial3: true,
      ),
      getPages: [
        // 增值服务
        ValueAddRoutes.route(),
      ],
      initialRoute: ValueAddPaths.main,
      translations: AppTranslations(),
      locale: LanguageManager.instance.newLocale ?? LanguageManager.instance.getDefaultLocale(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LanguageManager.instance.getSupportedLocales(),
      builder: EasyLoading.init(),
    );
  }
}

final class AppTask {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Get.putAsync(() => AppService().init());

    await Get.putAsync(() => StorageService.instance.init());
    Get.put(WebParamsStore());
    await JsUtils.instance.init();

    ValueAddApi.instance.init("zh");

    // html.window.addEventListener('message', (html.Event event) {
    //   JsUtils.instance.sendMessageToNativeIOS(type: "ready");

    //   // 转换为 MessageEvent 类型，获取数据
    //   final html.MessageEvent msgEvent = event as html.MessageEvent;
    //   // BasicToast.info("✅ 收到WebView就绪通知");

    //   // 解析 Swift 发送的 data
    //   // if (msgEvent.data == 'onWebViewReady') {
    //   //   debugPrint("✅ 收到WebView就绪通知");
    //   //   BasicToast.info("✅ 收到WebView就绪通知");

    //   //   if (isIos) {
    //   // sendMessageToNativeIOS(type: "ready");
    //   //   } else {
    //   //     sendMessageToNative(type: "ready");
    //   //   }
    //   // }

    //   // 如果 Swift 端发送的是 JSON 对象（更推荐），可以这样解析：
    //   // if (msgEvent.data is Map<String, dynamic> &&
    //   //     msgEvent.data['type'] == 'onWebViewReady') {
    //   //   // 处理逻辑
    //   // }
    // });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 存储原生A发来的消息
  String _nativeMessage = "等待接收原生A的消息...";

  @override
  void initState() {
    super.initState();
  }

  /// 核心1：注册JS全局方法
  void _registerMessageListener() {
    // 向浏览器window对象挂载JS方法：receiveNativeMessage
    js.context["receiveNativeMessage"] = (String jsonStr) {
      // 解析原生A传来的JSON字符串
      final Map<String, dynamic> data = json.decode(jsonStr);
      debugPrint("✅ Web-B收到原生A的消息：$data");
      // 更新页面UI
      setState(() {
        _nativeMessage = "A的消息：${jsonStr}";
      });
    };
    js.context["receiveNativeDeviceList"] = (String jsonStr) {
      // 解析原生A传来的JSON字符串
      List<Map<String, dynamic>> _deviceList = List<Map<String, dynamic>>.from(json.decode(jsonStr));
      debugPrint("✅ Web-B收到原生A的消息：${_deviceList.length}");
      // 更新页面UI
      setState(() {
        _nativeMessage = "A的消息：${jsonStr}";
      });
    };
    // js.context['receiveParamsFromReact'] = (String status, String timestamp) {
    //   // 可把参数存入GetX全局状态，让子页面获取
    //   Get.find<WebParamsStore>().updateStatus(status, timestamp);
    // };
    // _sendMessageToNative(type: "ready");
  }

  /// 核心3：Web-B 一键返回原生A（URL Scheme协议跳转，最优方案）
  void _backToNativeApp() {
    debugPrint("🚀 Web-B触发返回原生A");
    // 调用浏览器JS，跳转自定义Scheme协议（A端会拦截该请求）
    js.context.callMethod("open", ["flutterapp://backToNative"]);
    // 进阶：带参数返回 → flutterapp://backToNative?params={"id":123,"name":"test"}
    // js.context.callMethod("open", ["flutterapp://backToNative?params=${Uri.encodeComponent(json.encode({"id":123}))}"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Web-B 页面")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 显示原生A发来的消息
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _nativeMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Web→Native 发送消息按钮
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
                child: const Text("Web-B → 发送消息到原生A"),
              ),
              const SizedBox(height: 20),
              // Web→返回原生 按钮（核心）
              ElevatedButton(
                onPressed: _backToNativeApp,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("🔙 Web-B → 返回原生APP-A"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(ValueAddPaths.second); // 跳转到/#/second

                  // Get.to(() => WebPageSecond());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("跳转到page B"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
