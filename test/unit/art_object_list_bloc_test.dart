import 'package:art_object_repository/art_object_repository.dart' as repository;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_state.dart';
import 'package:flutter_test_app/pages/art_object_list/view_models/art_object_list_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'art_object_list_bloc_test.mocks.dart';

@GenerateMocks([repository.ArtObjectRepository])
void main() {
  group('ArtObjectListBloc - ', () {
    late repository.IArtObjectRepository artObjectRepository;
    late ArtObjectListBloc artObjectListBloc;

    const int limit = 10;
    const int century = 21;
    const String someHeader = '21 century';
    const int _throttleTimeout = 500;

    repository.ArtObject _artObject(int number) {
      return repository.ArtObject(
        objectNumber: number.toString(),
        title: 'title' + number.toString(),
        imageUrl: null,
        description: null,
        principalOrFirstMaker: null,
        presentingDate: null,
      );
    }

    ArtObjectListViewModel _header() {
      return const ArtObjectListViewModel(
        isHeader: true,
        headerTitle: someHeader,
      );
    }

    List<ArtObjectListViewModel> _listItems(
        List<repository.ArtObject?> artObjects) {
      return artObjects
          .map((e) => ArtObjectListViewModel(
                artObject: e,
                isHeader: false,
                headerTitle: '',
              ))
          .toList();
    }

    Future<void> _delayToWaitThrottleChecking() {
      return Future.delayed(
          const Duration(milliseconds: _throttleTimeout + 100));
    }

    setUp(() {
      artObjectRepository = MockArtObjectRepository();
      when(artObjectRepository.getArtObjectList(
        page: 1,
        limit: limit,
        century: century,
      )).thenAnswer((_) async => [
            _artObject(1),
            _artObject(2),
          ]);
      when(artObjectRepository.getArtObjectList(
        page: 2,
        limit: limit,
        century: century,
      )).thenAnswer((_) async => [
            _artObject(3),
            _artObject(4),
          ]);
      artObjectListBloc = ArtObjectListBloc(repository: artObjectRepository);
    });

    tearDown(() {
      artObjectListBloc.close();
    });

    test('initial state is correct', () {
      expect(
          artObjectListBloc.state, const ArtObjectListState.initialLoading());
    });

    group('add ArtObjectListFetchedEvent', () {
      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'emits correct listItems when ArtObjectListFetchedEvent is added',
        build: () => artObjectListBloc,
        act: (bloc) => bloc.add(const ArtObjectListEvent.fetched()),
        expect: () => [
          ArtObjectListState.content([
            _header(),
            ..._listItems([
              _artObject(1),
              _artObject(2),
            ])
          ], false, century, 1),
        ],
        verify: (_) {
          verify(artObjectRepository.getArtObjectList(
            page: 1,
            limit: limit,
            century: century,
          )).called(1);
          verifyNoMoreInteractions(artObjectRepository);
        },
      );

      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'check throttling when ArtObjectListFetchedEvent is added twice',
        build: () => artObjectListBloc,
        act: (bloc) async {
          bloc
            ..add(const ArtObjectListEvent.fetched())
            ..add(const ArtObjectListEvent.fetched());
        },
        skip: 1,
        expect: () => [],
        verify: (_) {
          verify(artObjectRepository.getArtObjectList(
            page: 1,
            limit: limit,
            century: century,
          )).called(1);
          verifyNoMoreInteractions(artObjectRepository);
        },
      );

      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'emits correct listItems when ArtObjectListFetchedEvent is added twice',
        build: () => artObjectListBloc,
        act: (bloc) async {
          bloc.add(const ArtObjectListEvent.fetched());
          await _delayToWaitThrottleChecking();
          bloc.add(const ArtObjectListEvent.fetched());
        },
        skip: 1,
        expect: () => [
          ArtObjectListState.content([
            _header(),
            ..._listItems([
              _artObject(1),
              _artObject(2),
              _artObject(3),
              _artObject(4),
            ])
          ], false, century, 2),
        ],
        verify: (_) {
          verify(artObjectRepository.getArtObjectList(
            page: 1,
            limit: limit,
            century: century,
          )).called(1);
          verify(artObjectRepository.getArtObjectList(
            page: 2,
            limit: limit,
            century: century,
          )).called(1);
          verifyNoMoreInteractions(artObjectRepository);
        },
      );
    });

    group('add ArtObjectListFullReloadEvent', () {
      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'emits ArtObjectListStatus.initialLoading status at first when ArtObjectListFullReloadEvent is added',
        build: () => artObjectListBloc,
        act: (bloc) async {
          bloc.add(const ArtObjectListEvent.fetched());
          await _delayToWaitThrottleChecking();
          bloc.add(const ArtObjectListEvent.fetched());
          await _delayToWaitThrottleChecking();
          bloc.add(const ArtObjectListEvent.fullReload());
        },
        skip: 2,
        expect: () => [const ArtObjectListState.initialLoading()],
        verify: (_) {
          verify(artObjectRepository.getArtObjectList(
            page: 1,
            limit: limit,
            century: century,
          )).called(1);
          verify(artObjectRepository.getArtObjectList(
            page: 2,
            limit: limit,
            century: century,
          )).called(1);
          verifyNoMoreInteractions(artObjectRepository);
        },
      );

      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'emits correct listItems when ArtObjectListFullReloadEvent is added',
        build: () => artObjectListBloc,
        act: (bloc) async {
          bloc.add(const ArtObjectListEvent.fetched());
          await _delayToWaitThrottleChecking();
          bloc.add(const ArtObjectListEvent.fetched());
          await _delayToWaitThrottleChecking();
          bloc.add(const ArtObjectListEvent.fullReload());
          await _delayToWaitThrottleChecking();
        },
        skip: 3,
        expect: () => [
          ArtObjectListState.content([
            _header(),
            ..._listItems([
              _artObject(1),
              _artObject(2),
            ])
          ], false, century, 1),
        ],
        verify: (_) {
          verify(artObjectRepository.getArtObjectList(
            page: 1,
            limit: limit,
            century: century,
          )).called(2);
          verify(artObjectRepository.getArtObjectList(
            page: 2,
            limit: limit,
            century: century,
          )).called(1);
          verifyNoMoreInteractions(artObjectRepository);
        },
      );
    });
  });
}
