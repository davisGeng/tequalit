import '../network/api_exception.dart';
import '../network/dio_http_util.dart';

/// 示例：用户模块接口
class UserApi {
  /// 登录接口（POST）
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    return await dioHttp.post(
      "user/login",
      data: {
        "username": username,
        "password": password,
      },
    );
  }

  /// 获取用户信息（GET）
  static Future<Map<String, dynamic>> getUserInfo({required String userId}) async {
    return await dioHttp.get(
      "user/info",
      params: {"userId": userId},
    );
  }
}

/// 页面中调用示例
void _login() async {
  try {
    var res = await UserApi.login(username: "test", password: "123456");
    print("登录成功：$res");
    // 存储Token到本地
    // await SharedPreferences.getInstance().then((sp) => sp.setString("token", res["token"]));
  } on ApiException catch (e) {
    print("登录失败：${e.message}，错误码：${e.code}");
    // 上层统一提示错误，比如Toast
    // Toast.show(e.message);
  }
}