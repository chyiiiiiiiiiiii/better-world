// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  PlayInfo get playInfo => throw _privateConstructorUsedError;
  LevelInfo get levelInfo => throw _privateConstructorUsedError;
  List<Product> get products => throw _privateConstructorUsedError;
  List<PurchaseHistory> get validPurchases =>
      throw _privateConstructorUsedError;
  int get levelTotalCount => throw _privateConstructorUsedError;
  double get finishProgress => throw _privateConstructorUsedError;
  List<PlayInfo> get leaderBoardPlayers => throw _privateConstructorUsedError;
  int get clickCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {PlayInfo playInfo,
      LevelInfo levelInfo,
      List<Product> products,
      List<PurchaseHistory> validPurchases,
      int levelTotalCount,
      double finishProgress,
      List<PlayInfo> leaderBoardPlayers,
      int clickCount});

  $PlayInfoCopyWith<$Res> get playInfo;
  $LevelInfoCopyWith<$Res> get levelInfo;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playInfo = null,
    Object? levelInfo = null,
    Object? products = null,
    Object? validPurchases = null,
    Object? levelTotalCount = null,
    Object? finishProgress = null,
    Object? leaderBoardPlayers = null,
    Object? clickCount = null,
  }) {
    return _then(_value.copyWith(
      playInfo: null == playInfo
          ? _value.playInfo
          : playInfo // ignore: cast_nullable_to_non_nullable
              as PlayInfo,
      levelInfo: null == levelInfo
          ? _value.levelInfo
          : levelInfo // ignore: cast_nullable_to_non_nullable
              as LevelInfo,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      validPurchases: null == validPurchases
          ? _value.validPurchases
          : validPurchases // ignore: cast_nullable_to_non_nullable
              as List<PurchaseHistory>,
      levelTotalCount: null == levelTotalCount
          ? _value.levelTotalCount
          : levelTotalCount // ignore: cast_nullable_to_non_nullable
              as int,
      finishProgress: null == finishProgress
          ? _value.finishProgress
          : finishProgress // ignore: cast_nullable_to_non_nullable
              as double,
      leaderBoardPlayers: null == leaderBoardPlayers
          ? _value.leaderBoardPlayers
          : leaderBoardPlayers // ignore: cast_nullable_to_non_nullable
              as List<PlayInfo>,
      clickCount: null == clickCount
          ? _value.clickCount
          : clickCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayInfoCopyWith<$Res> get playInfo {
    return $PlayInfoCopyWith<$Res>(_value.playInfo, (value) {
      return _then(_value.copyWith(playInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LevelInfoCopyWith<$Res> get levelInfo {
    return $LevelInfoCopyWith<$Res>(_value.levelInfo, (value) {
      return _then(_value.copyWith(levelInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PlayInfo playInfo,
      LevelInfo levelInfo,
      List<Product> products,
      List<PurchaseHistory> validPurchases,
      int levelTotalCount,
      double finishProgress,
      List<PlayInfo> leaderBoardPlayers,
      int clickCount});

  @override
  $PlayInfoCopyWith<$Res> get playInfo;
  @override
  $LevelInfoCopyWith<$Res> get levelInfo;
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playInfo = null,
    Object? levelInfo = null,
    Object? products = null,
    Object? validPurchases = null,
    Object? levelTotalCount = null,
    Object? finishProgress = null,
    Object? leaderBoardPlayers = null,
    Object? clickCount = null,
  }) {
    return _then(_$GameStateImpl(
      playInfo: null == playInfo
          ? _value.playInfo
          : playInfo // ignore: cast_nullable_to_non_nullable
              as PlayInfo,
      levelInfo: null == levelInfo
          ? _value.levelInfo
          : levelInfo // ignore: cast_nullable_to_non_nullable
              as LevelInfo,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      validPurchases: null == validPurchases
          ? _value._validPurchases
          : validPurchases // ignore: cast_nullable_to_non_nullable
              as List<PurchaseHistory>,
      levelTotalCount: null == levelTotalCount
          ? _value.levelTotalCount
          : levelTotalCount // ignore: cast_nullable_to_non_nullable
              as int,
      finishProgress: null == finishProgress
          ? _value.finishProgress
          : finishProgress // ignore: cast_nullable_to_non_nullable
              as double,
      leaderBoardPlayers: null == leaderBoardPlayers
          ? _value._leaderBoardPlayers
          : leaderBoardPlayers // ignore: cast_nullable_to_non_nullable
              as List<PlayInfo>,
      clickCount: null == clickCount
          ? _value.clickCount
          : clickCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl implements _GameState {
  _$GameStateImpl(
      {required this.playInfo,
      required this.levelInfo,
      required final List<Product> products,
      required final List<PurchaseHistory> validPurchases,
      required this.levelTotalCount,
      required this.finishProgress,
      required final List<PlayInfo> leaderBoardPlayers,
      this.clickCount = 0})
      : _products = products,
        _validPurchases = validPurchases,
        _leaderBoardPlayers = leaderBoardPlayers;

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  @override
  final PlayInfo playInfo;
  @override
  final LevelInfo levelInfo;
  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<PurchaseHistory> _validPurchases;
  @override
  List<PurchaseHistory> get validPurchases {
    if (_validPurchases is EqualUnmodifiableListView) return _validPurchases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validPurchases);
  }

  @override
  final int levelTotalCount;
  @override
  final double finishProgress;
  final List<PlayInfo> _leaderBoardPlayers;
  @override
  List<PlayInfo> get leaderBoardPlayers {
    if (_leaderBoardPlayers is EqualUnmodifiableListView)
      return _leaderBoardPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leaderBoardPlayers);
  }

  @override
  @JsonKey()
  final int clickCount;

  @override
  String toString() {
    return 'GameState(playInfo: $playInfo, levelInfo: $levelInfo, products: $products, validPurchases: $validPurchases, levelTotalCount: $levelTotalCount, finishProgress: $finishProgress, leaderBoardPlayers: $leaderBoardPlayers, clickCount: $clickCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.playInfo, playInfo) ||
                other.playInfo == playInfo) &&
            (identical(other.levelInfo, levelInfo) ||
                other.levelInfo == levelInfo) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._validPurchases, _validPurchases) &&
            (identical(other.levelTotalCount, levelTotalCount) ||
                other.levelTotalCount == levelTotalCount) &&
            (identical(other.finishProgress, finishProgress) ||
                other.finishProgress == finishProgress) &&
            const DeepCollectionEquality()
                .equals(other._leaderBoardPlayers, _leaderBoardPlayers) &&
            (identical(other.clickCount, clickCount) ||
                other.clickCount == clickCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      playInfo,
      levelInfo,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_validPurchases),
      levelTotalCount,
      finishProgress,
      const DeepCollectionEquality().hash(_leaderBoardPlayers),
      clickCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(
      this,
    );
  }
}

abstract class _GameState implements GameState {
  factory _GameState(
      {required final PlayInfo playInfo,
      required final LevelInfo levelInfo,
      required final List<Product> products,
      required final List<PurchaseHistory> validPurchases,
      required final int levelTotalCount,
      required final double finishProgress,
      required final List<PlayInfo> leaderBoardPlayers,
      final int clickCount}) = _$GameStateImpl;

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  PlayInfo get playInfo;
  @override
  LevelInfo get levelInfo;
  @override
  List<Product> get products;
  @override
  List<PurchaseHistory> get validPurchases;
  @override
  int get levelTotalCount;
  @override
  double get finishProgress;
  @override
  List<PlayInfo> get leaderBoardPlayers;
  @override
  int get clickCount;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
