import 'package:airwallex_payment_flutter/types/environment.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/api/ApiService.dart';
import 'dart:convert';

import 'package:untitled3/util/log_service.dart';
import 'package:dio/dio.dart';

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

//======================= api 方法，不走airwallex flutter sdk ===============使用 APIService 请求==================
  Future<Map<String, dynamic>> getPaymentIntents(Map<String, dynamic> params) async {
    // DateTime parsedTime = DateTime.parse('2025-06-24 06:57:10');
    // String from_created_at = parsedTime.toIso8601String();
    // DateTime parsedTime2 = DateTime.parse('2025-06-27 06:57:10');
    // String to_created_at = parsedTime2.toIso8601String();
    // int page_num = 0;
    // int page_size = 10;
    // String merchant_order_id = "CB202506261924111";
    Map<String, dynamic> sendParam = {};
    const keys = ['from_created_at', 'merchant_order_id', 'page_num', 'page_size', 'to_created_at'];
    for (var key in keys) {
      if (params.containsKey(key)) {
        sendParam[key] = params[key];
      }
    }

    Log.d('getPaymentIntents params: $sendParam');
    try {
      final response = await ApiService().get('/api/v1/pa/payment_intents', queryParameters: sendParam);

      Log.d('HTTP Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.data);
      } else {
        throw Exception('Failed to getPaymentIntents: ${response.data}');
      }
    } catch (e) {
      Log.d('Error occurred while getPaymentIntents: $e');
      rethrow;
    }
  }

  Future<void> createARefund(String intentId) async {
    Response response;

    response = await ApiService().post(
      '/api/v1/pa/refunds/create',
      data: {
        "payment_intent_id": intentId,
        "reason": "Return goods",
        "amount": 0.1,
        "request_id": UniqueKey().toString()
      },
    );
    String jss = response.data.toString();
    print(jss);
  }

  Future<void> retrieveARefund(String refundId) async {
    Response response;
    String url = '/api/v1/pa/refunds/$refundId';
    response = await ApiService().get(
      url,
    );
    String jss = response.data.toString();
    print(jss);
  }

  Future<Map<String, dynamic>> retrieveAPaymentIntent(String intentId) async {
    Response response;
    intentId = "int_hkdmc7txzh8ogooogeq";
    response = await ApiService().get(
      '/api/v1/pa/payment_intents/$intentId',
    );
    String jss = response.data.toString();
    print(jss);
    return {};
  }

  Future<Map<String, dynamic>> getRetriesRefundList() async {
    Map<String, dynamic> map = {"page_num": "0", "page_size": "10", "status": "SUCCEEDED"};
    Response response;

    response = await ApiService().get(
      '/api/v1/pa/refunds',
      queryParameters: map,
    );
    String jss = response.data.toString();
    print(jss);
    return {};
  }
}
