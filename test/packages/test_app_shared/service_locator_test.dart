import 'package:flutter_test/flutter_test.dart';
import 'package:test_app_shared/test_app_shared.dart';

void main() {
  group('ServiceLocator -', () {
    late ServiceLocator serviceLocator;

    setUp(() {
      serviceLocator = DummyServiceLocator();
    });

    tearDown(() async {
      await ServiceLocator.reset();
    });

    test('registerFactory works as expected', () {
      serviceLocator.registerFactory(() => SecondService());
      expect(serviceLocator.get<SecondService>(), isNotNull);
    });

    test('registerLazySingleton works as expected', () {
      serviceLocator.registerLazySingleton(() => SecondService());
      expect(serviceLocator.get<SecondService>(), isNotNull);
    });

    test('registerFactoryParam works as expected', () {
      serviceLocator.registerFactoryParam<SecondService, Object, void>(
          (param, _) => SecondService(testField: param));
      expect(
          serviceLocator
              .getWithParam<SecondService, Object>(param: Object())
              .testField,
          isNotNull);
    });

    test('registerSingleton works as expected', () {
      serviceLocator.registerSingleton(SecondService());
      expect(serviceLocator.get<SecondService>(), isNotNull);
    });

    test('registerSingletonAsync works as expected', () async {
      serviceLocator.registerSingletonAsync(() async => SecondService());
      expect(await serviceLocator.getAsync<SecondService>(), isNotNull);
    });

    test('registerSingletonWithDependencies works as expected', () async {
      serviceLocator
          .registerSingletonAsync<FirstService>(() async => FirstService());
      serviceLocator.registerSingletonWithDependencies(() => SecondService(),
          dependsOn: [FirstService]);
      expect(await serviceLocator.getAsync<SecondService>(), isNotNull);
    });

    test('allReady works as expected', () async {
      serviceLocator
          .registerSingletonAsync<FirstService>(() async => FirstService());
      serviceLocator.registerSingletonWithDependencies(() => SecondService(),
          dependsOn: [FirstService]);
      await serviceLocator.allReady();
      expect(serviceLocator.get<SecondService>(), isNotNull);
    });

    test('reset works as expected', () async {
      serviceLocator.registerSingleton(SecondService());
      await ServiceLocator.reset();
      SecondService? service;
      //we ignore errors because the test about getting service
      try {
        service = serviceLocator.get<SecondService>();
      } catch (_) {}
      expect(service, isNull);
    });
  });
}

class DummyServiceLocator extends ServiceLocator {}

class FirstService {}

class SecondService {
  SecondService({this.testField});
  final Object? testField;
}
