import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:js/js.dart' as js; // 引入js包
import 'dart:js' as js;

import 'package:get/get_core/src/get_main.dart';
import 'dart:html' as html;

import 'package:url_launcher/url_launcher.dart'; // 监听message事件需要用到html包

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web-B333',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Webtoreatcts(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Webtoreatcts extends StatefulWidget {
  const Webtoreatcts({super.key});
  @override
  State<StatefulWidget> createState() {
    return _webtoreatcts();
  }



}
class _webtoreatcts extends State<Webtoreatcts> {
  String _messageFromPayment = "等待接收payment返回信息";
  final String _reactOrigin = "http://localhost:3000"; // B端源

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenReactMessage();
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
      appBar: AppBar(title: const Text("Flutter Web(A) - 端口8080")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: jumpToReactCurrentWindow,
              child: const Text("当前窗口跳转至React-TS(B)"),
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
            // ElevatedButton(
            //     onPressed: () async{
            //       // Get.to(
            //       //       () => LocalHtmlWebViewPage(),
            //       // );
            //       openWebViewPageWithLocalHtml(context, "pay", "local_html_demo.html");
            //
            //     },
            //     child: const Text("load html"),
            //     style: ElevatedButton.styleFrom(
            //       minimumSize: const Size(300, 50),
            //       backgroundColor: Colors.red,
            //       foregroundColor: Colors.white,
            //     )
            // ),
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