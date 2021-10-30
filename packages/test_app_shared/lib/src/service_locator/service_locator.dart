//please use service locator abstraction, and do not use T call<T> ()
// to locate some instance, due to the following issue:
//https://github.com/dart-lang/sdk/issues/43814
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

abstract class ServiceLocator {
  static final getIt = GetIt.I;

  T get<T extends Object>() => getIt.get<T>();

  T getWithParam<T extends Object, P extends Object>({P? param}) => getIt.get<T>(param1: param);

  Future<T> getAsync<T extends Object>() => getIt.getAsync<T>();

  @visibleForTesting
  @protected
  Future<void> allReady() {
    return getIt.allReady();
  }

  @mustCallSuper
  static Future<void> reset() {
    return getIt.reset();
  }

  @visibleForTesting
  @protected
  void registerSingleton<T extends Object>(T instance) {
    getIt.registerSingleton(instance);
  }

  @visibleForTesting
  @protected
  void registerSingletonAsync<T extends Object>(ValueGetter<Future<T>> factoryfunc,
      {Iterable<Type>? dependsOn}) {
    getIt.registerSingletonAsync(factoryfunc, dependsOn: dependsOn);
  }

  @visibleForTesting
  @protected
  void registerFactory<T extends Object>(ValueGetter<T> factoryfunc) {
    getIt.registerFactory(factoryfunc);
  }

  @visibleForTesting
  @protected
  void registerLazySingleton<T extends Object>(
    ValueGetter<T> factoryfunc, {
    DisposingFunc<T>? dispose,
  }) {
    getIt.registerLazySingleton(factoryfunc, dispose: dispose);
  }

  @visibleForTesting
  @protected
  void registerFactoryParam<T extends Object, P1, P2>(T Function(P1?, P2?) factoryfunc,
      {String? instanceName}) {
    getIt.registerFactoryParam(factoryfunc, instanceName: instanceName);
  }

  @visibleForTesting
  @protected
  void registerSingletonWithDependencies<T extends Object>(FactoryFunc<T> factoryFunc,
      {required List<Type> dependsOn}) {
    getIt.registerSingletonWithDependencies(factoryFunc, dependsOn: dependsOn);
  }
}
