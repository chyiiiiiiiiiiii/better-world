import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

enum ProductType {
  props,
  species,
}

@freezed
class Product with _$Product {
  factory Product({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'type') required ProductType type,
    @JsonKey(name: 'add_score') required int addScore,
    @JsonKey(name: 'price') required int price,
    @JsonKey(name: 'valid_time_seconds') required int validTimeSeconds,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

extension ProductX on Product {
  String translatedName(AppLocalizations l10n) {
    switch (id) {
      case 'tree':
        return l10n.storeProductTree;
      case 'sunny':
        return l10n.storeProductSolar;
      case 'windy':
        return l10n.storeProductWindy;
    }

    return name;
  }

  Widget getIcon({double size = 44}) {
    switch (id) {
      case 'tree':
        return Image.asset(
          'assets/images/game_icon/tree.png',
          width: size,
        );
      case 'sunny':
        return Image.asset(
          'assets/images/game_icon/sunny.png',
          width: size,
        );
      case 'windy':
        return Image.asset(
          'assets/images/game_icon/windy.png',
          width: size,
        );
    }
    return Icon(
      Icons.wind_power_rounded,
      size: size,
    );
  }
}
