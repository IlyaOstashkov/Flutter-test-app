import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/image_gallery/full_screen_image_page.dart';
import 'package:flutter_test_app/image_gallery/full_screen_image_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'page_tester.dart';

void main() {
  group('FullScreenImagePage -', () {
    testWidgets('page created with empty image url list', (widgetTester) async {
      await PageTester(
        child: const FullScreenImagePage(imageUrls: <String>[]),
      ).testPageIsCreated(tester: widgetTester);
      expect(find.byType(FullScreenImageView), findsOneWidget);
      expect(find.byType(PhotoViewGallery), findsOneWidget);
    });
  });
}
