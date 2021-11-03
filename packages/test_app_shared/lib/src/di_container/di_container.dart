import 'package:flutter_simple_dependency_injection/injector.dart';
import 'dart:async';

typedef FactoryFn<T> = T Function();

class DIContainer {
  final _injector = Injector();

  void map<T>(
    FactoryFn<T> factoryFn, {
    bool isSingleton = false,
  }) {
    _injector.map<T>((i) => factoryFn());
  }

  T get<T>() {
    return _injector.get<T>();
  }
}
