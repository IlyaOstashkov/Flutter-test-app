import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_domain/test_app_domain.dart' as repository;
import 'package:test_app_domain/test_app_domain.dart';
import 'art_object_detail_bloc_test.mocks.dart';

@GenerateMocks([repository.ArtObjectRepository])
void main() {
  const correctObjectNumber = '1';
  const errorObjectNumber = '2';
  const errorCause = 'error cause';
  group('ArtObjectDetailBloc -', () {
    late repository.IArtObjectRepository artObjectRepository;
    late ArtObjectDetailBloc artObjectDetailBloc;

    repository.ArtObject _artObjectPartialContent(bool isCorrectObjectNumber) {
      return repository.ArtObject(
        objectNumber:
            isCorrectObjectNumber ? correctObjectNumber : errorObjectNumber,
        title: 'title1',
        imageUrl: 'imageUrl1',
        description: null,
        principalOrFirstMaker: null,
        presentingDate: null,
      );
    }

    repository.ArtObject _artObjectFullContent() {
      return const repository.ArtObject(
        objectNumber: correctObjectNumber,
        title: 'title1',
        imageUrl: 'imageUrl1',
        description: 'description1',
        principalOrFirstMaker: 'principalOrFirstMaker1',
        presentingDate: 'presentingDate1',
      );
    }

    setUp(() {
      artObjectRepository = MockArtObjectRepository();
      when(artObjectRepository.getArtObject(objectNumber: correctObjectNumber))
          .thenAnswer((_) async => _artObjectFullContent());
      when(artObjectRepository.getArtObject(objectNumber: errorObjectNumber))
          .thenThrow(const ApiClientRequestException(cause: errorCause));
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
        ArtObjectDetailEvent.initialLoad(_artObjectPartialContent(true)),
      ),
      expect: () => [
        ArtObjectDetailState.partialContent(_artObjectPartialContent(true)),
        ArtObjectDetailState.fullContent(_artObjectFullContent()),
      ],
      verify: (_) {
        verify(artObjectRepository.getArtObject(
                objectNumber: correctObjectNumber))
            .called(1);
        verifyNoMoreInteractions(artObjectRepository);
      },
    );

    blocTest<ArtObjectDetailBloc, ArtObjectDetailState>(
      'Bloc emits error state with getArtObject request throw ApiClientRequestException',
      build: () => artObjectDetailBloc,
      act: (bloc) => bloc.add(
        ArtObjectDetailEvent.initialLoad(_artObjectPartialContent(false)),
      ),
      expect: () => [
        ArtObjectDetailState.partialContent(_artObjectPartialContent(false)),
        const ArtObjectDetailState.error(errorCause),
      ],
      verify: (_) {
        verify(artObjectRepository.getArtObject(
                objectNumber: errorObjectNumber))
            .called(1);
        verifyNoMoreInteractions(artObjectRepository);
      },
    );
  });
}
