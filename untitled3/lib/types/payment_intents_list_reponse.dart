import 'package:json_annotation/json_annotation.dart';
part 'payment_intents_list_reponse.g.dart';

@JsonSerializable()
class PaymentIntentsListReponse {
  @JsonKey(name: 'has_more')
  bool? hasMore;
  @JsonKey(name: 'items')
  List<Items>? items;

  PaymentIntentsListReponse({this.hasMore, this.items});

  factory PaymentIntentsListReponse.fromJson(Map<String, dynamic> json) => _$PaymentIntentsListReponseFromJson(json);

  static List<PaymentIntentsListReponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(PaymentIntentsListReponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$PaymentIntentsListReponseToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: 'latest_payment_attempt')
  LatestPaymentAttempt? latestPaymentAttempt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'request_id')
  String? requestId;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'merchant_order_id')
  String? merchantOrderId;
  @JsonKey(name: 'descriptor')
  String? descriptor;
  @JsonKey(name: 'metadata')
  Metadata? metadata;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  Items(
      {this.latestPaymentAttempt,
      this.id,
      this.requestId,
      this.amount,
      this.currency,
      this.merchantOrderId,
      this.descriptor,
      this.metadata,
      this.status,
      this.createdAt,
      this.updatedAt});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  static List<Items> fromList(List<Map<String, dynamic>> list) {
    return list.map(Items.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
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

@JsonSerializable()
class LatestPaymentAttempt {
  @JsonKey(name: 'id')
  String? id;

  LatestPaymentAttempt({this.id});

  factory LatestPaymentAttempt.fromJson(Map<String, dynamic> json) => _$LatestPaymentAttemptFromJson(json);

  static List<LatestPaymentAttempt> fromList(List<Map<String, dynamic>> list) {
    return list.map(LatestPaymentAttempt.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$LatestPaymentAttemptToJson(this);
}
