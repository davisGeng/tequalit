/// 网络请求常量配置
class ApiConstants {
  /// 环境切换：true-开发环境 / false-生产环境
  static const bool isDev = true;

  /// 基础域名 - 开发环境
  static const String devBaseUrl = "https://ubuntu-esxi.sightsyscloud.com/";
  /// 基础域名 - 生产环境
  static const String prodBaseUrl = "https://openapi-cn.sightsyscloud.com/";

  /// 获取当前环境BaseUrl
  static String get baseUrl => isDev ? devBaseUrl : prodBaseUrl;

  /// 请求超时时间（毫秒）
  static const int connectTimeout = 15000;
  /// 响应超时时间（毫秒）
  static const int receiveTimeout = 15000;

  /// 公共请求头
  static Map<String, dynamic> get baseHeaders => {
    "Content-Type": "application/json",
    "Accept": "application/json",

  };
}