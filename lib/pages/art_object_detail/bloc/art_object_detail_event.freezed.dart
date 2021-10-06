// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'art_object_detail_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ArtObjectDetailEventTearOff {
  const _$ArtObjectDetailEventTearOff();

  ArtObjectDetailEventFetchFullContent fetchFullContent(String objectNumber) {
    return ArtObjectDetailEventFetchFullContent(
      objectNumber,
    );
  }
}

/// @nodoc
const $ArtObjectDetailEvent = _$ArtObjectDetailEventTearOff();

/// @nodoc
mixin _$ArtObjectDetailEvent {
  String get objectNumber => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String objectNumber) fetchFullContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String objectNumber)? fetchFullContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String objectNumber)? fetchFullContent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArtObjectDetailEventFetchFullContent value)
        fetchFullContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ArtObjectDetailEventFetchFullContent value)?
        fetchFullContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArtObjectDetailEventFetchFullContent value)?
        fetchFullContent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArtObjectDetailEventCopyWith<ArtObjectDetailEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtObjectDetailEventCopyWith<$Res> {
  factory $ArtObjectDetailEventCopyWith(ArtObjectDetailEvent value,
          $Res Function(ArtObjectDetailEvent) then) =
      _$ArtObjectDetailEventCopyWithImpl<$Res>;
  $Res call({String objectNumber});
}

/// @nodoc
class _$ArtObjectDetailEventCopyWithImpl<$Res>
    implements $ArtObjectDetailEventCopyWith<$Res> {
  _$ArtObjectDetailEventCopyWithImpl(this._value, this._then);

  final ArtObjectDetailEvent _value;
  // ignore: unused_field
  final $Res Function(ArtObjectDetailEvent) _then;

  @override
  $Res call({
    Object? objectNumber = freezed,
  }) {
    return _then(_value.copyWith(
      objectNumber: objectNumber == freezed
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $ArtObjectDetailEventFetchFullContentCopyWith<$Res>
    implements $ArtObjectDetailEventCopyWith<$Res> {
  factory $ArtObjectDetailEventFetchFullContentCopyWith(
          ArtObjectDetailEventFetchFullContent value,
          $Res Function(ArtObjectDetailEventFetchFullContent) then) =
      _$ArtObjectDetailEventFetchFullContentCopyWithImpl<$Res>;
  @override
  $Res call({String objectNumber});
}

/// @nodoc
class _$ArtObjectDetailEventFetchFullContentCopyWithImpl<$Res>
    extends _$ArtObjectDetailEventCopyWithImpl<$Res>
    implements $ArtObjectDetailEventFetchFullContentCopyWith<$Res> {
  _$ArtObjectDetailEventFetchFullContentCopyWithImpl(
      ArtObjectDetailEventFetchFullContent _value,
      $Res Function(ArtObjectDetailEventFetchFullContent) _then)
      : super(_value, (v) => _then(v as ArtObjectDetailEventFetchFullContent));

  @override
  ArtObjectDetailEventFetchFullContent get _value =>
      super._value as ArtObjectDetailEventFetchFullContent;

  @override
  $Res call({
    Object? objectNumber = freezed,
  }) {
    return _then(ArtObjectDetailEventFetchFullContent(
      objectNumber == freezed
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ArtObjectDetailEventFetchFullContent
    implements ArtObjectDetailEventFetchFullContent {
  const _$ArtObjectDetailEventFetchFullContent(this.objectNumber);

  @override
  final String objectNumber;

  @override
  String toString() {
    return 'ArtObjectDetailEvent.fetchFullContent(objectNumber: $objectNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArtObjectDetailEventFetchFullContent &&
            (identical(other.objectNumber, objectNumber) ||
                const DeepCollectionEquality()
                    .equals(other.objectNumber, objectNumber)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(objectNumber);

  @JsonKey(ignore: true)
  @override
  $ArtObjectDetailEventFetchFullContentCopyWith<
          ArtObjectDetailEventFetchFullContent>
      get copyWith => _$ArtObjectDetailEventFetchFullContentCopyWithImpl<
          ArtObjectDetailEventFetchFullContent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String objectNumber) fetchFullContent,
  }) {
    return fetchFullContent(objectNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String objectNumber)? fetchFullContent,
  }) {
    return fetchFullContent?.call(objectNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String objectNumber)? fetchFullContent,
    required TResult orElse(),
  }) {
    if (fetchFullContent != null) {
      return fetchFullContent(objectNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArtObjectDetailEventFetchFullContent value)
        fetchFullContent,
  }) {
    return fetchFullContent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ArtObjectDetailEventFetchFullContent value)?
        fetchFullContent,
  }) {
    return fetchFullContent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArtObjectDetailEventFetchFullContent value)?
        fetchFullContent,
    required TResult orElse(),
  }) {
    if (fetchFullContent != null) {
      return fetchFullContent(this);
    }
    return orElse();
  }
}

abstract class ArtObjectDetailEventFetchFullContent
    implements ArtObjectDetailEvent {
  const factory ArtObjectDetailEventFetchFullContent(String objectNumber) =
      _$ArtObjectDetailEventFetchFullContent;

  @override
  String get objectNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ArtObjectDetailEventFetchFullContentCopyWith<
          ArtObjectDetailEventFetchFullContent>
      get copyWith => throw _privateConstructorUsedError;
}
