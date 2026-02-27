import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';

class ReactIframeDialog extends StatefulWidget {
  const ReactIframeDialog({super.key});

  @override
  State<ReactIframeDialog> createState() => _ReactIframeDialogState();
}

class _ReactIframeDialogState extends State<ReactIframeDialog> {
  final String _iframeId =
      'react-payment-iframe-${DateTime.now().microsecondsSinceEpoch}';
  bool _isIframeLoading = true;
  late Size _screenSize = Size.zero;
  html.IFrameElement? _iframeElement;
  // React B的地址（严格匹配）
  final String _reactOrigin = 'http://192.168.1.110:3000';
  // 机密支付参数（示例）
  final Map<String, dynamic> _secretParams = {
    "id": "xxxx",
    "client_secret": "xxxx",
    "currency": "USD",
  };

  @override
  void initState() {
    super.initState();
    // 步骤1：先注册消息监听（接收React B的就绪通知）
    _registerMessageListener();
    // 步骤2：注册iframe视图
    _registerIframeView();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newScreenSize = MediaQuery.of(context).size;
    if (_screenSize != newScreenSize) {
      setState(() => _screenSize = newScreenSize);
    }
  }

  // ========== 核心：监听React B的消息 ==========
  void _registerMessageListener() {
    html.window.addEventListener('message', (html.Event event) {
      final html.MessageEvent msgEvent = event as html.MessageEvent;

      // 仅处理React B的消息
      if (msgEvent.origin != _reactOrigin) {
        debugPrint("拒绝未知来源消息：${msgEvent.origin}");
        return;
      }

      if (msgEvent.data is Map) {
        final Map msgData = msgEvent.data;
        switch (msgData['type']) {
          // 收到React B的「就绪确认」：此时发送机密参数（最佳时机）
          case 'pageReady':
            debugPrint("React B已就绪，发送机密参数...");
            _sendSecretParamsToReact();
            break;
          // 接收React B的初始化结果
          case 'initSuccess':
            debugPrint("React支付组件初始化成功：${msgData['msg']}");
            break;
          case 'initError':
            debugPrint("React支付组件初始化失败：${msgData['msg']}");
            break;
          case 'paramsError':
            debugPrint("React参数校验失败：${msgData['msg']}");
            break;
        }
      }
    });
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
      _reactOrigin, // 必须指定React B的地址，禁止用*
    );
    debugPrint("机密参数已发送");
  }

  // ========== 注册iframe视图 ==========
  void _registerIframeView() {
    // ui.platformViewRegistry.unregisterViewFactory(_iframeId);

    ui.platformViewRegistry.registerViewFactory(_iframeId, (int viewId) {
      final iframe =
          html.IFrameElement()
            ..id = _iframeId
            // 仅传递非机密的URL参数
            ..src = "http://192.168.1.110:3000?userid=vvde&vid=123"
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.display = 'block'
            ..style.overflow = 'auto'
            // 必须的权限（允许跨域消息+脚本执行）
            ..setAttribute(
              'sandbox',
              'allow-same-origin allow-scripts allow-popups allow-popups-to-escape-sandbox allow-top-navigation-by-user-activation',
            )
            ..onLoad.listen((_) {
              if (mounted) {
                setState(() => _isIframeLoading = false);
              }
              debugPrint("iframe加载完成（DOM层面）");
              // 注意：这里不直接发参数，等React主动发pageReady再发
            })
            ..onError.listen((error) {
              if (mounted) {
                setState(() => _isIframeLoading = false);
              }
              debugPrint("iframe加载失败：$error");
            });

      _iframeElement = iframe;
      return iframe;
    });
  }

  // ========== 弹窗尺寸计算 + 构建 ==========
  Size _getDialogSize() {
    if (_screenSize.width < 768) {
      return Size(_screenSize.width * 0.9, _screenSize.height * 0.9);
    }
    return const Size(540, 800);
  }

  @override
  Widget build(BuildContext context) {
    final dialogSize = _getDialogSize();
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: dialogSize.width,
        height: dialogSize.height,
        child: Stack(
          children: [
            HtmlElementView(viewType: _iframeId, key: Key(_iframeId)),
            if (_isIframeLoading)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("正在加载支付页面..."),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // ui.platformViewRegistry.unregisterViewFactory(_iframeId);
    super.dispose();
  }
}
