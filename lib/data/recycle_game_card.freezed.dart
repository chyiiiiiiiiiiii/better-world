// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recycle_game_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecycleGameCard _$RecycleGameCardFromJson(Map<String, dynamic> json) {
  return _RecycleGameCard.fromJson(json);
}

/// @nodoc
mixin _$RecycleGameCard {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String get nameEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ja')
  String get nameJa => throw _privateConstructorUsedError;
  @JsonKey(name: 'recyclable_value')
  int get recyclableValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecycleGameCardCopyWith<RecycleGameCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecycleGameCardCopyWith<$Res> {
  factory $RecycleGameCardCopyWith(
          RecycleGameCard value, $Res Function(RecycleGameCard) then) =
      _$RecycleGameCardCopyWithImpl<$Res, RecycleGameCard>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'name_en') String nameEn,
      @JsonKey(name: 'name_ja') String nameJa,
      @JsonKey(name: 'recyclable_value') int recyclableValue,
      @JsonKey(name: 'image_url') String imageUrl});
}

/// @nodoc
class _$RecycleGameCardCopyWithImpl<$Res, $Val extends RecycleGameCard>
    implements $RecycleGameCardCopyWith<$Res> {
  _$RecycleGameCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameEn = null,
    Object? nameJa = null,
    Object? recyclableValue = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      nameJa: null == nameJa
          ? _value.nameJa
          : nameJa // ignore: cast_nullable_to_non_nullable
              as String,
      recyclableValue: null == recyclableValue
          ? _value.recyclableValue
          : recyclableValue // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecycleGameCardImplCopyWith<$Res>
    implements $RecycleGameCardCopyWith<$Res> {
  factory _$$RecycleGameCardImplCopyWith(_$RecycleGameCardImpl value,
          $Res Function(_$RecycleGameCardImpl) then) =
      __$$RecycleGameCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'name_en') String nameEn,
      @JsonKey(name: 'name_ja') String nameJa,
      @JsonKey(name: 'recyclable_value') int recyclableValue,
      @JsonKey(name: 'image_url') String imageUrl});
}

/// @nodoc
class __$$RecycleGameCardImplCopyWithImpl<$Res>
    extends _$RecycleGameCardCopyWithImpl<$Res, _$RecycleGameCardImpl>
    implements _$$RecycleGameCardImplCopyWith<$Res> {
  __$$RecycleGameCardImplCopyWithImpl(
      _$RecycleGameCardImpl _value, $Res Function(_$RecycleGameCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? nameEn = null,
    Object? nameJa = null,
    Object? recyclableValue = null,
    Object? imageUrl = null,
  }) {
    return _then(_$RecycleGameCardImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      nameJa: null == nameJa
          ? _value.nameJa
          : nameJa // ignore: cast_nullable_to_non_nullable
              as String,
      recyclableValue: null == recyclableValue
          ? _value.recyclableValue
          : recyclableValue // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecycleGameCardImpl implements _RecycleGameCard {
  _$RecycleGameCardImpl(
      {this.name = '',
      @JsonKey(name: 'name_en') this.nameEn = '',
      @JsonKey(name: 'name_ja') this.nameJa = '',
      @JsonKey(name: 'recyclable_value') this.recyclableValue = 0,
      @JsonKey(name: 'image_url') this.imageUrl = ''});

  factory _$RecycleGameCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecycleGameCardImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(name: 'name_en')
  final String nameEn;
  @override
  @JsonKey(name: 'name_ja')
  final String nameJa;
  @override
  @JsonKey(name: 'recyclable_value')
  final int recyclableValue;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;

  @override
  String toString() {
    return 'RecycleGameCard(name: $name, nameEn: $nameEn, nameJa: $nameJa, recyclableValue: $recyclableValue, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecycleGameCardImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.nameJa, nameJa) || other.nameJa == nameJa) &&
            (identical(other.recyclableValue, recyclableValue) ||
                other.recyclableValue == recyclableValue) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, nameEn, nameJa, recyclableValue, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecycleGameCardImplCopyWith<_$RecycleGameCardImpl> get copyWith =>
      __$$RecycleGameCardImplCopyWithImpl<_$RecycleGameCardImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecycleGameCardImplToJson(
      this,
    );
  }
}

abstract class _RecycleGameCard implements RecycleGameCard {
  factory _RecycleGameCard(
          {final String name,
          @JsonKey(name: 'name_en') final String nameEn,
          @JsonKey(name: 'name_ja') final String nameJa,
          @JsonKey(name: 'recyclable_value') final int recyclableValue,
          @JsonKey(name: 'image_url') final String imageUrl}) =
      _$RecycleGameCardImpl;

  factory _RecycleGameCard.fromJson(Map<String, dynamic> json) =
      _$RecycleGameCardImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'name_en')
  String get nameEn;
  @override
  @JsonKey(name: 'name_ja')
  String get nameJa;
  @override
  @JsonKey(name: 'recyclable_value')
  int get recyclableValue;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$RecycleGameCardImplCopyWith<_$RecycleGameCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
