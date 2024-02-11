// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlayInfo _$PlayInfoFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$PlayInfo {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_level')
  int get currentLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_score')
  int get currentScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_score')
  int get totalScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_click_score')
  int get perClickScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_game_completed')
  bool get isGameCompleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayInfoCopyWith<PlayInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayInfoCopyWith<$Res> {
  factory $PlayInfoCopyWith(PlayInfo value, $Res Function(PlayInfo) then) =
      _$PlayInfoCopyWithImpl<$Res, PlayInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'current_level') int currentLevel,
      @JsonKey(name: 'current_score') int currentScore,
      @JsonKey(name: 'total_score') int totalScore,
      @JsonKey(name: 'per_click_score') int perClickScore,
      @JsonKey(name: 'is_game_completed') bool isGameCompleted});
}

/// @nodoc
class _$PlayInfoCopyWithImpl<$Res, $Val extends PlayInfo>
    implements $PlayInfoCopyWith<$Res> {
  _$PlayInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentLevel = null,
    Object? currentScore = null,
    Object? totalScore = null,
    Object? perClickScore = null,
    Object? isGameCompleted = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      currentScore: null == currentScore
          ? _value.currentScore
          : currentScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      perClickScore: null == perClickScore
          ? _value.perClickScore
          : perClickScore // ignore: cast_nullable_to_non_nullable
              as int,
      isGameCompleted: null == isGameCompleted
          ? _value.isGameCompleted
          : isGameCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $PlayInfoCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'current_level') int currentLevel,
      @JsonKey(name: 'current_score') int currentScore,
      @JsonKey(name: 'total_score') int totalScore,
      @JsonKey(name: 'per_click_score') int perClickScore,
      @JsonKey(name: 'is_game_completed') bool isGameCompleted});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$PlayInfoCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentLevel = null,
    Object? currentScore = null,
    Object? totalScore = null,
    Object? perClickScore = null,
    Object? isGameCompleted = null,
  }) {
    return _then(_$UserImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      currentScore: null == currentScore
          ? _value.currentScore
          : currentScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      perClickScore: null == perClickScore
          ? _value.perClickScore
          : perClickScore // ignore: cast_nullable_to_non_nullable
              as int,
      isGameCompleted: null == isGameCompleted
          ? _value.isGameCompleted
          : isGameCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  _$UserImpl(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'current_level') this.currentLevel = 1,
      @JsonKey(name: 'current_score') this.currentScore = 0,
      @JsonKey(name: 'total_score') this.totalScore = 0,
      @JsonKey(name: 'per_click_score') this.perClickScore = 1,
      @JsonKey(name: 'is_game_completed') this.isGameCompleted = false});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'current_level')
  final int currentLevel;
  @override
  @JsonKey(name: 'current_score')
  final int currentScore;
  @override
  @JsonKey(name: 'total_score')
  final int totalScore;
  @override
  @JsonKey(name: 'per_click_score')
  final int perClickScore;
  @override
  @JsonKey(name: 'is_game_completed')
  final bool isGameCompleted;

  @override
  String toString() {
    return 'PlayInfo(userId: $userId, currentLevel: $currentLevel, currentScore: $currentScore, totalScore: $totalScore, perClickScore: $perClickScore, isGameCompleted: $isGameCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.currentScore, currentScore) ||
                other.currentScore == currentScore) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.perClickScore, perClickScore) ||
                other.perClickScore == perClickScore) &&
            (identical(other.isGameCompleted, isGameCompleted) ||
                other.isGameCompleted == isGameCompleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, currentLevel,
      currentScore, totalScore, perClickScore, isGameCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements PlayInfo {
  factory _User(
          {@JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'current_level') final int currentLevel,
          @JsonKey(name: 'current_score') final int currentScore,
          @JsonKey(name: 'total_score') final int totalScore,
          @JsonKey(name: 'per_click_score') final int perClickScore,
          @JsonKey(name: 'is_game_completed') final bool isGameCompleted}) =
      _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'current_level')
  int get currentLevel;
  @override
  @JsonKey(name: 'current_score')
  int get currentScore;
  @override
  @JsonKey(name: 'total_score')
  int get totalScore;
  @override
  @JsonKey(name: 'per_click_score')
  int get perClickScore;
  @override
  @JsonKey(name: 'is_game_completed')
  bool get isGameCompleted;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
