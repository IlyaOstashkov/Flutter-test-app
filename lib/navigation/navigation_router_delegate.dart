import 'package:flutter/material.dart';
import 'package:flutter_test_app/art_object_detail/art_object_detail_page.dart';
import 'package:flutter_test_app/art_object_list/art_object_list_page.dart';
import 'package:flutter_test_app/image_gallery/full_screen_image_page.dart';

import 'package:pragmatic_navigation/pragmatic_navigation.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

import 'navigation_stack_item.dart';
import 'not_found_page.dart';

class NavigationRouterDelegate
    extends NavigationStackRouterDelegate<NavigationStackItem> {
  NavigationRouterDelegate(
      {required NavigationStack<NavigationStackItem> stack})
      : super(stack: stack);

  @override
  List<Page<dynamic>> pages({BuildContext? context}) => stack
      .mapItems((item, index) => item.when(
            notFound: (pathSegments) => _materialPage(
              child: const NotFoundPage(),
              keyString: 'NotFoundPage',
            ),
            artObjectList: () => _materialPage(
              child: const ArtObjectListPage(),
              keyString: 'ArtObjectListPage',
            ),
            artObjectDetail: (artObject) => _materialPage(
              child: ArtObjectDetailPage(artObject: artObject),
              keyString: 'ArtObjectDetailPage_${artObject.hashCode}',
            ),
            fullScreenImage: (imageUrls) => _materialPage(
              child: FullScreenImagePage(imageUrls: imageUrls),
              keyString: 'FullScreenImagePage_${imageUrls.hashCode}',
            ),
          ))
      .toList();

  MaterialPage<dynamic> _materialPage({
    required Widget child,
    required String keyString,
  }) {
    return MaterialPage<dynamic>(
      key: ValueKey(keyString),
      child: SnackBarWidget(child: child),
    );
  }
}
