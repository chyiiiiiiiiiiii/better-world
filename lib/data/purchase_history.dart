import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_history.freezed.dart';
part 'purchase_history.g.dart';

@freezed
class PurchaseHistory with _$PurchaseHistory {
  factory PurchaseHistory({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'product_type') required String productType,
    @JsonKey(name: 'created_at') required int createdAt,
    @JsonKey(name: 'end_at') required int endAt,
  }) = _PurchaseHistory;

  factory PurchaseHistory.fromJson(Map<String, dynamic> json) =>
      _$PurchaseHistoryFromJson(json);
}
