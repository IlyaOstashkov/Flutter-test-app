import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await AppFontsLoader.load();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => true,
      defaultDevices: const [Device.phone],
    ),
  );
}
