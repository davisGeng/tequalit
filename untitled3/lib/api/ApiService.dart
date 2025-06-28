import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // 单例模式
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();
  String apiKey = 'bc735183b7eeb714a1b679507d7b0016c74563077dc40e6a71d4aa4125925fabe86fb77b1eb8f1502568f633652cc77a';
  String clientId = '_kxXlEflRVCG61JUqZpnDw';
  late Dio _dio;
  String myToken = "";
  // 初始化 Dio 配置
  Future init({
    required String baseUrl,
    Map<String, dynamic>? headers,
    int connectTimeout = 15000, // 连接超时时间（毫秒）
    int receiveTimeout = 15000, // 接收超时时间（毫秒）
  }) async {
    // if (_dio.options.baseUrl == "") {
    // 基础配置
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));
    // }

    // 添加拦截器
    _addInterceptors();
  }

  // 添加拦截器
  void _addInterceptors() {
    // 请求拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 添加公共参数，如 token
        options.headers['Authorization'] = 'Bearer $myToken';
        return handler.next(options);
      },
    ));

    // 响应拦截器
    _dio.interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      // 统一处理响应
      return handler.next(response);
    }, onError: (DioException e, handler) async {
      final statusCode = e.response?.statusCode ?? 0;
      if (statusCode == 401) {
        try {
          // 刷新 Token
          await airwallexApiLogin();
          final options = e.requestOptions;
          final response;
          if (options.method == "GET" || options.method == "get") {
            response = await get(options.path, queryParameters: options.data);
          } else {
            response = await post(options.path, data: options.data);
          }

          return handler.resolve(response);
        } catch (err) {
          return handler.next(await _handleError(e));
        }
      }
    }));

    // 添加日志拦截器（调试环境）
    if (const bool.fromEnvironment('dart.vm.product') == false) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
    }
  }

  // 错误处理
  Future<DioException> _handleError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DioException(
          requestOptions: error.requestOptions,
          error: '连接超时，请检查网络',
        );
      case DioExceptionType.sendTimeout:
        return DioException(
          requestOptions: error.requestOptions,
          error: '发送超时，请检查网络',
        );
      case DioExceptionType.receiveTimeout:
        return DioException(
          requestOptions: error.requestOptions,
          error: '接收超时，请检查网络',
        );
      case DioExceptionType.badResponse:
        // HTTP 状态码非 200-299
        final statusCode = error.response?.statusCode ?? 0;
        final message = _getErrorMessageByStatusCode(statusCode);
        // if (statusCode == 401) {
        //   Map<String, dynamic> result = await airwallexApiLogin(apiKey, clientId);
        //   if (result.isNotEmpty) {}
        // }
        return DioException(
          requestOptions: error.requestOptions,
          error: message,
          response: error.response,
        );
      case DioExceptionType.cancel:
        return DioException(
          requestOptions: error.requestOptions,
          error: '请求已取消',
        );
      case DioExceptionType.unknown:
        return DioException(
          requestOptions: error.requestOptions,
          error: '未知错误，请稍后重试',
        );
      default:
        return error;
    }
  }

  // 根据状态码获取错误信息
  String _getErrorMessageByStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return '错误请求，请检查参数';
      case 401:
        return '未授权，请重新登录';
      case 403:
        return '禁止访问，权限不足';
      case 404:
        return '请求资源不存在';
      case 500:
        return '服务器内部错误';
      case 502:
        return '网关错误';
      case 503:
        return '服务不可用';
      case 504:
        return '网关超时';
      default:
        return '未知错误，状态码: $statusCode';
    }
  }

  // GET 请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST 请求
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT 请求
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE 请求
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> airwallexApiLogin() async {
    final headers = {
      'Content-Type': 'application/json',
      'x-client-id': clientId,
      'x-api-key': apiKey,
    };

    try {
      final response = await ApiService().post('/api/v1/authentication/login', options: Options(headers: headers));
      // 检查响应状态码
      if (response.statusCode == 200 || response.statusCode == 201) {
        // 请求成功，解析JSON响应
        Map<String, dynamic> map = response.data;
        if (map.containsKey("token")) {
          myToken = map["token"];
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', myToken);
        }
        return map;
      } else {
        // 请求失败
        throw Exception('登录失败: ${response.statusCode}');
      }
    } catch (e) {
      // 处理异常
      throw Exception('网络错误: $e');
    }
  }
}
