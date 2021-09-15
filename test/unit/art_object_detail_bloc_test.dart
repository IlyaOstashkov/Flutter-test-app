import 'package:art_object_repository/art_object_repository.dart' as repository;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_bloc.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_event.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_state.dart';
import 'package:mocktail/mocktail.dart';

class MockArtObjectRepository extends Mock
    implements repository.ArtObjectRepository {}

void main() {
  const String objectNumber = '1';
  group('ArtObjectDetailBloc', () {
    late repository.IArtObjectRepository artObjectRepository;
    late ArtObjectDetailBloc artObjectDetailBloc;

    repository.ArtObject _artObjectFromList() {
      return repository.ArtObject(
        objectNumber: objectNumber,
        title: 'title1',
        imageUrl: 'imageUrl1',
        description: null,
        principalOrFirstMaker: null,
        presentingDate: null,
      );
    }

    repository.ArtObject _artObjectDetail() {
      return repository.ArtObject(
        objectNumber: objectNumber,
        title: 'title1',
        imageUrl: 'imageUrl1',
        description: 'description1',
        principalOrFirstMaker: 'principalOrFirstMaker1',
        presentingDate: 'presentingDate1',
      );
    }

    setUp(() {
      artObjectRepository = MockArtObjectRepository();
      when(() => artObjectRepository.getArtObject(objectNumber: objectNumber))
          .thenAnswer((_) async => _artObjectDetail());
      artObjectDetailBloc =
          ArtObjectDetailBloc(repository: artObjectRepository);
    });

    tearDown(() {
      artObjectDetailBloc.close();
    });

    test('initial state is correct', () {
      expect(artObjectDetailBloc.state, ArtObjectDetailState());
    });

    group('add ArtObjectDetailInitialEvent', () {
      blocTest<ArtObjectDetailBloc, ArtObjectDetailState>(
        'emits correct statuses and art objects when ArtObjectDetailInitialEvent is added',
        build: () => artObjectDetailBloc,
        act: (bloc) =>
            bloc.add(ArtObjectDetailInitialEvent(_artObjectFromList())),
        expect: () => [
          ArtObjectDetailState(
            status: ArtObjectDetailStatus.initialLoading,
            artObject: _artObjectFromList(),
            errorMessage: '',
          ),
          ArtObjectDetailState(
            status: ArtObjectDetailStatus.success,
            artObject: _artObjectDetail(),
            errorMessage: '',
          )
        ],
        verify: (_) {
          verify(() =>
                  artObjectRepository.getArtObject(objectNumber: objectNumber))
              .called(1);
        },
      );
    });
  });
}
