
import 'package:json_annotation/json_annotation.dart';
part 'payment_intent_cancel_reponse.g.dart';

@JsonSerializable()
class PaymentIntentCancelReponse {
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

    PaymentIntentCancelReponse({this.id, this.requestId, this.amount, this.currency, this.status, this.merchantOrderId, this.descriptor, this.metadata, this.createdAt, this.updatedAt});

    factory PaymentIntentCancelReponse.fromJson(Map<String, dynamic> json) => _$PaymentIntentCancelReponseFromJson(json);

    static List<PaymentIntentCancelReponse> fromList(List<Map<String, dynamic>> list) {
        return list.map(PaymentIntentCancelReponse.fromJson).toList();
    }

    Map<String, dynamic> toJson() => _$PaymentIntentCancelReponseToJson(this);
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