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

  Future<Map<String, dynamic>> cancelAPaymentIntent(String intentId, String reason, {String? requestId}) async {
    Response response;
    try {
      response = await ApiService().post(
        '/api/v1/pa/payment_intents/$intentId/cancel',
        data: {"cancellation_reason": intentId, "reason": reason, "request_id": requestId ?? UniqueKey().toString()},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to cancel a paymentintent : ${response.data}');
      }
    } catch (e) {
      Log.d('Error occurred while cancel a paymentintent: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createARefund(String intentId) async {
    Response response;

    try {
      response = await ApiService().post(
        '/api/v1/pa/refunds/create',
        data: {
          "payment_intent_id": intentId,
          "reason": "Return goods",
          "amount": 0.1,
          "request_id": UniqueKey().toString()
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create a refund : ${response.data}');
      }
    } catch (e) {
      Log.d('Error occurred while create a refund: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> retrieveARefund(String refundId) async {
    try {
      Response response;
      String url = '/api/v1/pa/refunds/$refundId';
      response = await ApiService().get(
        url,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to retrieve a refund : ${response.data}');
      }
    } catch (e) {
      Log.d('Error occurred while retrieve a refund: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> retrieveAPaymentIntent(String intentId) async {
    try {
      Response response;
      intentId = "int_hkdmc7txzh8ogooogeq";
      response = await ApiService().get(
        '/api/v1/pa/payment_intents/$intentId',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to retrieve a payment intent: ${response.data}');
      }
    } catch (e) {
      Log.d('Error occurred while retrieve a payment intent: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRetriesRefundList(int pageNum, int pageSize, String status) async {
    try {
      // SUCCEEDED
      Map<String, dynamic> map = {"page_num": pageNum, "page_size": pageSize, "status": status};
      Response response;

      response = await ApiService().get(
        '/api/v1/pa/refunds',
        queryParameters: map,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to get retries refund list: ${response.data}');
      }
    } catch (e) {
      Log.d('Error occurred while get retrieve refund list: $e');
      rethrow;
    }
  }
}
