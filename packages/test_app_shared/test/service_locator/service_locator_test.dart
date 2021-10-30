import 'package:flutter_test/flutter_test.dart';
import 'package:test_app_shared/test_app_shared.dart';

void main() {
  group('Service Locator', () {
    late ServiceLocator serviceLocator;

    setUp(() {
      serviceLocator = DummyServiceLocator();
    });

    tearDown(() async {
      await ServiceLocator.reset();
    });

    test('registerFactory works as expected', () {
      serviceLocator.registerFactory(DummyService.create);
      expect(serviceLocator.get<DummyService>(), isNotNull);
    });

    test('registerLazySingleton works as expected', () {
      serviceLocator.registerLazySingleton(DummyService.create);
      expect(serviceLocator.get<DummyService>(), isNotNull);
    });

    test('registerFactoryParam works as expected', () {
      serviceLocator.registerFactoryParam<DummyService, Object, void>(
          (param, _) => DummyService.param(param));
      expect(
          serviceLocator
              .getWithParam<DummyService, Object>(param: Object())
              .testField,
          isNotNull);
    });

    test('registerSingleton works as expected', () {
      serviceLocator.registerSingleton(DummyService.create());
      expect(serviceLocator.get<DummyService>(), isNotNull);
    });

    test('registerSingletonAsync works as expected', () async {
      serviceLocator.registerSingletonAsync(() async => DummyService.create());
      expect(await serviceLocator.getAsync<DummyService>(), isNotNull);
    });

    test('registerSingletonWithDependencies works as expected', () async {
      serviceLocator.registerSingletonAsync<AnotherDummyService>(
          () async => AnotherDummyService());
      serviceLocator.registerSingletonWithDependencies(DummyService.create,
          dependsOn: [AnotherDummyService]);

      expect(await serviceLocator.getAsync<DummyService>(), isNotNull);
    });

    test('allReady works as expected', () async {
      serviceLocator.registerSingletonAsync<AnotherDummyService>(
          () async => AnotherDummyService());
      serviceLocator.registerSingletonWithDependencies(DummyService.create,
          dependsOn: [AnotherDummyService]);

      await serviceLocator.allReady();

      expect(serviceLocator.get<DummyService>(), isNotNull);
    });

    test('reset works as expected', () async {
      serviceLocator.registerSingleton(DummyService.create());

      await ServiceLocator.reset();

      DummyService? service;

      //we ignore errors because the test about getting service
      try {
        service = serviceLocator.get<DummyService>();
      } catch (_) {}

      expect(service, isNull);
    });
  });
}

class DummyServiceLocator extends ServiceLocator {}

class AnotherDummyService {}

class DummyService {
  final Object? testField;

  DummyService._({this.testField});

  factory DummyService.create() => DummyService._();
  factory DummyService.param(Object? testField) =>
      DummyService._(testField: testField);
}
