import 'dart:convert';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:value_add_web/common/utils/js_utils.dart';
import 'package:value_add_web/routes/routes.dart';
import 'package:value_add_web/services/log_service.dart';
import 'package:value_add_web/services/storage_service.dart';

import 'WebPageSecond.dart';
import 'WebToReatcTs.dart';
import 'assets/app_theme.dart';
import 'common/utils/app_translations.dart';
import 'common/utils/language_manager.dart';

void main() async{
  await AppTask.init();
  JsUtils.instance.init();
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
          useMaterial3: true),
      getPages: [
        ...Routes.routes,
      ],
      initialRoute: Routes.initial,
      translations: AppTranslations(),
      locale:LanguageManager.instance.newLocale ?? LanguageManager.instance.getDefaultLocale(),
      localizationsDelegates:  [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LanguageManager.instance.getSupportedLocales(),
      builder: EasyLoading.init(),
    );
    // return GetMaterialApp(
    //   title: 'Flutter Web-B',
    //   theme: ThemeData(primarySwatch: Colors.green),
    //   // home: const HomePage(),
    //   debugShowCheckedModeBanner: false,
    //   initialRoute: "/", // 首页路由
    //   // ✅ 原生路由注册，key对应#后的路径
    //   routes: {
    //     "/": (context) => const HomePage(), // 首页 → /#/
    //     "/second": (context) => const WebPageSecond(), // 第二个页面 → /#/second
    //     "/third": (context) => const Webtoreatcts(), // 第三个页面 → /#/third
    //
    //   },
    // );
  }
}
final class AppTask {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Get.putAsync(() => LogService().init());
    await Get.putAsync(() => StorageService.instance.init());
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
    // 初始化：注册【接收原生A消息】的JS方法（供A调用）
    _registerNativeMessageListener();
  }

  /// 核心1：注册JS全局方法，供原生A调用（接收A的消息）
  void _registerNativeMessageListener() {
    // 向浏览器window对象挂载JS方法：receiveNativeMessage
    js.context["receiveNativeMessage"] = (String jsonStr) {
      // 解析原生A传来的JSON字符串
      final Map<String, dynamic> data = json.decode(jsonStr);
      debugPrint("✅ Web-B收到原生A的消息：$data");
      // 更新页面UI
      setState(() {
        _nativeMessage = "A的消息：${data['content']} | 时间：${data['time']}";
      });
    };
  }

  /// 核心2：Web-B → 发送消息到原生A（调用原生注册的通道）
  // void _sendMessageToNative() {
  //   // 构造消息体（JSON格式，与A端约定一致）
  //   final Map<String, dynamic> sendData = {
  //     "type": "toast",
  //     "content": "我是Web-B发来的消息，请求原生显示提示",
  //     "from": "flutter_web_b",
  //   };
  //   // 通过原生注册的通道，发送JSON字符串
  //   js.context.callMethod(
  //     "flutter_app_web_channel.postMessage", // 通道名必须与A端一致
  //     [json.encode(sendData)],
  //   );
  //   debugPrint("✅ Web-B已向原生A发送消息：$sendData");
  // }
  /// 【已修复】Web-B → 发送消息到原生A（正确调用原生注册的通道）
  void _sendMessageToNative() {
    // 1. 构造消息体（格式不变，与A端约定一致）
    final Map<String, dynamic> sendData = {
      "type": "toast",
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
                onPressed: _sendMessageToNative,
                child: const Text("Web-B → 发送消息到原生A"),
                style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
              ),
              const SizedBox(height: 20),
              // Web→返回原生 按钮（核心）
              ElevatedButton(
                onPressed: _backToNativeApp,
                child: const Text("🔙 Web-B → 返回原生APP-A"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  Get.toNamed("/second"); // 跳转到/#/second

                  // Get.to(
                  //       () => Webtoreatcts(),
                  // );

                },
                child: const Text("跳转到page B"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}