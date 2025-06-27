import 'package:airwallex_payment_flutter/types/environment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:untitled3/util/log_service.dart';

class ApiClient {
  late String checkoutDemoBaseUrl;
  final String apiKey;
  final String clientId;
  final Environment environment;
  String token = "";

  ApiClient({required this.environment, required this.apiKey, required this.clientId}) {
    checkoutDemoBaseUrl = _getCheckoutDemoBaseUrlForEnvironment(environment);
  }

  String _getCheckoutDemoBaseUrlForEnvironment(Environment environment) {
    switch (environment) {
      case Environment.demo:
        return 'https://demo-pacheckoutdemo.airwallex.com';
      case Environment.staging:
        return 'https://staging-pacheckoutdemo.airwallex.com';
      default:
        return '';
    }
  }

  Future<Map<String, dynamic>> airwallexLogin() async {
    final url = Uri.parse('$checkoutDemoBaseUrl/api/v1/authentication/login');

    final headers = {
      'Content-Type': 'application/json',
      'x-client-id': clientId,
      'x-api-key': apiKey,
    };

    try {
      // 发起POST请求
      final response = await http.post(
        url,
        headers: headers,
        // body: jsonEncode({}), // 空JSON体，如果API需要参数则在此添加
      );

      // 检查响应状态码
      if (response.statusCode == 200 || response.statusCode == 201) {
        // 请求成功，解析JSON响应
        Map<String, dynamic> map = jsonDecode(response.body);
        if (map.containsKey("token")) {
          token = map["token"];
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
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

  Future<Map<String, dynamic>> createPaymentIntent(Map<String, dynamic> params) async {
    Log.d('Creating payment intent with params: $params');
    try {
      final response = await http.post(
        Uri.parse('$checkoutDemoBaseUrl/api/v1/pa/payment_intents/create'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(params),
      );
      Log.d('HTTP Response Status Code: ${response.statusCode}');
      Log.d('HTTP Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      Log.d('Error occurred while creating payment intent: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getPaymentIntents(Map<String, dynamic> params) async {
    await retrieveAPaymentIntent("int_hkdmk6msch8nn7a0hob");
    // 'https://api-demo.airwallex.com/api/v1/pa/payment_intents?
    // from_created_at=2025-01-01T06%3A57%3A10%2B08%3A00&
    // merchant_order_id=D202503210001&
    // page_num=0&page_size=10&
    // to_created_at=2025-01-31T17%3A57%3A10%2B08%3A00' \
    DateTime parsedTime = DateTime.parse('2025-06-24 06:57:10');
    String from_created_at = parsedTime.toIso8601String();
    DateTime parsedTime2 = DateTime.parse('2025-06-27 06:57:10');
    String to_created_at = parsedTime2.toIso8601String();
    int page_num = 0;
    int page_size = 10;
    String merchant_order_id = "CB202506261924111";
    String temUrl =
        "from_created_at=2025-06-21T06%3A57%3A10%2B08%3A00&merchant_order_id=${merchant_order_id}&page_num=0&page_size=10&to_created_at=2025-06-31T17%3A57%3A10%2B08%3A00";
    String subURL =
        "from_created_at=$from_created_at&merchant_order_id=$merchant_order_id&page_num=$page_num&page_size=$page_size&to_created_at=$to_created_at";
    Log.d('Creating payment intent with params: $params');
    try {
      if (token.isEmpty) {
        final prefs = await SharedPreferences.getInstance();
        token = prefs.getString('token') ?? "";
      }
      final response = await http.get(
        Uri.parse('$checkoutDemoBaseUrl/api/v1/pa/payment_intents?$temUrl'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      Log.d('HTTP Response Status Code: ${response.statusCode}');
      Log.d('HTTP Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      Log.d('Error occurred while creating payment intent: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> retrieveAPaymentIntent(String intentId) async {
    try {
      if (token.isEmpty) {
        final prefs = await SharedPreferences.getInstance();
        token = prefs.getString('token') ?? "";
      }
      token =
          "eyJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoiY2xpZW50IiwiZGMiOiJISyIsImRhdGFfY2VudGVyX3JlZ2lvbiI6IkhLIiwiaXNzZGMiOiJVUyIsImp0aSI6IjIwZjVjMjY2LWMzOTUtNGYwOC04ZjRlLTgxNTM5YmE4MTdlMiIsInN1YiI6ImZlNGM1Nzk0LTQ3ZTUtNDU1MC04NmViLTUyNTRhOTlhNjcwZiIsImlhdCI6MTc1MDk4NTc2OSwiZXhwIjoxNzUwOTg3NTY5LCJhY2NvdW50X2lkIjoiZTMyYWY5OTEtNzZmYy00YmFmLWE5NjUtYjFlMDJiYjc3MzMwIiwiYXBpX3ZlcnNpb24iOiIyMDI0LTAyLTIyIiwicGVybWlzc2lvbnMiOlsicjphd3g6KjoqIiwidzphd3g6KjoqIl19.R-N9oHSWKZfcz2Tcywqe8rszLT4bOzTVgsK-PL7bKEo";
      final response = await http.get(
        Uri.parse('$checkoutDemoBaseUrl/api/v1/pa/payment_intents/int_hkdmk6msch8nn7a0hob'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      Log.d('HTTP Response Status Code: ${response.statusCode}');
      Log.d('HTTP Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      Log.d('Error occurred while creating payment intent: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createCustomer(Map<String, dynamic> params) async {
    Log.d('Creating customer with params: $params');
    try {
      final response = await http.post(
        Uri.parse('$checkoutDemoBaseUrl/api/v1/pa/customers/create'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(params),
      );
      Log.d('HTTP Response Status Code: ${response.statusCode}');
      Log.d('HTTP Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create customer: ${response.body}');
      }
    } catch (e) {
      Log.d('Error occurred while creating customer: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createClientSecretWithQuery(String customerId) async {
    Log.d('Generating client secret for customer: $customerId');
    try {
      final response = await http.get(
        Uri.parse(
            '$checkoutDemoBaseUrl/api/v1/pa/customers/$customerId/generate_client_secret?apiKey=$apiKey&clientId=$clientId'),
      );
      Log.d('HTTP Response Status Code: ${response.statusCode}');
      Log.d('HTTP Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create client secret: ${response.body}');
      }
    } catch (e) {
      Log.d('Error occurred while generating client secret: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getPaymentConsents(String customerId) async {
    Log.d('Fetching payment consents');
    try {
      final response =
          await http.get(Uri.parse('$checkoutDemoBaseUrl/api/v1/pa/payment_consents?customer_id=$customerId'));
      Log.d('HTTP Response Status Code: ${response.statusCode}');
      Log.d('HTTP Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch payment consents: ${response.body}');
      }
    } catch (e) {
      Log.d('Error occurred while fetching payment consents: $e');
      rethrow;
    }
  }
}
