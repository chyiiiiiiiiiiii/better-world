import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_wallet_pass_property.freezed.dart';
part 'google_wallet_pass_property.g.dart';

@freezed
class GoogleWalletPassProperty with _$GoogleWalletPassProperty {
  factory GoogleWalletPassProperty({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'header') required String header,
    @JsonKey(name: 'body') required String body,
  }) = _GoogleWalletPassProperty;

  factory GoogleWalletPassProperty.fromJson(Map<String, dynamic> json) =>
      _$GoogleWalletPassPropertyFromJson(json);
}
