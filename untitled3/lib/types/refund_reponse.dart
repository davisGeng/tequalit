import 'package:json_annotation/json_annotation.dart';
part 'refund_reponse.g.dart';

@JsonSerializable()
class RefundReponse {
  @JsonKey(name: 'has_more')
  bool? hasMore;
  @JsonKey(name: 'items')
  List<RefundItem>? items;

  RefundReponse({this.hasMore, this.items});

  factory RefundReponse.fromJson(Map<String, dynamic> json) => _$RefundReponseFromJson(json);

  static List<RefundReponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(RefundReponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$RefundReponseToJson(this);
}

@JsonSerializable()
class RefundItem {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'request_id')
  String? requestId;
  @JsonKey(name: 'payment_intent_id')
  String? paymentIntentId;
  @JsonKey(name: 'payment_attempt_id')
  String? paymentAttemptId;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'reason')
  String? reason;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  RefundItem(
      {this.id,
      this.requestId,
      this.paymentIntentId,
      this.paymentAttemptId,
      this.amount,
      this.currency,
      this.reason,
      this.status,
      this.createdAt,
      this.updatedAt});

  factory RefundItem.fromJson(Map<String, dynamic> json) => _$RefundItemFromJson(json);

  static List<RefundItem> fromList(List<Map<String, dynamic>> list) {
    return list.map(RefundItem.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$RefundItemToJson(this);
}
