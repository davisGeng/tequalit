import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_exception.dart';
import '../network/dio_http_util.dart';

/// 示例：用户模块接口
class UserApi {
  /// 登录接口（POST）
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    String countryCode = "US",
  }) async {
    Map<String, dynamic>? map = await dioHttp.post(
      "/api/v1/users/login/",
      data: {
        "username": username,
        "password": password,
        "country_code":countryCode
      },
    );
    if(map !=null){
      if(map.containsKey("token")){
        final sp = await SharedPreferences.getInstance();
        sp.setString('token', map['token']);
      }
    }
    return map ?? {};
  }

  /// 获取用户信息（GET）
  static Future<String> getUserInfo() async {
    List<dynamic>? res = await dioHttp.get(
      "/api/v1/users/",
    );
    if(res !=null){

    }
    return res.toString() ?? "";
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