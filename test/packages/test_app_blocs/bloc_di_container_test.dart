import 'package:flutter_test/flutter_test.dart';
import 'package:test_app_blocs/test_app_blocs.dart';

void main() {
  group('BlocDIContainer -', () {
    late BlocDIContainer diContainer;

    setUp(() {
      diContainer = BlocDIContainer.instance;
    });

    test('container is initialized', () {
      expect(diContainer, isNotNull);
    });

    test('container returns exception without initialize method call', () {
      expect(() => diContainer.get<ArtObjectDetailBloc>(), throwsException);
    });

    test('container returns correct blocs', () {
      diContainer.initialise();
      expect(
          diContainer.get<ArtObjectDetailBloc>(), isA<ArtObjectDetailBloc>());
      expect(diContainer.get<ArtObjectListBloc>(), isA<ArtObjectListBloc>());
    });
  });
}
