import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/widgets/simple_text.dart';
import 'package:flutter_test_app/widgets/title_text.dart';

void main() {
  const String someText = 'some-text';
  testWidgets('SimpleText has correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SimpleText(someText)),
    );
    expect(find.text(someText), findsOneWidget);
  });

  testWidgets('TitleText has correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: TitleText(someText)),
    );
    expect(find.text(someText), findsOneWidget);
  });
}
