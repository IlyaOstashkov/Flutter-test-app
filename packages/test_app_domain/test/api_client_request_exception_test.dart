import 'package:flutter_test/flutter_test.dart';
import 'package:test_app_domain/test_app_domain.dart';

void main() {
  group('ApiClientRequestException -', () {
    const cause = 'Witte gebeitste prentlijst';

    ApiClientRequestException _exception() {
      return const ApiClientRequestException(cause: cause);
    }

    test('initialized', () {
      final exception = _exception();
      expect(exception, isNotNull);
    });

    test('correct cause after initialization', () {
      final exception = _exception();
      expect(exception.cause, cause);
    });

    test('toString returned expected value', () {
      final exception = _exception();
      expect(exception.toString(), cause);
    });
  });
}
