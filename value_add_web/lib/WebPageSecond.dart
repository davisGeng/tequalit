import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:js/js.dart' as js; // 引入js包
import 'dart:js' as js;

import 'package:get/get_core/src/get_main.dart';
import 'dart:html' as html;

import 'package:url_launcher/url_launcher.dart';
import 'package:value_add_web/api/user_api.dart';

import 'assets/assets.gen.dart';


class WebPageSecond extends StatefulWidget {
  const WebPageSecond({super.key});
  @override
  State<StatefulWidget> createState() {
    return _webtoreatcts();
  }



}
class _webtoreatcts extends State<WebPageSecond> {
  String _messageFromPayment = "等待接收payment返回信息";
  final String _reactOrigin = "http://localhost:3000"; // B端源

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _listenReactMessage();
    _parseUrlParams();
  }
  // 核心：解析URL中的查询参数
  void _parseUrlParams() {
    // 1. 获取当前浏览器的完整URL
    final String currentUrl = html.window.location.href;
    // 2. 将URL解析为Uri对象（自动处理参数、编码）
    final Uri uri = Uri.parse(currentUrl);

    // 3. 通过queryParameters获取指定参数（key对应?后的参数名）
    setState(() {
      String result = uri.queryParameters['result'] ?? ""; // 拿到"success"
      String? data = uri.queryParameters['data'] ?? "";     // 若有参数则拿到对应值，无则为null
      _messageFromPayment = "收到payment消息：${result},data:$data";

    });
  }
  // ✅ 1. 监听React(B)发送的消息（核心）
  void _listenReactMessage() {
    html.window.addEventListener('message', (event) {
      final html.MessageEvent msgEvent = event as html.MessageEvent;
      // ⚠️ 安全校验：必须校验发送方origin，只处理合法的B端消息
      if (msgEvent.origin != _reactOrigin) return;

      // 解析B端传递的数据
      setState(() {
        _messageFromPayment = "收到payment消息：${msgEvent.data}";
      });
      debugPrint("Flutter(B) 接收数据：${msgEvent.data}");
    });
  }
  // 👉 方式1：当前窗口跳转到React-TS(B)
  void jumpToReactCurrentWindow() {
    final String targetUrl = "http://192.168.1.107:3000/#second";
    // 调用浏览器window.location.href实现跳转
    js.context.callMethod('eval', ["window.location.href = '$targetUrl'"]);
  }
  void jumpToReactCurrentWindow3() {
    const String targetFlutterUrl = "http://localhost:8080/#second";
    // 拼接参数，传递给React(B)
    final String reactUrl = "http://localhost:3000?from=${Uri.encodeComponent(targetFlutterUrl)}";
    launchUrl(Uri(path: reactUrl),mode: LaunchMode.inAppWebView);
    // launchUrl(reactUrl, mode: LaunchMode.inAppWebView);
  }

  // 👉 方式2：新标签页打开React-TS(B)
  void jumpToReactNewTab() {
    final String targetUrl = "http://localhost:3000";
    // 调用浏览器window.open实现新标签页跳转
    js.context.callMethod('open', [targetUrl, '_blank']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("pageB")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Get.toNamed("/third");
              },
              child: const Text("当前窗口跳转C"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: jumpToReactNewTab,
              child: const Text("新标签页打开React-TS(B)"),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _messageFromPayment,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async{
                final tokenMap = await  UserApi.login(username: "+8617665326531", password: "q123456",countryCode: "CN");
                debugPrint("登录成功 token：${tokenMap}");

                },
                child: const Text("login"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                )
            ),
            ElevatedButton(
                onPressed: () async{
                  final info = await  UserApi.getUserInfo();
                  debugPrint("info ：${info}");

                },
                child:
                const Text("get userInfo"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                )
            ),
            Assets.images.iconServiceData4gBanner.image(width: double.infinity,height: 200,fit: BoxFit.fill)

          ],
        ),
      ),
    );
  }

  Future<void> openWebViewPageWithLocalHtml(BuildContext context, String title, String fileName) async {

    // final WebViewController controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..loadRequest(Uri.parse('local_html_demo.html')); // 本地HTML（放在web目录下）
    //
    // // 3. 在页面中渲染
    // Get.to(
    //       () => Scaffold(
    //     body: WebViewWidget(controller: controller),
    //   ),
    // );


  }
}