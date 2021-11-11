import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/image_gallery/full_screen_image_page.dart';
import 'package:flutter_test_app/image_gallery/full_screen_image_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

void main() {
  group('FullScreenImagePage -', () {
    GoldenRunner.executePage(
        pageWidget: const FullScreenImagePage(imageUrls: <String>[]),
        test: (tester) async {
          expect(find.byType(FullScreenImageView), findsOneWidget);
          expect(find.byType(PhotoViewGallery), findsOneWidget);
        });
  });
}
