// coverage:ignore-file
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app_domain/test_app_domain.dart';

part 'navigation_stack_item.freezed.dart';

@freezed
class NavigationStackItem with _$NavigationStackItem {
  const factory NavigationStackItem.notFound(
      {required List<String> pathSegments}) = NavigationStackItemNotFound;
  const factory NavigationStackItem.artObjectList() =
      NavigationStackItemArtObjectList;
  const factory NavigationStackItem.artObjectDetail(
      {required ArtObject artObject}) = NavigationStackItemArtObjectDetail;
  const factory NavigationStackItem.fullScreenImage(
      {required List<String> imageUrls}) = NavigationStackItemFullScreenImage;
}
