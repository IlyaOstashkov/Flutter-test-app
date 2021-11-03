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

  ArtObjectDetailPartialContentEvent initialLoad(ArtObject artObject) {
    return ArtObjectDetailPartialContentEvent(
      artObject,
    );
  }
}

/// @nodoc
const $ArtObjectDetailEvent = _$ArtObjectDetailEventTearOff();

/// @nodoc
mixin _$ArtObjectDetailEvent {
  ArtObject get artObject => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ArtObject artObject) initialLoad,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ArtObject artObject)? initialLoad,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ArtObject artObject)? initialLoad,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArtObjectDetailPartialContentEvent value)
        initialLoad,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ArtObjectDetailPartialContentEvent value)? initialLoad,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArtObjectDetailPartialContentEvent value)? initialLoad,
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
  $Res call({ArtObject artObject});
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
    Object? artObject = freezed,
  }) {
    return _then(_value.copyWith(
      artObject: artObject == freezed
          ? _value.artObject
          : artObject // ignore: cast_nullable_to_non_nullable
              as ArtObject,
    ));
  }
}

/// @nodoc
abstract class $ArtObjectDetailPartialContentEventCopyWith<$Res>
    implements $ArtObjectDetailEventCopyWith<$Res> {
  factory $ArtObjectDetailPartialContentEventCopyWith(
          ArtObjectDetailPartialContentEvent value,
          $Res Function(ArtObjectDetailPartialContentEvent) then) =
      _$ArtObjectDetailPartialContentEventCopyWithImpl<$Res>;
  @override
  $Res call({ArtObject artObject});
}

/// @nodoc
class _$ArtObjectDetailPartialContentEventCopyWithImpl<$Res>
    extends _$ArtObjectDetailEventCopyWithImpl<$Res>
    implements $ArtObjectDetailPartialContentEventCopyWith<$Res> {
  _$ArtObjectDetailPartialContentEventCopyWithImpl(
      ArtObjectDetailPartialContentEvent _value,
      $Res Function(ArtObjectDetailPartialContentEvent) _then)
      : super(_value, (v) => _then(v as ArtObjectDetailPartialContentEvent));

  @override
  ArtObjectDetailPartialContentEvent get _value =>
      super._value as ArtObjectDetailPartialContentEvent;

  @override
  $Res call({
    Object? artObject = freezed,
  }) {
    return _then(ArtObjectDetailPartialContentEvent(
      artObject == freezed
          ? _value.artObject
          : artObject // ignore: cast_nullable_to_non_nullable
              as ArtObject,
    ));
  }
}

/// @nodoc

class _$ArtObjectDetailPartialContentEvent
    implements ArtObjectDetailPartialContentEvent {
  const _$ArtObjectDetailPartialContentEvent(this.artObject);

  @override
  final ArtObject artObject;

  @override
  String toString() {
    return 'ArtObjectDetailEvent.initialLoad(artObject: $artObject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArtObjectDetailPartialContentEvent &&
            (identical(other.artObject, artObject) ||
                const DeepCollectionEquality()
                    .equals(other.artObject, artObject)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(artObject);

  @JsonKey(ignore: true)
  @override
  $ArtObjectDetailPartialContentEventCopyWith<
          ArtObjectDetailPartialContentEvent>
      get copyWith => _$ArtObjectDetailPartialContentEventCopyWithImpl<
          ArtObjectDetailPartialContentEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ArtObject artObject) initialLoad,
  }) {
    return initialLoad(artObject);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ArtObject artObject)? initialLoad,
  }) {
    return initialLoad?.call(artObject);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ArtObject artObject)? initialLoad,
    required TResult orElse(),
  }) {
    if (initialLoad != null) {
      return initialLoad(artObject);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArtObjectDetailPartialContentEvent value)
        initialLoad,
  }) {
    return initialLoad(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ArtObjectDetailPartialContentEvent value)? initialLoad,
  }) {
    return initialLoad?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArtObjectDetailPartialContentEvent value)? initialLoad,
    required TResult orElse(),
  }) {
    if (initialLoad != null) {
      return initialLoad(this);
    }
    return orElse();
  }
}

abstract class ArtObjectDetailPartialContentEvent
    implements ArtObjectDetailEvent {
  const factory ArtObjectDetailPartialContentEvent(ArtObject artObject) =
      _$ArtObjectDetailPartialContentEvent;

  @override
  ArtObject get artObject => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ArtObjectDetailPartialContentEventCopyWith<
          ArtObjectDetailPartialContentEvent>
      get copyWith => throw _privateConstructorUsedError;
}
