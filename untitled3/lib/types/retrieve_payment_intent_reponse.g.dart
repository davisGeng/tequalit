// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieve_payment_intent_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrievePaymentIntentReponse _$RetrievePaymentIntentReponseFromJson(
        Map<String, dynamic> json) =>
    RetrievePaymentIntentReponse(
      id: json['id'] as String?,
      requestId: json['request_id'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      status: json['status'] as String?,
      merchantOrderId: json['merchant_order_id'] as String?,
      descriptor: json['descriptor'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      latestPaymentAttempt: json['latest_payment_attempt'] == null
          ? null
          : LatestPaymentAttempt.fromJson(
              json['latest_payment_attempt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RetrievePaymentIntentReponseToJson(
        RetrievePaymentIntentReponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'request_id': instance.requestId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'merchant_order_id': instance.merchantOrderId,
      'descriptor': instance.descriptor,
      'metadata': instance.metadata,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'latest_payment_attempt': instance.latestPaymentAttempt,
    };

LatestPaymentAttempt _$LatestPaymentAttemptFromJson(
        Map<String, dynamic> json) =>
    LatestPaymentAttempt(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      paymentMethod: json['payment_method'] == null
          ? null
          : PaymentMethod.fromJson(
              json['payment_method'] as Map<String, dynamic>),
      paymentIntentId: json['payment_intent_id'] as String?,
      status: json['status'] as String?,
      paymentMethodTransactionId:
          json['payment_method_transaction_id'] as String?,
      providerOriginalResponseCode:
          json['provider_original_response_code'] as String?,
      authorizationCode: json['authorization_code'] as String?,
      capturedAmount: (json['captured_amount'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      settleVia: json['settle_via'] as String?,
      authenticationData: json['authentication_data'] == null
          ? null
          : AuthenticationData.fromJson(
              json['authentication_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LatestPaymentAttemptToJson(
        LatestPaymentAttempt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'currency': instance.currency,
      'payment_method': instance.paymentMethod,
      'payment_intent_id': instance.paymentIntentId,
      'status': instance.status,
      'payment_method_transaction_id': instance.paymentMethodTransactionId,
      'provider_original_response_code': instance.providerOriginalResponseCode,
      'authorization_code': instance.authorizationCode,
      'captured_amount': instance.capturedAmount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'settle_via': instance.settleVia,
      'authentication_data': instance.authenticationData,
    };

AuthenticationData _$AuthenticationDataFromJson(Map<String, dynamic> json) =>
    AuthenticationData(
      dsData: json['ds_data'] == null
          ? null
          : DsData.fromJson(json['ds_data'] as Map<String, dynamic>),
      fraudData: json['fraud_data'] == null
          ? null
          : FraudData.fromJson(json['fraud_data'] as Map<String, dynamic>),
      avsResult: json['avs_result'] as String?,
      cvcResult: json['cvc_result'] as String?,
    );

Map<String, dynamic> _$AuthenticationDataToJson(AuthenticationData instance) =>
    <String, dynamic>{
      'ds_data': instance.dsData,
      'fraud_data': instance.fraudData,
      'avs_result': instance.avsResult,
      'cvc_result': instance.cvcResult,
    };

FraudData _$FraudDataFromJson(Map<String, dynamic> json) => FraudData(
      action: json['action'] as String?,
      score: json['score'] as String?,
      riskFactors: json['risk_factors'] as List<dynamic>?,
    );

Map<String, dynamic> _$FraudDataToJson(FraudData instance) => <String, dynamic>{
      'action': instance.action,
      'score': instance.score,
      'risk_factors': instance.riskFactors,
    };

DsData _$DsDataFromJson(Map<String, dynamic> json) => DsData();

Map<String, dynamic> _$DsDataToJson(DsData instance) => <String, dynamic>{};

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      type: json['type'] as String?,
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'type': instance.type,
      'card': instance.card,
    };

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      expiryMonth: json['expiry_month'] as String?,
      expiryYear: json['expiry_year'] as String?,
      name: json['name'] as String?,
      bin: json['bin'] as String?,
      last4: json['last4'] as String?,
      brand: json['brand'] as String?,
      issuerCountryCode: json['issuer_country_code'] as String?,
      cardType: json['card_type'] as String?,
      fingerprint: json['fingerprint'] as String?,
      billing: json['billing'] == null
          ? null
          : Billing.fromJson(json['billing'] as Map<String, dynamic>),
      issuerName: json['issuer_name'] as String?,
      isCommercial: json['is_commercial'] as bool?,
      numberType: json['number_type'] as String?,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'expiry_month': instance.expiryMonth,
      'expiry_year': instance.expiryYear,
      'name': instance.name,
      'bin': instance.bin,
      'last4': instance.last4,
      'brand': instance.brand,
      'issuer_country_code': instance.issuerCountryCode,
      'card_type': instance.cardType,
      'fingerprint': instance.fingerprint,
      'billing': instance.billing,
      'issuer_name': instance.issuerName,
      'is_commercial': instance.isCommercial,
      'number_type': instance.numberType,
    };

Billing _$BillingFromJson(Map<String, dynamic> json) => Billing(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillingToJson(Billing instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      countryCode: json['country_code'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      postcode: json['postcode'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'country_code': instance.countryCode,
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'postcode': instance.postcode,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      foo: json['foo'] as String?,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'foo': instance.foo,
    };
