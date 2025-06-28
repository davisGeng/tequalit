import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:untitled3/types/retrieve_payment_intent_reponse.dart';
import 'package:untitled3/util/airwallex_manager.dart';
import 'package:untitled3/util/log_service.dart';

class IntentListPage extends StatefulWidget {
  const IntentListPage({Key? key}) : super(key: key);

  @override
  State<IntentListPage> createState() => _EasyRefreshListPageState();
}

class _EasyRefreshListPageState extends State<IntentListPage> {
  // 列表数据
  List<String> _dataList = [];
  // 当前页码
  int _page = 1;
  // 每页数量
  final int _pageSize = 10;
  // 错误信息
  String? _error;
  // 是否加载中
  bool _isLoading = false;
  // 是否没有更多数据
  bool _noMore = false;

  @override
  void initState() {
    super.initState();
    // 初始加载
    _loadData(init: true);
  }

  // 加载数据方法
  Future<void> _loadData({bool init = false}) async {
    if (init) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    } else if (_isLoading || _noMore) {
      return;
    }

    try {
      const keys = ['from_created_at', 'merchant_order_id', 'page_num', 'page_size', 'to_created_at'];

      Map<String, dynamic> map = new Map();
      DateTime parsedTime = DateTime.parse('2025-06-24 06:57:10');
      String from_created_at = parsedTime.toIso8601String();
      DateTime parsedTime2 = DateTime.parse('2025-06-27 06:57:10');
      String to_created_at = parsedTime2.toIso8601String();

      String merchant_order_id = "CB202506261924111";

      map["from_created_at"] = from_created_at;
      map["merchant_order_id"] = merchant_order_id;
      map["page_num"] = "0";
      map["page_size"] = "10";
      map["to_created_at"] = to_created_at;
      await AirwallexManager.instance.getPaymentIntents(param: map);
      // 模拟网络请求延迟
      await Future.delayed(const Duration(seconds: 1));

      // 模拟获取数据
      final newData = List.generate(_pageSize, (index) => "第 ${(_page - 1) * _pageSize + index + 1} 条数据");

      // 模拟数据加载完的情况
      if (_page >= 3) {
        _noMore = true;
      }

      setState(() {
        if (init || _page == 1) {
          _dataList = newData;
        } else {
          _dataList.addAll(newData);
        }
        _page++;
        _error = null;
      });
    } catch (e) {
      // 错误处理
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    _page = 1;
    _noMore = false;
    await _loadData();
  }

  // 上拉加载
  Future<void> _onLoad() async {
    RetrievePaymentIntentReponse reponse =
        await AirwallexManager.instance.retrieveAPaymentIntent("int_hkdmlzvbnh8pl5ktuo4");
    Log.d("dfdf");
    // await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyRefresh 列表示例'),
      ),
      body: _buildBody(),
    );
  }

  // 构建主体内容
  Widget _buildBody() {
    // 加载中状态
    if (_isLoading && _dataList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // 错误状态
    if (_error != null && _dataList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(height: 8),
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _loadData(init: true),
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    // 空数据状态
    if (_dataList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, color: Colors.grey),
            const SizedBox(height: 8),
            const Text('暂无数据'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _loadData(init: true),
              child: const Text('刷新'),
            ),
          ],
        ),
      );
    }

    // 正常数据状态
    return EasyRefresh(
      // 控制器，可用于外部控制刷新和加载
      // controller: _controller,
      // 刷新回调
      onRefresh: _onRefresh,
      // 加载回调
      onLoad: _onLoad,
      // 刷新指示器
      header: const MaterialHeader(
        backgroundColor: Colors.white,
      ),
      // 加载指示器
      footer: _noMore
          ? const ClassicFooter(showText: true, noMoreText: "no no more")
          : const ClassicFooter(
              backgroundColor: Colors.white,
            ),
      child: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_dataList[index]),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          );
        },
      ),
    );
  }
}
