import 'package:flutter_test_app/navigation/navigation_stack_item.dart';
import 'package:test/test.dart';
import 'package:test_app_blocs/test_app_blocs.dart';

void main() {
  const artObjectListSegment = 'artObjectList';

  group('NavigationStackItem -', () {
    test('artObjectList works correctly', () async {
      const artObjectListStackItem = NavigationStackItem.artObjectList();
      expect(artObjectListStackItem, isNotNull);
      expect(
        artObjectListStackItem,
        isA<NavigationStackItemArtObjectList>(),
      );
    });

    test('artObjectDetail works correctly', () async {
      final fullContentArtObject =
          ArtObjectDetailBlocTestData.artObjectFullContent();
      final artObjectDetailStackItem =
          NavigationStackItem.artObjectDetail(artObject: fullContentArtObject);
      expect(artObjectDetailStackItem, isNotNull);
      expect(
        artObjectDetailStackItem,
        isA<NavigationStackItemArtObjectDetail>(),
      );
    });

    test('fullScreenImage works correctly', () async {
      const someImageUrl = 'some-image-url';
      const fullScreenStackItem =
          NavigationStackItem.fullScreenImage(imageUrls: [someImageUrl]);
      expect(fullScreenStackItem, isNotNull);
      expect(
        fullScreenStackItem,
        isA<NavigationStackItemFullScreenImage>(),
      );
    });

    test('notFound works correctly', () async {
      const notFoundStackItem =
          NavigationStackItem.notFound(pathSegments: [artObjectListSegment]);
      expect(notFoundStackItem, isNotNull);
      expect(
        notFoundStackItem,
        isA<NavigationStackItemNotFound>(),
      );
    });
  });
}
