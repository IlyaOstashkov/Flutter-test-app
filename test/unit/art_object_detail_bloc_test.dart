import 'package:art_object_repository/art_object_repository.dart' as repository;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_bloc.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_event.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'art_object_detail_bloc_test.mocks.dart';

@GenerateMocks([repository.ArtObjectRepository])
void main() {
  const String objectNumber = '1';
  group('ArtObjectDetailBloc - ', () {
    late repository.IArtObjectRepository artObjectRepository;
    late ArtObjectDetailBloc artObjectDetailBloc;

    repository.ArtObject _artObjectFromList() {
      return const repository.ArtObject(
        objectNumber: objectNumber,
        title: 'title1',
        imageUrl: 'imageUrl1',
        description: null,
        principalOrFirstMaker: null,
        presentingDate: null,
      );
    }

    repository.ArtObject _artObjectDetail() {
      return const repository.ArtObject(
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
      when(artObjectRepository.getArtObject(objectNumber: objectNumber))
          .thenAnswer((_) async => _artObjectDetail());
      artObjectDetailBloc = ArtObjectDetailBloc(
        repository: artObjectRepository,
        artObject: _artObjectFromList(),
      );
    });

    tearDown(() {
      artObjectDetailBloc.close();
    });

    test('initial state is correct', () {
      expect(
        artObjectDetailBloc.state,
        ArtObjectDetailState.initialContent(_artObjectFromList()),
      );
    });

    blocTest<ArtObjectDetailBloc, ArtObjectDetailState>(
      'Bloc emits correct state and detailed art object after ArtObjectDetailEvent.fetchFullContent was called',
      build: () => artObjectDetailBloc,
      act: (bloc) => bloc.add(
        ArtObjectDetailEvent.fetchFullContent(
            _artObjectFromList().objectNumber),
      ),
      expect: () => [ArtObjectDetailState.fullContent(_artObjectDetail())],
      verify: (_) {
        verify(artObjectRepository.getArtObject(objectNumber: objectNumber))
            .called(1);
        verifyNoMoreInteractions(artObjectRepository);
      },
    );
  });
}
