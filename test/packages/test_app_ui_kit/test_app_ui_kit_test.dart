import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

void main() {
  const someText = 'some-text';
  const someImageUrl =
      'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png';
  const someRadius = 16.0;

  group('UI Kit tests -', () {
    testWidgets('SimpleText has correct text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SimpleText(someText)),
      );
      expect(find.text(someText), findsOneWidget);
    });

    testWidgets('TitleText has correct text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: TitleText(someText)),
      );
      expect(find.text(someText), findsOneWidget);
    });

    testWidgets('TransparentButton has one InkWell and correct child',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
            home: TransparentButton(
          onTap: () {},
          child: const Text(someText),
        )),
      );
      expect(find.text(someText), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('SimpleLoader has one CupertinoActivityIndicator',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SimpleLoader()),
      );
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    });

    testWidgets('AppBar has corret title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBarFabric.simpleAppBar(title: someText),
          ),
        ),
      );
      expect(find.text(someText), findsOneWidget);
    });

    testWidgets('OffsetSpace has one SizedBox', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: OffsetSpace()),
      );
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets(
        'LoadableImage has network image and loader, but without error Icon',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
            home: LoadableImage(
          imageUrl: someImageUrl,
          onTap: () {},
        )),
      );
      expect(find.byType(OptimizedCacheImage), findsOneWidget);
      expect(find.byType(SimpleLoader), findsOneWidget);
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('CircleLoadableImage with image url has not placeholder',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CircleLoadableImage(
            radius: someRadius,
            imageUrl: someImageUrl,
            placeholder: Icon(Icons.star),
          ),
        ),
      );
      expect(find.byType(Icon), findsNothing);
      expect(find.byType(LoadableImage), findsOneWidget);
    });

    testWidgets(
        'SnackBarWidget (Inherited widget) can be received from context. "Show" method is not crashed',
        (tester) async {
      var widgetFound = false;
      SnackBarWidget? snack;
      await tester.pumpWidget(
        MaterialApp(
          home: SnackBarWidget(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    snack = SnackBarWidget.of(context);
                    if (snack == null) return;
                    widgetFound = true;
                    snack!.show(context, someText);
                  },
                  child: const Text(someText),
                );
              },
            ),
          ),
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      expect(widgetFound, isTrue);
    });
  });
}
