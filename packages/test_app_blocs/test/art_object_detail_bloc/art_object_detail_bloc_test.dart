import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_domain/test_app_domain.dart' as domain;
import 'package:test_app_domain/test_app_domain.dart';
import 'art_object_detail_bloc_test.mocks.dart';

@GenerateMocks([domain.ArtObjectRepository])
void main() {
  group('ArtObjectDetailBloc -', () {
    late domain.IArtObjectRepository artObjectRepository;
    late ArtObjectDetailBloc artObjectDetailBloc;

    setUp(() {
      artObjectRepository = MockArtObjectRepository();
      when(artObjectRepository.getArtObject(
              objectNumber: ArtObjectDetailBlocTestData.correctObjectNumber))
          .thenAnswer(
              (_) async => ArtObjectDetailBlocTestData.artObjectFullContent());
      when(artObjectRepository.getArtObject(
              objectNumber: ArtObjectDetailBlocTestData.errorObjectNumber))
          .thenThrow(const ApiClientRequestException(
              cause: ArtObjectDetailBlocTestData.errorCause));
      artObjectDetailBloc = ArtObjectDetailBloc(
        repository: artObjectRepository,
      );
    });

    tearDown(() {
      artObjectDetailBloc.close();
    });

    test('Initial state is correct', () {
      expect(
        artObjectDetailBloc.state,
        const ArtObjectDetailState.initialLoading(),
      );
    });

    blocTest<ArtObjectDetailBloc, ArtObjectDetailState>(
      'Bloc emits correct states with partial and full content after initialLoad event',
      build: () => artObjectDetailBloc,
      act: (bloc) => bloc.add(
        ArtObjectDetailEvent.initialLoad(
            ArtObjectDetailBlocTestData.artObjectPartialContent(true)),
      ),
      expect: () => [
        ArtObjectDetailState.partialContent(
            ArtObjectDetailBlocTestData.artObjectPartialContent(true)),
        ArtObjectDetailState.fullContent(
            ArtObjectDetailBlocTestData.artObjectFullContent()),
      ],
      verify: (_) {
        verify(artObjectRepository.getArtObject(
                objectNumber: ArtObjectDetailBlocTestData.correctObjectNumber))
            .called(1);
        verifyNoMoreInteractions(artObjectRepository);
      },
    );

    blocTest<ArtObjectDetailBloc, ArtObjectDetailState>(
      'Bloc emits error state with getArtObject request throw ApiClientRequestException',
      build: () => artObjectDetailBloc,
      act: (bloc) => bloc.add(
        ArtObjectDetailEvent.initialLoad(
            ArtObjectDetailBlocTestData.artObjectPartialContent(false)),
      ),
      expect: () => [
        ArtObjectDetailState.partialContent(
            ArtObjectDetailBlocTestData.artObjectPartialContent(false)),
        const ArtObjectDetailState.error(
            ArtObjectDetailBlocTestData.errorCause),
      ],
      verify: (_) {
        verify(artObjectRepository.getArtObject(
                objectNumber: ArtObjectDetailBlocTestData.errorObjectNumber))
            .called(1);
        verifyNoMoreInteractions(artObjectRepository);
      },
    );
  });
}
