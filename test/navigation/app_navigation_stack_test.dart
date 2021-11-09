import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/navigation/app_navigation_stack.dart';

void main() {
  group('AppNavigationStack -', () {
    test('instance is initialized and have items', () async {
      expect(AppNavigationStack.instance, isNotNull);
      expect(AppNavigationStack.instance.items.length, isPositive);
    });
  });
}
