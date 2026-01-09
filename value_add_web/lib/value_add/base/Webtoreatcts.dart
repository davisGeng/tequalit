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

  @override
  void initState() {
    super.initState();
    _paramsStore = Get.find<WebParamsStore>();
    _listenIframeMessage();

    // 👉 核心修复：直接注册iframe，而非先div再替换
    ui.platformViewRegistry.registerViewFactory(_iframeId, (int viewId) {
      // 直接创建iframe并返回，一步到位
      final iframe =
          html.IFrameElement()
            ..id = _iframeId
            ..src = "http://192.168.1.107:3000?userid=vvde&vid=123"
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
      return iframe;
    });
  }

  @override
  void dispose() {
    html.window.removeEventListener('message', _handleIframeMessage);
    super.dispose();
  }

  // 监听B的消息（不变）
  void _listenIframeMessage() {
    html.window.addEventListener('message', _handleIframeMessage);
  }

  void _handleIframeMessage(html.Event event) {
    final html.MessageEvent msgEvent = event as html.MessageEvent;
    if (msgEvent.origin != 'http://192.168.1.107:3000') return;

    final data = msgEvent.data;
    if (data is Map && data['type'] == 'closeDialog') {
      _closeDialog();
      return;
    }
    if (data is Map && data.containsKey('paymentPageStatus')) {
      _paramsStore.updateStatus(
        data['paymentPageStatus'],
        data['timestamp']?.toString() ?? '',
      );
    }
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
        title: const Text("三级页面third"),
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
}
