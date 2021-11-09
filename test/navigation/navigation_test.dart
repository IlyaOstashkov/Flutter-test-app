import 'package:flutter_test_app/navigation/app_navigation_stack.dart';
import 'package:flutter_test_app/navigation/navigation_route_information_parser.dart';
import 'package:flutter_test_app/navigation/navigation_stack_item.dart';
import 'package:test/test.dart';
import 'package:test_app_blocs/test_app_blocs.dart';

void main() {
  const artObjectListSegment = 'artObjectList';
  const errorPathSegment = 'errorPathSegment';

  group('AppNavigationStack -', () {
    test('instance is initialized and have items', () async {
      expect(AppNavigationStack.instance, isNotNull);
      expect(AppNavigationStack.instance.items.length, isPositive);
    });
  });

  group('NavigationStackItem -', () {
    test('all type are not null', () async {
      const artObjectListStackItem = NavigationStackItem.artObjectList();
      const someImageUrl = 'some-image-url';
      final fullContentArtObject =
          ArtObjectDetailBlocTestData.artObjectFullContent();
      final artObjectDetailStackItem =
          NavigationStackItem.artObjectDetail(artObject: fullContentArtObject);
      const fullScreenStackItem =
          NavigationStackItem.fullScreenImage(imageUrls: [someImageUrl]);
      const notFoundStackItem =
          NavigationStackItem.notFound(pathSegments: [artObjectListSegment]);
      expect(artObjectListStackItem, isNotNull);
      expect(artObjectDetailStackItem, isNotNull);
      expect(fullScreenStackItem, isNotNull);
      expect(notFoundStackItem, isNotNull);
    });
  });

  group('NavigationRouteInformationParser -', () {
    late NavigationRouteInformationParser parser;

    setUp(() {
      parser = NavigationRouteInformationParser();
    });

    test('itemForPathSegments return correct navigation stack items', () async {
      final artObjectListStackItem =
          await parser.itemForPathSegments([artObjectListSegment]);
      expect(
        artObjectListStackItem,
        equals(const NavigationStackItem.artObjectList()),
      );
      final notFoundStackItem =
          await parser.itemForPathSegments([errorPathSegment]);
      expect(
        notFoundStackItem,
        equals(const NavigationStackItem.notFound(
            pathSegments: [errorPathSegment])),
      );
    });

    test('pathSegmentsForItem return correct url segments', () async {
      final artObjectListSegments = parser.pathSegmentsForItem(
        const NavigationStackItem.artObjectList(),
      );
      expect(artObjectListSegments, equals([artObjectListSegment]));
      final notFoundSegments = parser.pathSegmentsForItem(
        const NavigationStackItem.notFound(pathSegments: [errorPathSegment]),
      );
      expect(notFoundSegments, equals([errorPathSegment]));
    });
  });
}
