/// 网络请求统一异常类
class ApiException implements Exception {
  /// 错误码
  final int code;

  /// 错误信息
  final String message;

  ApiException({
    required this.code,
    required this.message,
  });

  /// 常见预设异常
  // 网络错误（无网络）
  static ApiException networkError = ApiException(code: -1, message: "网络异常，请检查你的网络连接");
  // 请求超时
  static ApiException timeoutError = ApiException(code: -2, message: "请求超时，请稍后重试");
  // 服务器错误（5xx）
  static ApiException serverError = ApiException(code: -3, message: "服务器内部错误，请稍后重试");
  // 未知错误
  static ApiException unknownError = ApiException(code: -999, message: "未知错误，请稍后重试");

  @override
  String toString() => "ApiException(code: $code, message: $message)";
}