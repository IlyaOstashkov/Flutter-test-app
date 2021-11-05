import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

import 'golden_runner_scenario.dart';
import 'golden_runner_scenario_list_widget.dart';

class GoldenRunner {
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
      );
      await test?.call(tester);
      final fileName = _camelCaseToSnake(widgetType.toString());
      await expectLater(
        find.byType(GoldenRunnerScenarioListWidget),
        matchesGoldenFile('goldens/$fileName.png'),
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
