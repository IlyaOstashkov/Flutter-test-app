import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockBloc<E, S> extends Mock implements Bloc<E, S> {
  MockBloc() {
    when(() => stream).thenAnswer((_) => const Stream.empty());
    when(close).thenAnswer((_) => Future.value());
    when(() => add(any())).thenReturn(null);
  }
}
