import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';
import 'api_exception.dart';

/// Dio 网络请求工具类（单例模式）
class DioHttpUtil {
  /// 单例实例
  static final DioHttpUtil _instance = DioHttpUtil._internal();

  /// 对外暴露单例
  factory DioHttpUtil() => _instance;

  /// Dio 实例
  late Dio dio;

  /// 私有化构造方法（单例核心）
  DioHttpUtil._internal() {
    // 1. 初始化Dio
    dio = Dio();

    // 2. 基础配置
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
      receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
      headers: ApiConstants.baseHeaders,
      responseType: ResponseType.json, // 响应数据格式为JSON
    );

    // 3. 适配HTTPS（忽略证书校验，生产环境可根据需求配置证书）
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );

    // 4. 添加全局拦截器（请求、响应、错误）
    _addInterceptors();
  }

  /// 添加全局拦截器
  void _addInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      /// 请求拦截器：发送请求前执行（添加Token、公共参数、加解密等）
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        // 示例：从本地缓存获取Token，添加到请求头
        final sp = await SharedPreferences.getInstance();
        String? token = sp.getString("token");
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
        handler.next(options);
      },

      /// 响应拦截器：请求成功后执行（统一解析数据、处理业务逻辑）
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // 示例：后端统一返回格式 {code:200, data:..., msg:...}
        Map<String, dynamic> resData = response.data;
        int code = resData["code"] ?? -1;
        String msg = resData["msg"] ?? "请求失败";

        if (code == 200) {
          // 业务成功：直接返回data，上层无需再解析外层结构
          handler.resolve(Response(
            requestOptions: response.requestOptions,
            data: resData["data"],
            statusCode: 200,
          ));
        } else {
          // 业务失败：抛出自定义异常，上层catch捕获
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: ApiException(code: code, message: msg),
            ),
            true,
          );
        }
      },

      /// 错误拦截器：请求失败时执行（统一处理网络错误、超时、状态码等）
      onError: (DioException e, ErrorInterceptorHandler handler) {
        ApiException apiException;
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          // 超时错误
          apiException = ApiException.timeoutError;
        } else if (e.type == DioExceptionType.connectionError) {
          // 网络错误（无网络）
          apiException = ApiException.networkError;
        } else if (e.response != null) {
          // HTTP状态码错误（4xx/5xx）
          int statusCode = e.response!.statusCode!;
          if (statusCode >= 500) {
            apiException = ApiException.serverError;
          } else {
            apiException = ApiException(
              code: statusCode,
              message: "请求失败，状态码：$statusCode",
            );
          }
        } else {
          // 未知错误
          apiException = ApiException.unknownError;
        }
        // 抛出统一异常
        handler.reject(
          DioException(
            requestOptions: e.requestOptions,
            error: apiException,
            type: e.type,
          ),

        );
      },
    ));
  }

  /// ===================== 核心请求方法封装 =====================
  /// 通用GET请求
  /// [url] 请求接口路径（拼接BaseUrl）
  /// [params] 请求参数（url拼接）
  /// [cancelToken] 请求取消令牌
  Future<T> get<T>(
      String url, {
        Map<String, dynamic>? params,
        CancelToken? cancelToken,
      }) async {
    try {
      Response response = await dio.get(
        url,
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// 通用POST请求
  /// [url] 请求接口路径（拼接BaseUrl）
  /// [data] 请求体参数
  /// [params] url拼接参数
  /// [cancelToken] 请求取消令牌
  Future<T> post<T>(
      String url, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? params,
        CancelToken? cancelToken,
      }) async {
    try {
      Response response = await dio.post(
        url,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// 通用PUT请求
  Future<T> put<T>(
      String url, {
        Map<String, dynamic>? data,
        CancelToken? cancelToken,
      }) async {
    try {
      Response response = await dio.put(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// 通用DELETE请求
  Future<T> delete<T>(
      String url, {
        Map<String, dynamic>? params,
        CancelToken? cancelToken,
      }) async {
    try {
      Response response = await dio.delete(
        url,
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// 创建请求取消令牌（用于页面销毁时取消请求）
  CancelToken createCancelToken() => CancelToken();
}

/// 全局单例实例，上层直接调用
final dioHttp = DioHttpUtil();