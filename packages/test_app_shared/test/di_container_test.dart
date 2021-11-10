import 'package:flutter_test/flutter_test.dart';
import 'package:test_app_shared/test_app_shared.dart';

void main() {
  group('DIContainer -', () {
    late DIContainer diContainer;

    setUp(() {
      diContainer = DIContainer();
    });

    test('container is initialized', () {
      expect(diContainer, isNull);
    });

    test('map and get methods work as expected', () {
      diContainer.map<_DummyService>(_DummyServiceImpl.new);
      final service = diContainer.get<_DummyService>();
      expect(service, isNotNull);
      expect(service, isA<_DummyServiceImpl>());
    });
  });
}

abstract class _DummyService {}

class _DummyServiceImpl implements _DummyService {}
