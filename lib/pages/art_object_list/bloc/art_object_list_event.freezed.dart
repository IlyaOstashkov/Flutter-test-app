// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'art_object_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ArtObjectListEventTearOff {
  const _$ArtObjectListEventTearOff();

  ArtObjectListFetchedEvent fetched() {
    return const ArtObjectListFetchedEvent();
  }

  ArtObjectListFullReloadEvent fullReload() {
    return const ArtObjectListFullReloadEvent();
  }
}

/// @nodoc
const $ArtObjectListEvent = _$ArtObjectListEventTearOff();

/// @nodoc
mixin _$ArtObjectListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() fullReload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? fullReload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? fullReload,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArtObjectListFetchedEvent value) fetched,
    required TResult Function(ArtObjectListFullReloadEvent value) fullReload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ArtObjectListFetchedEvent value)? fetched,
    TResult Function(ArtObjectListFullReloadEvent value)? fullReload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArtObjectListFetchedEvent value)? fetched,
    TResult Function(ArtObjectListFullReloadEvent value)? fullReload,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtObjectListEventCopyWith<$Res> {
  factory $ArtObjectListEventCopyWith(
          ArtObjectListEvent value, $Res Function(ArtObjectListEvent) then) =
      _$ArtObjectListEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ArtObjectListEventCopyWithImpl<$Res>
    implements $ArtObjectListEventCopyWith<$Res> {
  _$ArtObjectListEventCopyWithImpl(this._value, this._then);

  final ArtObjectListEvent _value;
  // ignore: unused_field
  final $Res Function(ArtObjectListEvent) _then;
}

/// @nodoc
abstract class $ArtObjectListFetchedEventCopyWith<$Res> {
  factory $ArtObjectListFetchedEventCopyWith(ArtObjectListFetchedEvent value,
          $Res Function(ArtObjectListFetchedEvent) then) =
      _$ArtObjectListFetchedEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ArtObjectListFetchedEventCopyWithImpl<$Res>
    extends _$ArtObjectListEventCopyWithImpl<$Res>
    implements $ArtObjectListFetchedEventCopyWith<$Res> {
  _$ArtObjectListFetchedEventCopyWithImpl(ArtObjectListFetchedEvent _value,
      $Res Function(ArtObjectListFetchedEvent) _then)
      : super(_value, (v) => _then(v as ArtObjectListFetchedEvent));

  @override
  ArtObjectListFetchedEvent get _value =>
      super._value as ArtObjectListFetchedEvent;
}

/// @nodoc

class _$ArtObjectListFetchedEvent implements ArtObjectListFetchedEvent {
  const _$ArtObjectListFetchedEvent();

  @override
  String toString() {
    return 'ArtObjectListEvent.fetched()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ArtObjectListFetchedEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() fullReload,
  }) {
    return fetched();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? fullReload,
  }) {
    return fetched?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? fullReload,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArtObjectListFetchedEvent value) fetched,
    required TResult Function(ArtObjectListFullReloadEvent value) fullReload,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ArtObjectListFetchedEvent value)? fetched,
    TResult Function(ArtObjectListFullReloadEvent value)? fullReload,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArtObjectListFetchedEvent value)? fetched,
    TResult Function(ArtObjectListFullReloadEvent value)? fullReload,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class ArtObjectListFetchedEvent implements ArtObjectListEvent {
  const factory ArtObjectListFetchedEvent() = _$ArtObjectListFetchedEvent;
}

/// @nodoc
abstract class $ArtObjectListFullReloadEventCopyWith<$Res> {
  factory $ArtObjectListFullReloadEventCopyWith(
          ArtObjectListFullReloadEvent value,
          $Res Function(ArtObjectListFullReloadEvent) then) =
      _$ArtObjectListFullReloadEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ArtObjectListFullReloadEventCopyWithImpl<$Res>
    extends _$ArtObjectListEventCopyWithImpl<$Res>
    implements $ArtObjectListFullReloadEventCopyWith<$Res> {
  _$ArtObjectListFullReloadEventCopyWithImpl(
      ArtObjectListFullReloadEvent _value,
      $Res Function(ArtObjectListFullReloadEvent) _then)
      : super(_value, (v) => _then(v as ArtObjectListFullReloadEvent));

  @override
  ArtObjectListFullReloadEvent get _value =>
      super._value as ArtObjectListFullReloadEvent;
}

/// @nodoc

class _$ArtObjectListFullReloadEvent implements ArtObjectListFullReloadEvent {
  const _$ArtObjectListFullReloadEvent();

  @override
  String toString() {
    return 'ArtObjectListEvent.fullReload()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ArtObjectListFullReloadEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() fullReload,
  }) {
    return fullReload();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? fullReload,
  }) {
    return fullReload?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? fullReload,
    required TResult orElse(),
  }) {
    if (fullReload != null) {
      return fullReload();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArtObjectListFetchedEvent value) fetched,
    required TResult Function(ArtObjectListFullReloadEvent value) fullReload,
  }) {
    return fullReload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ArtObjectListFetchedEvent value)? fetched,
    TResult Function(ArtObjectListFullReloadEvent value)? fullReload,
  }) {
    return fullReload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArtObjectListFetchedEvent value)? fetched,
    TResult Function(ArtObjectListFullReloadEvent value)? fullReload,
    required TResult orElse(),
  }) {
    if (fullReload != null) {
      return fullReload(this);
    }
    return orElse();
  }
}

abstract class ArtObjectListFullReloadEvent implements ArtObjectListEvent {
  const factory ArtObjectListFullReloadEvent() = _$ArtObjectListFullReloadEvent;
}
