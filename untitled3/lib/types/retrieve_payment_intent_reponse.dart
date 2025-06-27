
import 'package:json_annotation/json_annotation.dart';
part 'retrieve_payment_intent_reponse.g.dart';

@JsonSerializable()
class RetrievePaymentIntentReponse {
    @JsonKey(name: 'id')
    String? id;
    @JsonKey(name: 'request_id')
    String? requestId;
    @JsonKey(name: 'amount')
    int? amount;
    @JsonKey(name: 'currency')
    String? currency;
    @JsonKey(name: 'status')
    String? status;
    @JsonKey(name: 'merchant_order_id')
    String? merchantOrderId;
    @JsonKey(name: 'descriptor')
    String? descriptor;
    @JsonKey(name: 'metadata')
    Metadata? metadata;
    @JsonKey(name: 'created_at')
    String? createdAt;
    @JsonKey(name: 'updated_at')
    String? updatedAt;
    @JsonKey(name: 'latest_payment_attempt')
    LatestPaymentAttempt? latestPaymentAttempt;

    RetrievePaymentIntentReponse({this.id, this.requestId, this.amount, this.currency, this.status, this.merchantOrderId, this.descriptor, this.metadata, this.createdAt, this.updatedAt, this.latestPaymentAttempt});

    factory RetrievePaymentIntentReponse.fromJson(Map<String, dynamic> json) => _$RetrievePaymentIntentReponseFromJson(json);

    static List<RetrievePaymentIntentReponse> fromList(List<Map<String, dynamic>> list) {
        return list.map(RetrievePaymentIntentReponse.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$RetrievePaymentIntentReponseToJson(this);
}

@JsonSerializable()
class LatestPaymentAttempt {
    @JsonKey(name: 'id')
    String? id;
    @JsonKey(name: 'amount')
    int? amount;
    @JsonKey(name: 'currency')
    String? currency;
    @JsonKey(name: 'payment_method')
    PaymentMethod? paymentMethod;
    @JsonKey(name: 'payment_intent_id')
    String? paymentIntentId;
    @JsonKey(name: 'status')
    String? status;
    @JsonKey(name: 'payment_method_transaction_id')
    String? paymentMethodTransactionId;
    @JsonKey(name: 'provider_original_response_code')
    String? providerOriginalResponseCode;
    @JsonKey(name: 'authorization_code')
    String? authorizationCode;
    @JsonKey(name: 'captured_amount')
    int? capturedAmount;
    @JsonKey(name: 'created_at')
    String? createdAt;
    @JsonKey(name: 'updated_at')
    String? updatedAt;
    @JsonKey(name: 'settle_via')
    String? settleVia;
    @JsonKey(name: 'authentication_data')
    AuthenticationData? authenticationData;

    LatestPaymentAttempt({this.id, this.amount, this.currency, this.paymentMethod, this.paymentIntentId, this.status, this.paymentMethodTransactionId, this.providerOriginalResponseCode, this.authorizationCode, this.capturedAmount, this.createdAt, this.updatedAt, this.settleVia, this.authenticationData});

    factory LatestPaymentAttempt.fromJson(Map<String, dynamic> json) => _$LatestPaymentAttemptFromJson(json);

    static List<LatestPaymentAttempt> fromList(List<Map<String, dynamic>> list) {
        return list.map(LatestPaymentAttempt.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$LatestPaymentAttemptToJson(this);
}

@JsonSerializable()
class AuthenticationData {
    @JsonKey(name: 'ds_data')
    DsData? dsData;
    @JsonKey(name: 'fraud_data')
    FraudData? fraudData;
    @JsonKey(name: 'avs_result')
    String? avsResult;
    @JsonKey(name: 'cvc_result')
    String? cvcResult;

    AuthenticationData({this.dsData, this.fraudData, this.avsResult, this.cvcResult});

    factory AuthenticationData.fromJson(Map<String, dynamic> json) => _$AuthenticationDataFromJson(json);

    static List<AuthenticationData> fromList(List<Map<String, dynamic>> list) {
        return list.map(AuthenticationData.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$AuthenticationDataToJson(this);
}

@JsonSerializable()
class FraudData {
    @JsonKey(name: 'action')
    String? action;
    @JsonKey(name: 'score')
    String? score;
    @JsonKey(name: 'risk_factors')
    List<dynamic>? riskFactors;

    FraudData({this.action, this.score, this.riskFactors});

    factory FraudData.fromJson(Map<String, dynamic> json) => _$FraudDataFromJson(json);

    static List<FraudData> fromList(List<Map<String, dynamic>> list) {
        return list.map(FraudData.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$FraudDataToJson(this);
}

@JsonSerializable()
class DsData {
    DsData();

    factory DsData.fromJson(Map<String, dynamic> json) => _$DsDataFromJson(json);

    static List<DsData> fromList(List<Map<String, dynamic>> list) {
        return list.map(DsData.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$DsDataToJson(this);
}

@JsonSerializable()
class PaymentMethod {
    @JsonKey(name: 'type')
    String? type;
    @JsonKey(name: 'card')
    Card? card;

    PaymentMethod({this.type, this.card});

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

    static List<PaymentMethod> fromList(List<Map<String, dynamic>> list) {
        return list.map(PaymentMethod.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}

@JsonSerializable()
class Card {
    @JsonKey(name: 'expiry_month')
    String? expiryMonth;
    @JsonKey(name: 'expiry_year')
    String? expiryYear;
    @JsonKey(name: 'name')
    String? name;
    @JsonKey(name: 'bin')
    String? bin;
    @JsonKey(name: 'last4')
    String? last4;
    @JsonKey(name: 'brand')
    String? brand;
    @JsonKey(name: 'issuer_country_code')
    String? issuerCountryCode;
    @JsonKey(name: 'card_type')
    String? cardType;
    @JsonKey(name: 'fingerprint')
    String? fingerprint;
    @JsonKey(name: 'billing')
    Billing? billing;
    @JsonKey(name: 'issuer_name')
    String? issuerName;
    @JsonKey(name: 'is_commercial')
    bool? isCommercial;
    @JsonKey(name: 'number_type')
    String? numberType;

    Card({this.expiryMonth, this.expiryYear, this.name, this.bin, this.last4, this.brand, this.issuerCountryCode, this.cardType, this.fingerprint, this.billing, this.issuerName, this.isCommercial, this.numberType});

    factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

    static List<Card> fromList(List<Map<String, dynamic>> list) {
        return list.map(Card.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$CardToJson(this);
}

@JsonSerializable()
class Billing {
    @JsonKey(name: 'first_name')
    String? firstName;
    @JsonKey(name: 'last_name')
    String? lastName;
    @JsonKey(name: 'email')
    String? email;
    @JsonKey(name: 'phone_number')
    String? phoneNumber;
    @JsonKey(name: 'address')
    Address? address;

    Billing({this.firstName, this.lastName, this.email, this.phoneNumber, this.address});

    factory Billing.fromJson(Map<String, dynamic> json) => _$BillingFromJson(json);

    static List<Billing> fromList(List<Map<String, dynamic>> list) {
        return list.map(Billing.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$BillingToJson(this);
}

@JsonSerializable()
class Address {
    @JsonKey(name: 'country_code')
    String? countryCode;
    @JsonKey(name: 'state')
    String? state;
    @JsonKey(name: 'city')
    String? city;
    @JsonKey(name: 'street')
    String? street;
    @JsonKey(name: 'postcode')
    String? postcode;

    Address({this.countryCode, this.state, this.city, this.street, this.postcode});

    factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

    static List<Address> fromList(List<Map<String, dynamic>> list) {
        return list.map(Address.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Metadata {
    @JsonKey(name: 'foo')
    String? foo;

    Metadata({this.foo});

    factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

    static List<Metadata> fromList(List<Map<String, dynamic>> list) {
        return list.map(Metadata.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$MetadataToJson(this);
}