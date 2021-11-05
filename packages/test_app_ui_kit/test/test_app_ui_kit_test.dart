import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:test_app_ui_kit/src/golden/golden_runner_scenario.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

void main() {
  const someText = 'some text';
  const someVeryLongText =
      'fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd fdsf df sdf sdf sdf sdf sdf sdf sdf sdf sd';
  const someImageUrl =
      'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png';
  const someRadius = 16.0;

  group('UI Kit tests -', () {
    GoldenRunner.execute(
        widgetType: SimpleText,
        scenarios: [
          const GoldenRunnerScenario(
            name: 'Correct text',
            child: SimpleText(someText),
          ),
          const GoldenRunnerScenario(
            name: 'Long text',
            child: SimpleText(someVeryLongText),
          ),
          const GoldenRunnerScenario(
            name: 'Long text with wrap',
            child: SimpleText(
              someVeryLongText,
              maxLines: 2,
            ),
          ),
          const GoldenRunnerScenario(
            name: 'Empty text',
            child: SimpleText(''),
          ),
        ],
        test: (tester) async {
          expect(find.text(someText), findsOneWidget);
        });

    GoldenRunner.execute(
        widgetType: TitleText,
        scenarios: [
          const GoldenRunnerScenario(
            name: 'Correct text',
            child: TitleText(someText),
          ),
          const GoldenRunnerScenario(
            name: 'Long text',
            child: TitleText(someVeryLongText),
          ),
          const GoldenRunnerScenario(
            name: 'Long text with wrap',
            child: TitleText(
              someVeryLongText,
              maxLines: 2,
            ),
          ),
          const GoldenRunnerScenario(
            name: 'Empty text',
            child: TitleText(''),
          ),
        ],
        test: (tester) async {
          expect(find.text(someText), findsOneWidget);
        });

    GoldenRunner.execute(
        widgetType: TransparentButton,
        scenarios: [
          GoldenRunnerScenario(
            name: 'Button with text',
            child: TransparentButton(
              onTap: () {},
              child: const Text(someText),
            ),
          ),
        ],
        test: (tester) async {
          expect(find.text(someText), findsOneWidget);
          expect(find.byType(InkWell), findsOneWidget);
        });

    GoldenRunner.execute(
        widgetType: SimpleLoader,
        scenarios: [
          const GoldenRunnerScenario(
            name: 'Show activity indicator',
            child: SimpleLoader(),
          ),
        ],
        test: (tester) async {
          expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
        });

    testWidgets('AppBarFabric has correct title', (tester) async {
      await tester.pumpWidget(
        MaterialAppAppWidget(
          child: Scaffold(
            appBar: AppBarFabric.simpleAppBar(title: someText),
          ),
        ),
      );
      expect(find.text(someText), findsOneWidget);
    });

    GoldenRunner.execute(
        widgetType: OffsetSpace,
        scenarios: [
          GoldenRunnerScenario(
            name: 'Correct small height',
            child: Column(
              children: const [
                SimpleText(someText),
                OffsetSpace(),
                SimpleText(someText),
              ],
            ),
          ),
          GoldenRunnerScenario(
            name: 'Correct very big height',
            child: Column(
              children: const [
                SimpleText(someText),
                OffsetSpace.vertical(OffsetValue.big),
                SimpleText(someText),
              ],
            ),
          ),
          GoldenRunnerScenario(
            name: 'Correct medium width',
            child: Row(
              children: const [
                SimpleText(someText),
                OffsetSpace.horizontal(OffsetValue.medium),
                SimpleText(someText),
              ],
            ),
          ),
        ],
        test: (tester) async {
          expect(find.byType(SizedBox), findsWidgets);
        });

    GoldenRunner.execute(
        widgetType: LoadableImage,
        scenarios: [
          GoldenRunnerScenario(
            name: 'Show loader while load image by url',
            child: LoadableImage(
              imageUrl: someImageUrl,
              onTap: () {},
            ),
          ),
        ],
        test: (tester) async {
          expect(find.byType(OptimizedCacheImage), findsOneWidget);
          expect(find.byType(SimpleLoader), findsOneWidget);
          expect(find.byType(Icon), findsNothing);
        });

    GoldenRunner.execute(
        widgetType: CircleLoadableImage,
        scenarios: [
          const GoldenRunnerScenario(
            name: 'Dont show placeholder with image url',
            child: CircleLoadableImage(
              radius: someRadius,
              imageUrl: someImageUrl,
              placeholder: Icon(Icons.star),
            ),
          ),
          const GoldenRunnerScenario(
            name: 'Show placeholder without image url',
            child: CircleLoadableImage(
              radius: someRadius,
              imageUrl: null,
              placeholder: Icon(Icons.star),
            ),
          ),
        ],
        test: (tester) async {
          expect(find.byType(Icon), findsOneWidget);
          expect(find.byType(LoadableImage), findsWidgets);
        });

    testWidgets(
        'SnackBarWidget (Inherited widget) can be received from context. "Show" method is not crashed',
        (tester) async {
      var widgetFound = false;
      SnackBarWidget? snack;
      await tester.pumpWidget(
        MaterialAppAppWidget(
          child: SnackBarWidget(
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
