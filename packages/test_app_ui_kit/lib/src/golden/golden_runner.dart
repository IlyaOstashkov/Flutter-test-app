import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

import 'golden_runner_scenario.dart';
import 'golden_runner_scenario_list_widget.dart';

class GoldenRunner {
  static const _defaultSize = Size(360.0, 720.0);
  static void execute({
    required Type widgetType,
    required List<GoldenRunnerScenario> scenarios,
    Future<void> Function(WidgetTester widgetTester)? test,
  }) {
    final description = '${widgetType.toString()} golden + widget tests';
    testGoldens(description, (tester) async {
      assert(scenarios.isNotEmpty, 'List of scenarios must not be empty');
      await tester.pumpWidgetBuilder(
        GoldenRunnerScenarioListWidget(scenarios: scenarios),
        wrapper: (child) => MaterialAppAppWidget(child: child),
        surfaceSize: _defaultSize,
      );
      await test?.call(tester);
      final fileName = _camelCaseToSnake(widgetType.toString());
      await expectLater(
        find.byType(GoldenRunnerScenarioListWidget),
        matchesGoldenFile('goldens/$fileName.png'),
      );
    });
  }

  static void executePage({
    required Type widgetType,
    required GoldenRunnerScenario scenario,
    Function? setupFunction,
    Size? size,
    Future<void> Function(WidgetTester widgetTester)? test,
  }) {
    final description = '${scenario.name} - golden + widget tests';
    testGoldens(description, (tester) async {
      if (setupFunction != null) {
        setupFunction.call();
      }
      await tester.pumpWidgetBuilder(
        MaterialAppAppWidget(child: scenario.child),
        surfaceSize: size ?? _defaultSize,
      );
      await test?.call(tester);
      final snakeFileName =
          '${_camelCaseToSnake(widgetType.toString())}_${scenario.name.replaceAll(' ', '_')}';
      await expectLater(
        find.byType(scenario.child.runtimeType),
        matchesGoldenFile('goldens/$snakeFileName.png'),
      );
    });
  }

  static String _camelCaseToSnake(String camelCase) {
    // ignore: unnecessary_raw_strings
    final exp = RegExp(r'(?<=[a-z])[A-Z]');
    final result =
        camelCase.replaceAllMapped(exp, (m) => '_${m.group(0)}').toLowerCase();
    return result;
  }
}
