import '../../common/utils/js_utils.dart';
import 'dart:ui_web' as ui; // 正确的web端ui导入
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class Webtoreatcts extends StatefulWidget {
  const Webtoreatcts({super.key});

  @override
  State<Webtoreatcts> createState() => _WebtoreatctsState();
}

class _WebtoreatctsState extends State<Webtoreatcts> {
  late final WebParamsStore _paramsStore;
  final String _iframeId = 'react-b-iframe';
  bool _isDialogShow = false;
  bool _isIframeLoading = true;
  late Size _screenSize = Size.zero;
  String paymentBaseUrl = 
  // "http://localhost:3001";
  "http://0.0.0.0:3001";
  html.IFrameElement? _iframeElement;
  final Map<String, dynamic> _secretParams = {
    "id": "int_hkdmr72qchg6ok8nm42",
    "client_secret":
        "eyJraWQiOiJjNDRjODVkMDliMDc0NmNlYTIwZmI4NjZlYzI4YWY3ZSIsImFsZyI6IkhTMjU2In0.eyJ0eXBlIjoiY2xpZW50LXNlY3JldCIsImFjY291bnRfaWQiOiI0ZjhhOTAzZS1iZjA4LTRlMjQtOTlhNi00YmVhOTlhOTUxYTIiLCJpbnRlbnRfaWQiOiJpbnRfaGtkbXI3MnFjaGc2b2s4bm00MiIsImJ1c2luZXNzX25hbWUiOiJGdW5rLCBHYXlsb3JkIGFuZCBTd2lmdCIsInBhZGMiOiJISyIsImV4cCI6MTc3MjE4NDI3MywiaWF0IjoxNzcyMTgwNjczfQ.jX7nHI5vQXp3u_tC47eFLkzrxQDVKuKNAuMqVThUVqY",
    "currency": "USD",
  };
  @override
  void initState() {
    super.initState();
    _paramsStore = Get.find<WebParamsStore>();
    _registerMessageListener();

    _registerIframeView2();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 获取屏幕尺寸（此时context已挂载到Widget树）
    final newScreenSize = MediaQuery.of(context).size;
    // 只有尺寸变化时才更新（避免不必要的setState）
    if (_screenSize != newScreenSize) {
      setState(() {
        _screenSize = newScreenSize;
      });
    }
  }

  void _registerIframeView2() {
    String finalurl = "$paymentBaseUrl?intent_id=${_secretParams['id']}&client_secret=${_secretParams['client_secret']}&currency=USD";
    ui.platformViewRegistry.registerViewFactory(_iframeId, (int viewId) {
      // 直接创建iframe并返回，一步到位
      final iframe =
          html.IFrameElement()
            ..id = _iframeId
            ..src =finalurl
                
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%'
            // 跨域兜底配置（解决iframe加载限制）
            ..allowFullscreen = true
            ..allow = 'cross-origin-isolated; fullscreen'
            // 监听加载状态（成功/失败都更新）
            ..onLoad.listen((_) {
              setState(() => _isIframeLoading = false);
              debugPrint("iframe加载完成！");
            })
            ..onError.listen((error) {
              setState(() => _isIframeLoading = false);
              debugPrint("iframe加载失败：$error");
            });
      _iframeElement = iframe;
      return iframe;
    });
  }

  void _registerMessageListener() {
    html.window.addEventListener('message', _handleReactTSMessage);
  }

  void _handleReactTSMessage(html.Event event) {
    final html.MessageEvent msgEvent = event as html.MessageEvent;
    // if (msgEvent.origin != 'http://192.168.1.107:3000') return;

    final data = msgEvent.data;
    debugPrint("接收到payment 返回数据:$data");
    if (data is Map) {
      String type = data["type"];
      switch (type) {
        // 收到React B的「就绪确认」：此时发送机密参数（最佳时机）
        case 'listenerReady':
          debugPrint("React B已就绪，发送机密参数...");
          _sendSecretParamsToReact();
          break;
        // 接收React B的初始化结果
        case 'initSuccess':
          debugPrint("React支付组件初始化成功：${data['msg']}");
          break;
        case 'initError':
          debugPrint("React支付组件初始化失败：${data['msg']}");
          break;
        case 'paramsError':
          debugPrint("React参数校验失败：${data['msg']}");
          break;
        case 'closeDialog':
          _closeDialog();
          break;
      }
      // if (data['type'] == 'closeDialog') {
      //   return;
      // } else if (data.containsKey('paymentPageStatus')) {
      //   _paramsStore.updateStatus(
      //     data['paymentPageStatus'],
      //     data['timestamp']?.toString() ?? '',
      //   );
      // }
    }
  }

  // ========== 核心：发送机密参数给React B ==========
  void _sendSecretParamsToReact() {
    if (_iframeElement == null) {
      debugPrint("iframe未加载，无法发送参数");
      return;
    }

    // 发送机密参数（仅发送给React B，targetOrigin严格指定）
    _iframeElement!.contentWindow?.postMessage(
      {
        "type": "secretPaymentParams", // 消息类型标识
        "data": _secretParams, // 机密参数
      },
      paymentBaseUrl, // 必须指定React B的地址，禁止用*
    );
    debugPrint("机密参数已发送");
  }

  void _openDialog() {
    setState(() => _isDialogShow = true);
  }

  void _closeDialog() {
    setState(() => _isDialogShow = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("三级页面third web1"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // 原有内容
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
                  child: const Text("打开React-TS(B)弹窗"),
                ),
              ],
            ),
          ),

          // 弹窗层
          Visibility(
            visible: _isDialogShow,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
              child: GestureDetector(
                onTap: _closeDialog,
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // 阻止透传
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        children: [
                          // 标题栏
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
                                  icon: const Icon(Icons.close),
                                  onPressed: _closeDialog,
                                ),
                              ],
                            ),
                          ),

                          // 👉 关键：给HtmlElementView设置强制尺寸约束
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              // HtmlElementView直接使用注册的iframe
                              child: HtmlElementView(
                                viewType: _iframeId,
                                // 强制设置尺寸（避免视图不渲染）
                                // layoutDirection: TextDirection.ltr,
                              ),
                            ),
                          ),

                          // 加载状态提示（移到底部，不遮挡iframe）
                          if (_isIframeLoading)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(strokeWidth: 16),
                                  SizedBox(width: 8),
                                  Text(
                                    "加载中...",
                                    style: TextStyle(fontSize: 14),
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

  @override
  void dispose() {
    html.window.removeEventListener('message', _handleReactTSMessage);
    super.dispose();
  }
}
