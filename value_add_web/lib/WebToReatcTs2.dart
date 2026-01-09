import './common/utils/js_utils.dart';
import 'dart:ui_web' as ui;

import './main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:js/js.dart' as js; // 引入js包
import 'dart:js' as js;

import 'package:get/get_core/src/get_main.dart';
import 'dart:html' as html;

import 'package:url_launcher/url_launcher.dart';
import 'package:value_add_web/value_add/value_add_routes.dart'; // 监听message事件需要用到html包
// import 'package:flutter/services.dart' show ui; // 引入ui模块

// class MyApp2 extends StatelessWidget {
//   const MyApp2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Web-B333',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: const Webtoreatcts(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class Webtoreatcts2 extends StatefulWidget {
  const Webtoreatcts2({super.key});
  @override
  State<StatefulWidget> createState() {
    return _webtoreatcts();
  }
}

class _webtoreatcts extends State<Webtoreatcts2> {
  String _messageFromPayment = "等待接收payment返回信息";
  final String _reactOrigin = "http://localhost:3000"; // B端源
  late final WebParamsStore _paramsStore;

  final String _iframeId = 'react-b-iframe';
  // 控制弹窗显示/隐藏
  bool _isDialogShow = false;
  // 可选：控制iframe加载状态
  bool _isIframeLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paramsStore = Get.find<WebParamsStore>();

    _listenIframeMessage();
    // 🔴 必须先注册视图工厂，否则HtmlElementView会报错
    // 正确的注册方式：使用ui.platformViewRegistry
    ui.platformViewRegistry.registerViewFactory(
      _iframeId, // 对应HtmlElementView的viewType
      (int viewId) => html.DivElement()..id = _iframeId, // 创建div容器
    );
  }

  @override
  void dispose() {
    // 组件销毁时移除监听，避免内存泄漏
    html.window.removeEventListener('message', _handleMessage);
    super.dispose();
  }

  // 👉 方式1：打开新窗口跳转到React-TS(B)（核心修改）
  void jumpToReactNewWindow() {
    final String targetUrl = "http://192.168.1.107:3000?userid=vvde&vid=123";
    // 打开新窗口，保留opener引用（关键：让B能找到A的窗口）
    js.context.callMethod('eval', ["window.open('$targetUrl', '_blank')"]);
  }

  // 拆分监听方法，方便移除
  void _listenIframeMessage() {
    html.window.addEventListener('message', _handleMessage);
  }

  // 处理消息的核心方法（添加origin校验）
  void _handleMessage(html.Event event) {
    final html.MessageEvent msgEvent = event as html.MessageEvent;

    // 🔴 安全校验：只接收来自B的消息（必须加，避免恶意消息）
    final String origin = msgEvent.origin;
    if (origin != 'http://192.168.1.107:3000') {
      debugPrint("非法来源：$origin，忽略消息");
      return;
    }

    // 解析B传递的数据
    setState(() {
      _messageFromPayment = "收到payment消息：${msgEvent.data}";
    });
    debugPrint("Flutter(A) 接收数据：${msgEvent.data}");
  }

  // ✅ 打开弹窗
  void _openDialog() {
    setState(() => _isDialogShow = true);
    // 重置加载状态
    setState(() => _isIframeLoading = true);
  }

  // ✅ 关闭弹窗
  void _closeDialog() {
    setState(() => _isDialogShow = false);
  }

  // 👉 方式1：当前窗口跳转到React-TS(B)
  void jumpToReactCurrentWindow() {
    final String targetUrl = "http://192.168.1.107:3000?userid=vvde&vid=123";

    // 调用浏览器window.location.href实现跳转
    js.context.callMethod('eval', ["window.location.href = '$targetUrl'"]);
  }

  void jumpToReactCurrentWindowNN() {
    final String targetUrl = "http://192.168.1.107:3000?userid=vvde&vid=123";
    // 使用assign（添加历史记录），而非replace（替换历史记录）
    js.context.callMethod('eval', ["window.location.assign('$targetUrl')"]);
  }

  void jumpToReactCurrentWindow3() {
    const String targetFlutterUrl = "http://localhost:8080/#second";
    // 拼接参数，传递给React(B)
    final String reactUrl =
        "http://localhost:3000?from=${Uri.encodeComponent(targetFlutterUrl)}";
    launchUrl(Uri(path: reactUrl), mode: LaunchMode.inAppWebView);
    // launchUrl(reactUrl, mode: LaunchMode.inAppWebView);
  }

  // 👉 方式2：新标签页打开React-TS(B)
  void jumpToReactNewTab() {
    final String targetUrl = "http://localhost:3000";
    // 调用浏览器window.open实现新标签页跳转
    js.context.callMethod('open', [targetUrl, '_blank']);
  }

  void jumpToReactInWebViewResto() {
    // 获取当前third页面的路由路径
    final String currentRoute = Get.routing.current; // /value-add/third
    final String encodedRoute = Uri.encodeComponent(currentRoute);

    // 拼接URL跳转到B
    final String targetUrl =
        "http://192.168.1.107:3000?userid=vvde&vid=123&flutterRoute=$encodedRoute";
    js.context.callMethod('eval', ["window.location.assign('$targetUrl')"]);
  }

  // 👉 4. 构建嵌套iframe的弹窗
  // Widget _buildReactBDialog() {
  //   return Dialog(
  //     // 弹窗宽度占屏幕80%，高度占90%（可自定义）
  //     insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
  //     child: SizedBox(
  //       width: MediaQuery.of(context).size.width * 0.8,
  //       height: MediaQuery.of(context).size.height * 0.9,
  //       child: Column(
  //         children: [
  //           // 弹窗标题栏（带关闭按钮）
  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //             color: Colors.grey[100],
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   "React-TS项目B",
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                 ),
  //                 IconButton(
  //                   icon: const Icon(Icons.close),
  //                   onPressed: _closeDialog,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           // 核心：嵌套iframe加载B的页面
  //           Expanded(
  //             child: HtmlElementView(
  //               // 创建iframe并返回其ID
  //               viewType: _iframeId,
  //               onPlatformViewCreated: (int id) {
  //                 // 构建iframe元素
  //                 final iframe =
  //                     html.IFrameElement()
  //                       ..id = _iframeId
  //                       ..src =
  //                           "http://192.168.1.107:3000?userid=vvde&vid=123" // B的地址
  //                       ..style.border =
  //                           'none' // 去掉iframe边框
  //                       ..width = '100%'
  //                       ..height = '100%';
  //                 // 允许iframe跨域通信（关键）
  //                 iframe.setAttribute('allow', 'cross-origin-isolated');
  //                 // 将iframe添加到页面中
  //                 html.querySelector('#$_iframeId')?.replaceWith(iframe);
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Flutter Web(A) - 端口8080"),
  //       leading: IconButton(
  //         onPressed: () {
  //           Get.back();
  //         },
  //         icon: Icon(Icons.arrow_back, size: 24, color: Colors.black),
  //       ),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           ElevatedButton(
  //             onPressed: jumpToReactInWebViewResto,
  //             child: const Text("当前窗口跳转至React-TS(B) resto"),
  //           ),
  //           ElevatedButton(
  //             onPressed: jumpToReactCurrentWindow,
  //             child: const Text("当前窗口跳转至React-TS(B)"),
  //           ),
  //           const SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: jumpToReactNewTab,
  //             child: const Text("新标签页打开React-TS(B)"),
  //           ),
  //           ElevatedButton(
  //             onPressed: jumpToReactNewWindow,
  //             child: const Text("新标签页打开React-TS(B) new2"),
  //           ),
  //           Card(
  //             child: Padding(
  //               padding: const EdgeInsets.all(16),
  //               child: Text(
  //                 "收到Ts的数据：${_paramsStore.paymentStatus.value}，时间：${_paramsStore.timestamp.value}",

  //                 // _messageFromPayment,
  //                 textAlign: TextAlign.center,
  //                 style: const TextStyle(fontSize: 16, color: Colors.green),
  //               ),
  //             ),
  //           ),
  //           // ElevatedButton(
  //           //     onPressed: () async{
  //           //       // Get.to(
  //           //       //       () => LocalHtmlWebViewPage(),
  //           //       // );
  //           //       openWebViewPageWithLocalHtml(context, "pay", "local_html_demo.html");
  //           //
  //           //     },
  //           //     child: const Text("load html"),
  //           //     style: ElevatedButton.styleFrom(
  //           //       minimumSize: const Size(300, 50),
  //           //       backgroundColor: Colors.red,
  //           //       foregroundColor: Colors.white,
  //           //     )
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("三级页面third"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // 回到second页面，保留页面栈
        ),
      ),
      // ✅ 核心：用Stack包裹原有内容 + 弹窗层
      body: Stack(
        children: [
          // 👇 第一层：third页面原有内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    "收到B的数据：${_paramsStore.paymentStatus.value}\n时间：${_paramsStore.timestamp.value}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _openDialog,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text("打开React-TS(B)弹窗"),
                ),
              ],
            ),
          ),

          // 👇 第二层：弹窗层（Visibility控制显隐）
          Visibility(
            visible: _isDialogShow,
            child: Container(
              // 遮罩：全屏半透明黑色
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
              // 点击遮罩关闭弹窗
              child: GestureDetector(
                onTap: _closeDialog,
                // 弹窗主体（点击时不触发遮罩的关闭事件）
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // 阻止事件透传
                    child: Container(
                      // 弹窗尺寸：宽80%，高80%
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12), // 圆角
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        children: [
                          // 弹窗标题栏（带关闭按钮）
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "React-TS项目B",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.orange,
                                  ),
                                  onPressed: _closeDialog,
                                ),
                              ],
                            ),
                          ),

                          // 核心：iframe加载项目B
                          Expanded(
                            child: Stack(
                              children: [
                                // iframe组件
                                HtmlElementView(
                                  viewType: _iframeId,
                                  onPlatformViewCreated: (int id) {
                                    final iframe =
                                        html.IFrameElement()
                                          ..id = _iframeId
                                          ..src =
                                              "http://192.168.1.107:3000?userid=vvde&vid=123"
                                          ..style.border = 'none'
                                          ..width = '100%'
                                          ..height = '100%';
                                    // 监听iframe加载完成，隐藏加载中提示
                                    iframe.onLoad.listen((_) {
                                      setState(() => _isIframeLoading = false);
                                    });
                                    // 添加到DOM
                                    html
                                        .querySelector('#$_iframeId')
                                        ?.replaceWith(iframe);
                                  },
                                ),

                                // 加载中提示
                                if (_isIframeLoading)
                                  const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 10),
                                        Text("加载中..."),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
