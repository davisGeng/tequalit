import 'package:airwallex_payment_flutter/types/payment_consent.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled3/types/refund_reponse.dart';

import 'api_client.dart';

class PaymentRepository {
  final ApiClient apiClient;

  PaymentRepository({required this.apiClient});

  Future<Map<String, dynamic>> getPaymentIntentFromServer(
      {Map<String, dynamic>? param, bool? force3DS, String? customerId}) async {
    final body = {
      'apiKey': apiClient.apiKey,
      'clientId': apiClient.clientId,
      'request_id': UniqueKey().toString(),
      'amount': '1.00',
      'currency': 'HKD',
      'countryCode': "HK",
      'merchant_order_id': UniqueKey().toString(),
      'order': {
        'type': 'physical_goods',
      },
      'referrer_data': {'type': 'android_sdk_sample'},
      'descriptor': 'Airwallex - T-shirt',
      'metadata': {'id': 1},
      'email': 'yimadangxian@airwallex.com',
      'return_url': 'airwallexcheckout://com.example.airwallex_payment_flutter_example',
    };
    if (param != null) {
      //merchant_order_id 商户网站的订单号
      const keys = ['amount', 'currency', 'email', 'merchant_order_id'];
      for (var key in keys) {
        if (param.containsKey(key)) {
          body[key] = param[key];
        }
      }
    }

    if (force3DS == true) {
      body['payment_method_options'] = {
        'card': {'three_ds_action': 'FORCE_3DS'}
      };
    }

    if (customerId != null) {
      body['customer_id'] = customerId;
    }

    Map<String, dynamic> paymentIntentResponse = await apiClient.createPaymentIntent(body);
    if (!paymentIntentResponse.containsKey("countryCode")) {
      paymentIntentResponse["countryCode"] = body["countryCode"];
    }
    return paymentIntentResponse;
  }

  Future<String> getCustomerId({Map<String, dynamic>? param}) async {
    final body = {
      'apiKey': apiClient.apiKey,
      'clientId': apiClient.clientId,
      'request_id': UniqueKey().toString(),
      'merchant_customer_id': UniqueKey().toString(),
      'first_name': 'John',
      'last_name': 'Doe',
      'email': 'john.doe@airwallex.com',
      'phone_number': '13800000000',
      'additional_info': {
        'registered_via_social_media': false,
        'registration_date': '2019-09-18',
        'first_successful_order_date': '2019-09-18'
      },
      'metadata': {'id': 1}
    };
    if (param != null) {
      //merchant_customer_id 商户系统中的唯一客户ID
      const keys = ['first_name', 'last_name', 'email', 'phone_number', 'merchant_customer_id'];
      for (var key in keys) {
        if (param.containsKey(key)) {
          body[key] = param[key];
        }
      }
    }

    final response = await apiClient.createCustomer(body);
    return response['id'];
  }

  Future<String> getClientSecret(String customerId) async {
    final response = await apiClient.createClientSecretWithQuery(customerId);
    return response['client_secret'];
  }

  Future<List<PaymentConsent>> getPaymentConsents(String customerId) async {
    final response = await apiClient.getPaymentConsents(customerId);
    return response['items'].map<PaymentConsent>((item) => PaymentConsent.fromJson(item)).toList();
  }
}
