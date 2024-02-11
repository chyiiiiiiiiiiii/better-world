// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LevelInfo _$LevelInfoFromJson(Map<String, dynamic> json) {
  return _LevelInfo.fromJson(json);
}

/// @nodoc
mixin _$LevelInfo {
  @JsonKey(name: 'level')
  int get level => throw _privateConstructorUsedError;
  @JsonKey(name: 'earth_image_url')
  String get earthImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'pass_score')
  int get passScore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LevelInfoCopyWith<LevelInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelInfoCopyWith<$Res> {
  factory $LevelInfoCopyWith(LevelInfo value, $Res Function(LevelInfo) then) =
      _$LevelInfoCopyWithImpl<$Res, LevelInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'level') int level,
      @JsonKey(name: 'earth_image_url') String earthImageUrl,
      @JsonKey(name: 'pass_score') int passScore});
}

/// @nodoc
class _$LevelInfoCopyWithImpl<$Res, $Val extends LevelInfo>
    implements $LevelInfoCopyWith<$Res> {
  _$LevelInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? earthImageUrl = null,
    Object? passScore = null,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      earthImageUrl: null == earthImageUrl
          ? _value.earthImageUrl
          : earthImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      passScore: null == passScore
          ? _value.passScore
          : passScore // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LevelInfoImplCopyWith<$Res>
    implements $LevelInfoCopyWith<$Res> {
  factory _$$LevelInfoImplCopyWith(
          _$LevelInfoImpl value, $Res Function(_$LevelInfoImpl) then) =
      __$$LevelInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'level') int level,
      @JsonKey(name: 'earth_image_url') String earthImageUrl,
      @JsonKey(name: 'pass_score') int passScore});
}

/// @nodoc
class __$$LevelInfoImplCopyWithImpl<$Res>
    extends _$LevelInfoCopyWithImpl<$Res, _$LevelInfoImpl>
    implements _$$LevelInfoImplCopyWith<$Res> {
  __$$LevelInfoImplCopyWithImpl(
      _$LevelInfoImpl _value, $Res Function(_$LevelInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? earthImageUrl = null,
    Object? passScore = null,
  }) {
    return _then(_$LevelInfoImpl(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      earthImageUrl: null == earthImageUrl
          ? _value.earthImageUrl
          : earthImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      passScore: null == passScore
          ? _value.passScore
          : passScore // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelInfoImpl implements _LevelInfo {
  _$LevelInfoImpl(
      {@JsonKey(name: 'level') required this.level,
      @JsonKey(name: 'earth_image_url') required this.earthImageUrl,
      @JsonKey(name: 'pass_score') required this.passScore});

  factory _$LevelInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelInfoImplFromJson(json);

  @override
  @JsonKey(name: 'level')
  final int level;
  @override
  @JsonKey(name: 'earth_image_url')
  final String earthImageUrl;
  @override
  @JsonKey(name: 'pass_score')
  final int passScore;

  @override
  String toString() {
    return 'LevelInfo(level: $level, earthImageUrl: $earthImageUrl, passScore: $passScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelInfoImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.earthImageUrl, earthImageUrl) ||
                other.earthImageUrl == earthImageUrl) &&
            (identical(other.passScore, passScore) ||
                other.passScore == passScore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, level, earthImageUrl, passScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelInfoImplCopyWith<_$LevelInfoImpl> get copyWith =>
      __$$LevelInfoImplCopyWithImpl<_$LevelInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelInfoImplToJson(
      this,
    );
  }
}

abstract class _LevelInfo implements LevelInfo {
  factory _LevelInfo(
          {@JsonKey(name: 'level') required final int level,
          @JsonKey(name: 'earth_image_url') required final String earthImageUrl,
          @JsonKey(name: 'pass_score') required final int passScore}) =
      _$LevelInfoImpl;

  factory _LevelInfo.fromJson(Map<String, dynamic> json) =
      _$LevelInfoImpl.fromJson;

  @override
  @JsonKey(name: 'level')
  int get level;
  @override
  @JsonKey(name: 'earth_image_url')
  String get earthImageUrl;
  @override
  @JsonKey(name: 'pass_score')
  int get passScore;
  @override
  @JsonKey(ignore: true)
  _$$LevelInfoImplCopyWith<_$LevelInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
