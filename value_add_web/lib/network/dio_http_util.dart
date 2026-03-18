import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart'; // 必须导入：用于kIsWeb判断平台
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';
import 'api_exception.dart';

/// Dio 网络请求工具类（单例模式 | Flutter Web/Android/iOS 全平台兼容）
class DioHttpUtil {
  /// 单例实例（全局唯一）
  static final DioHttpUtil instance = DioHttpUtil._internal();
  factory DioHttpUtil() => instance;

  /// Dio 核心实例
  late Dio dio;

  /// 私有化构造方法（单例核心）
  DioHttpUtil._internal() {
    // 1. 初始化Dio基础配置（全平台通用）
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: ApiConstants.baseHeaders,
        responseType: ResponseType.json,
      ),
    );

    // 2. 平台差异化配置【核心适配】
    // _platformAdapterConfig();

    // 3. 添加全局拦截器（请求/响应/错误，全平台通用）
    _addInterceptors();
  }

  /// ✅ 核心适配：根据平台差异化配置 HttpClientAdapter
  // void _platformAdapterConfig() {
  //   if (!kIsWeb) {
  //     // 📌 仅原生平台（Android/iOS）执行：配置IO适配器 + 忽略HTTPS证书校验
  //     dio.httpClientAdapter = IOHttpClientAdapter(
  //       createHttpClient: () {
  //         final client = HttpClient();
  //         client.badCertificateCallback = (cert, host, port) => true;
  //         return client;
  //       },
  //     );
  //   } else {
  //     // 📌 Flutter Web环境：使用默认的 BrowserHttpClientAdapter
  //     // Web环境无需手动配置适配器，Dio会自动适配浏览器的 Fetch/XMLHttpRequest
  //     // Web端证书校验由浏览器自动处理，无需手动忽略
  //   }
  // }

  /// 添加全局拦截器（全平台通用，无修改）
  void _addInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        /// 请求拦截：添加Token、公共参数（全平台通用）
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          final sp = await SharedPreferences.getInstance();
          String? token = sp.getString("token");
          // token = "";
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Token $token";
          }
          handler.next(options);
        },

        /// 响应拦截：统一解析后端数据格式（全平台通用）
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          Map<String, dynamic> resData = response.data;
          int code = resData["code"] ?? -1;
          String msg = resData["msg"] ?? "请求失败";

          if (code == 200 || code == 20000) {
            handler.resolve(Response(requestOptions: response.requestOptions, data: resData["data"], statusCode: 200));
          } else {
            handler.reject(
              DioException(requestOptions: response.requestOptions, error: ApiException(code: code, message: msg)),
              true,
            );
          }
        },

        /// 错误拦截：统一处理所有平台的网络/业务/超时错误
        onError: (DioException e, ErrorInterceptorHandler handler) {
          ApiException apiException;
          if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
            apiException = ApiException.timeoutError;
          } else if (e.type == DioExceptionType.connectionError) {
            apiException = ApiException.networkError;
          } else if (e.response != null) {
            int statusCode = e.response!.statusCode!;
            apiException =
                statusCode >= 500
                    ? ApiException.serverError
                    : ApiException(code: statusCode, message: "请求失败，状态码：$statusCode");
          } else {
            apiException = ApiException.unknownError;
          }
          handler.reject(DioException(requestOptions: e.requestOptions, error: apiException, type: e.type));
        },
      ),
    );

    // 开发环境：添加日志拦截器（全平台通用，可查看请求/响应详情）
    if (ApiConstants.isDev) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, requestHeader: true, responseHeader: true),
      );
    }
  }

  /// ===================== 全平台通用请求方法封装 =====================
  /// GET请求（泛型解析，支持所有平台）
  Future<T> get<T>(String url, {Map<String, dynamic>? params, CancelToken? cancelToken}) async {
    try {
      Response response = await dio.get(url, queryParameters: params, cancelToken: cancelToken);
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// POST请求（泛型解析，支持所有平台）
  Future<T> post<T>(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await dio.post(url, data: data, queryParameters: params, cancelToken: cancelToken);
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// PUT请求（全平台通用）
  Future<T> put<T>(String url, {Map<String, dynamic>? data, CancelToken? cancelToken}) async {
    try {
      Response response = await dio.put(url, data: data, cancelToken: cancelToken);
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// DELETE请求（全平台通用）
  Future<T> delete<T>(String url, {Map<String, dynamic>? params, CancelToken? cancelToken}) async {
    try {
      Response response = await dio.delete(url, queryParameters: params, cancelToken: cancelToken);
      return response.data as T;
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// 创建请求取消令牌（解决页面销毁内存泄漏，全平台通用）
  CancelToken createCancelToken() => CancelToken();
}

/// 全局单例实例（所有平台统一调用，无需修改）
final dioHttp = DioHttpUtil();
