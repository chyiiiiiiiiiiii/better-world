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
  Widget getIcon({double size = 44}) {
    switch (id) {
      case 'tree':
        return Icon(
          Icons.forest_rounded,
          size: size,
          color: Colors.green,
        );
      case 'sunny':
        return Icon(
          Icons.wb_sunny_rounded,
          size: size,
          color: Colors.orange,
        );
      case 'windy':
        return Icon(
          Icons.wind_power_rounded,
          size: size,
          color: Colors.lightBlue,
        );
    }
    return Icon(
      Icons.wind_power_rounded,
      size: size,
    );
  }
}
