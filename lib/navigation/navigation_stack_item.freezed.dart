// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'navigation_stack_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NavigationStackItemTearOff {
  const _$NavigationStackItemTearOff();

  NavigationStackItemNotFound notFound({required List<String> pathSegments}) {
    return NavigationStackItemNotFound(
      pathSegments: pathSegments,
    );
  }

  NavigationStackItemArtObjectList artObjectList() {
    return const NavigationStackItemArtObjectList();
  }

  NavigationStackItemArtObjectDetail artObjectDetail(
      {required ArtObject artObject}) {
    return NavigationStackItemArtObjectDetail(
      artObject: artObject,
    );
  }

  NavigationStackItemFullScreenImage fullScreenImage(
      {required List<String> imageUrls}) {
    return NavigationStackItemFullScreenImage(
      imageUrls: imageUrls,
    );
  }
}

/// @nodoc
const $NavigationStackItem = _$NavigationStackItemTearOff();

/// @nodoc
mixin _$NavigationStackItem {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> pathSegments) notFound,
    required TResult Function() artObjectList,
    required TResult Function(ArtObject artObject) artObjectDetail,
    required TResult Function(List<String> imageUrls) fullScreenImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NavigationStackItemNotFound value) notFound,
    required TResult Function(NavigationStackItemArtObjectList value)
        artObjectList,
    required TResult Function(NavigationStackItemArtObjectDetail value)
        artObjectDetail,
    required TResult Function(NavigationStackItemFullScreenImage value)
        fullScreenImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationStackItemCopyWith<$Res> {
  factory $NavigationStackItemCopyWith(
          NavigationStackItem value, $Res Function(NavigationStackItem) then) =
      _$NavigationStackItemCopyWithImpl<$Res>;
}

/// @nodoc
class _$NavigationStackItemCopyWithImpl<$Res>
    implements $NavigationStackItemCopyWith<$Res> {
  _$NavigationStackItemCopyWithImpl(this._value, this._then);

  final NavigationStackItem _value;
  // ignore: unused_field
  final $Res Function(NavigationStackItem) _then;
}

/// @nodoc
abstract class $NavigationStackItemNotFoundCopyWith<$Res> {
  factory $NavigationStackItemNotFoundCopyWith(
          NavigationStackItemNotFound value,
          $Res Function(NavigationStackItemNotFound) then) =
      _$NavigationStackItemNotFoundCopyWithImpl<$Res>;
  $Res call({List<String> pathSegments});
}

/// @nodoc
class _$NavigationStackItemNotFoundCopyWithImpl<$Res>
    extends _$NavigationStackItemCopyWithImpl<$Res>
    implements $NavigationStackItemNotFoundCopyWith<$Res> {
  _$NavigationStackItemNotFoundCopyWithImpl(NavigationStackItemNotFound _value,
      $Res Function(NavigationStackItemNotFound) _then)
      : super(_value, (v) => _then(v as NavigationStackItemNotFound));

  @override
  NavigationStackItemNotFound get _value =>
      super._value as NavigationStackItemNotFound;

  @override
  $Res call({
    Object? pathSegments = freezed,
  }) {
    return _then(NavigationStackItemNotFound(
      pathSegments: pathSegments == freezed
          ? _value.pathSegments
          : pathSegments // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$NavigationStackItemNotFound implements NavigationStackItemNotFound {
  const _$NavigationStackItemNotFound({required this.pathSegments});

  @override
  final List<String> pathSegments;

  @override
  String toString() {
    return 'NavigationStackItem.notFound(pathSegments: $pathSegments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NavigationStackItemNotFound &&
            (identical(other.pathSegments, pathSegments) ||
                const DeepCollectionEquality()
                    .equals(other.pathSegments, pathSegments)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(pathSegments);

  @JsonKey(ignore: true)
  @override
  $NavigationStackItemNotFoundCopyWith<NavigationStackItemNotFound>
      get copyWith => _$NavigationStackItemNotFoundCopyWithImpl<
          NavigationStackItemNotFound>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> pathSegments) notFound,
    required TResult Function() artObjectList,
    required TResult Function(ArtObject artObject) artObjectDetail,
    required TResult Function(List<String> imageUrls) fullScreenImage,
  }) {
    return notFound(pathSegments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
  }) {
    return notFound?.call(pathSegments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(pathSegments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NavigationStackItemNotFound value) notFound,
    required TResult Function(NavigationStackItemArtObjectList value)
        artObjectList,
    required TResult Function(NavigationStackItemArtObjectDetail value)
        artObjectDetail,
    required TResult Function(NavigationStackItemFullScreenImage value)
        fullScreenImage,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NavigationStackItemNotFound implements NavigationStackItem {
  const factory NavigationStackItemNotFound(
      {required List<String> pathSegments}) = _$NavigationStackItemNotFound;

  List<String> get pathSegments => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NavigationStackItemNotFoundCopyWith<NavigationStackItemNotFound>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationStackItemArtObjectListCopyWith<$Res> {
  factory $NavigationStackItemArtObjectListCopyWith(
          NavigationStackItemArtObjectList value,
          $Res Function(NavigationStackItemArtObjectList) then) =
      _$NavigationStackItemArtObjectListCopyWithImpl<$Res>;
}

/// @nodoc
class _$NavigationStackItemArtObjectListCopyWithImpl<$Res>
    extends _$NavigationStackItemCopyWithImpl<$Res>
    implements $NavigationStackItemArtObjectListCopyWith<$Res> {
  _$NavigationStackItemArtObjectListCopyWithImpl(
      NavigationStackItemArtObjectList _value,
      $Res Function(NavigationStackItemArtObjectList) _then)
      : super(_value, (v) => _then(v as NavigationStackItemArtObjectList));

  @override
  NavigationStackItemArtObjectList get _value =>
      super._value as NavigationStackItemArtObjectList;
}

/// @nodoc

class _$NavigationStackItemArtObjectList
    implements NavigationStackItemArtObjectList {
  const _$NavigationStackItemArtObjectList();

  @override
  String toString() {
    return 'NavigationStackItem.artObjectList()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NavigationStackItemArtObjectList);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> pathSegments) notFound,
    required TResult Function() artObjectList,
    required TResult Function(ArtObject artObject) artObjectDetail,
    required TResult Function(List<String> imageUrls) fullScreenImage,
  }) {
    return artObjectList();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
  }) {
    return artObjectList?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
    required TResult orElse(),
  }) {
    if (artObjectList != null) {
      return artObjectList();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NavigationStackItemNotFound value) notFound,
    required TResult Function(NavigationStackItemArtObjectList value)
        artObjectList,
    required TResult Function(NavigationStackItemArtObjectDetail value)
        artObjectDetail,
    required TResult Function(NavigationStackItemFullScreenImage value)
        fullScreenImage,
  }) {
    return artObjectList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
  }) {
    return artObjectList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
    required TResult orElse(),
  }) {
    if (artObjectList != null) {
      return artObjectList(this);
    }
    return orElse();
  }
}

abstract class NavigationStackItemArtObjectList implements NavigationStackItem {
  const factory NavigationStackItemArtObjectList() =
      _$NavigationStackItemArtObjectList;
}

/// @nodoc
abstract class $NavigationStackItemArtObjectDetailCopyWith<$Res> {
  factory $NavigationStackItemArtObjectDetailCopyWith(
          NavigationStackItemArtObjectDetail value,
          $Res Function(NavigationStackItemArtObjectDetail) then) =
      _$NavigationStackItemArtObjectDetailCopyWithImpl<$Res>;
  $Res call({ArtObject artObject});
}

/// @nodoc
class _$NavigationStackItemArtObjectDetailCopyWithImpl<$Res>
    extends _$NavigationStackItemCopyWithImpl<$Res>
    implements $NavigationStackItemArtObjectDetailCopyWith<$Res> {
  _$NavigationStackItemArtObjectDetailCopyWithImpl(
      NavigationStackItemArtObjectDetail _value,
      $Res Function(NavigationStackItemArtObjectDetail) _then)
      : super(_value, (v) => _then(v as NavigationStackItemArtObjectDetail));

  @override
  NavigationStackItemArtObjectDetail get _value =>
      super._value as NavigationStackItemArtObjectDetail;

  @override
  $Res call({
    Object? artObject = freezed,
  }) {
    return _then(NavigationStackItemArtObjectDetail(
      artObject: artObject == freezed
          ? _value.artObject
          : artObject // ignore: cast_nullable_to_non_nullable
              as ArtObject,
    ));
  }
}

/// @nodoc

class _$NavigationStackItemArtObjectDetail
    implements NavigationStackItemArtObjectDetail {
  const _$NavigationStackItemArtObjectDetail({required this.artObject});

  @override
  final ArtObject artObject;

  @override
  String toString() {
    return 'NavigationStackItem.artObjectDetail(artObject: $artObject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NavigationStackItemArtObjectDetail &&
            (identical(other.artObject, artObject) ||
                const DeepCollectionEquality()
                    .equals(other.artObject, artObject)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(artObject);

  @JsonKey(ignore: true)
  @override
  $NavigationStackItemArtObjectDetailCopyWith<
          NavigationStackItemArtObjectDetail>
      get copyWith => _$NavigationStackItemArtObjectDetailCopyWithImpl<
          NavigationStackItemArtObjectDetail>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> pathSegments) notFound,
    required TResult Function() artObjectList,
    required TResult Function(ArtObject artObject) artObjectDetail,
    required TResult Function(List<String> imageUrls) fullScreenImage,
  }) {
    return artObjectDetail(artObject);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
  }) {
    return artObjectDetail?.call(artObject);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
    required TResult orElse(),
  }) {
    if (artObjectDetail != null) {
      return artObjectDetail(artObject);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NavigationStackItemNotFound value) notFound,
    required TResult Function(NavigationStackItemArtObjectList value)
        artObjectList,
    required TResult Function(NavigationStackItemArtObjectDetail value)
        artObjectDetail,
    required TResult Function(NavigationStackItemFullScreenImage value)
        fullScreenImage,
  }) {
    return artObjectDetail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
  }) {
    return artObjectDetail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
    required TResult orElse(),
  }) {
    if (artObjectDetail != null) {
      return artObjectDetail(this);
    }
    return orElse();
  }
}

abstract class NavigationStackItemArtObjectDetail
    implements NavigationStackItem {
  const factory NavigationStackItemArtObjectDetail(
      {required ArtObject artObject}) = _$NavigationStackItemArtObjectDetail;

  ArtObject get artObject => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NavigationStackItemArtObjectDetailCopyWith<
          NavigationStackItemArtObjectDetail>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationStackItemFullScreenImageCopyWith<$Res> {
  factory $NavigationStackItemFullScreenImageCopyWith(
          NavigationStackItemFullScreenImage value,
          $Res Function(NavigationStackItemFullScreenImage) then) =
      _$NavigationStackItemFullScreenImageCopyWithImpl<$Res>;
  $Res call({List<String> imageUrls});
}

/// @nodoc
class _$NavigationStackItemFullScreenImageCopyWithImpl<$Res>
    extends _$NavigationStackItemCopyWithImpl<$Res>
    implements $NavigationStackItemFullScreenImageCopyWith<$Res> {
  _$NavigationStackItemFullScreenImageCopyWithImpl(
      NavigationStackItemFullScreenImage _value,
      $Res Function(NavigationStackItemFullScreenImage) _then)
      : super(_value, (v) => _then(v as NavigationStackItemFullScreenImage));

  @override
  NavigationStackItemFullScreenImage get _value =>
      super._value as NavigationStackItemFullScreenImage;

  @override
  $Res call({
    Object? imageUrls = freezed,
  }) {
    return _then(NavigationStackItemFullScreenImage(
      imageUrls: imageUrls == freezed
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$NavigationStackItemFullScreenImage
    implements NavigationStackItemFullScreenImage {
  const _$NavigationStackItemFullScreenImage({required this.imageUrls});

  @override
  final List<String> imageUrls;

  @override
  String toString() {
    return 'NavigationStackItem.fullScreenImage(imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NavigationStackItemFullScreenImage &&
            (identical(other.imageUrls, imageUrls) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrls, imageUrls)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(imageUrls);

  @JsonKey(ignore: true)
  @override
  $NavigationStackItemFullScreenImageCopyWith<
          NavigationStackItemFullScreenImage>
      get copyWith => _$NavigationStackItemFullScreenImageCopyWithImpl<
          NavigationStackItemFullScreenImage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> pathSegments) notFound,
    required TResult Function() artObjectList,
    required TResult Function(ArtObject artObject) artObjectDetail,
    required TResult Function(List<String> imageUrls) fullScreenImage,
  }) {
    return fullScreenImage(imageUrls);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
  }) {
    return fullScreenImage?.call(imageUrls);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> pathSegments)? notFound,
    TResult Function()? artObjectList,
    TResult Function(ArtObject artObject)? artObjectDetail,
    TResult Function(List<String> imageUrls)? fullScreenImage,
    required TResult orElse(),
  }) {
    if (fullScreenImage != null) {
      return fullScreenImage(imageUrls);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NavigationStackItemNotFound value) notFound,
    required TResult Function(NavigationStackItemArtObjectList value)
        artObjectList,
    required TResult Function(NavigationStackItemArtObjectDetail value)
        artObjectDetail,
    required TResult Function(NavigationStackItemFullScreenImage value)
        fullScreenImage,
  }) {
    return fullScreenImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
  }) {
    return fullScreenImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NavigationStackItemNotFound value)? notFound,
    TResult Function(NavigationStackItemArtObjectList value)? artObjectList,
    TResult Function(NavigationStackItemArtObjectDetail value)? artObjectDetail,
    TResult Function(NavigationStackItemFullScreenImage value)? fullScreenImage,
    required TResult orElse(),
  }) {
    if (fullScreenImage != null) {
      return fullScreenImage(this);
    }
    return orElse();
  }
}

abstract class NavigationStackItemFullScreenImage
    implements NavigationStackItem {
  const factory NavigationStackItemFullScreenImage(
      {required List<String> imageUrls}) = _$NavigationStackItemFullScreenImage;

  List<String> get imageUrls => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NavigationStackItemFullScreenImageCopyWith<
          NavigationStackItemFullScreenImage>
      get copyWith => throw _privateConstructorUsedError;
}
