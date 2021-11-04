import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_domain/test_app_domain.dart' as domain;
import 'art_object_list_bloc_test.mocks.dart';

@GenerateMocks([domain.ArtObjectRepository])
void main() {
  group('ArtObjectListBloc -', () {
    late domain.IArtObjectRepository artObjectRepository;
    late ArtObjectListBloc artObjectListBloc;

    const _throttleTimeout = 500;

    Future<void> _delayToWaitThrottleChecking() {
      return Future.delayed(
          const Duration(milliseconds: _throttleTimeout + 100));
    }

    setUp(() {
      artObjectRepository = MockArtObjectRepository();
      when(artObjectRepository.getArtObjectList(
        page: 1,
        limit: ArtObjectListBlocTestData.limit,
        century: ArtObjectListBlocTestData.century,
      )).thenAnswer((_) async => [
            ArtObjectListBlocTestData.artObject(1),
            ArtObjectListBlocTestData.artObject(2),
          ]);
      when(artObjectRepository.getArtObjectList(
        page: 2,
        limit: ArtObjectListBlocTestData.limit,
        century: ArtObjectListBlocTestData.century,
      )).thenAnswer((_) async => [
            ArtObjectListBlocTestData.artObject(3),
            ArtObjectListBlocTestData.artObject(4),
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
          ArtObjectListBlocTestData.contentStateWithHeaderAnd2Items(),
        ],
        verify: (_) {
          verify(artObjectRepository.getArtObjectList(
            page: 1,
            limit: ArtObjectListBlocTestData.limit,
            century: ArtObjectListBlocTestData.century,
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
        expect: () => <ArtObjectListState>[],
        verify: (_) {
          verify(artObjectRepository.getArtObjectList(
            page: 1,
            limit: ArtObjectListBlocTestData.limit,
            century: ArtObjectListBlocTestData.century,
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
            ArtObjectListBlocTestData.header(),
            ...ArtObjectListBlocTestData.listItems([
              ArtObjectListBlocTestData.artObject(1),
              ArtObjectListBlocTestData.artObject(2),
              ArtObjectListBlocTestData.artObject(3),
              ArtObjectListBlocTestData.artObject(4),
            ])
          ], false, ArtObjectListBlocTestData.century, 2),
        ],
        verify: (_) {
          verify(artObjectRepository.getArtObjectList(
            page: 1,
            limit: ArtObjectListBlocTestData.limit,
            century: ArtObjectListBlocTestData.century,
          )).called(1);
          verify(artObjectRepository.getArtObjectList(
            page: 2,
            limit: ArtObjectListBlocTestData.limit,
            century: ArtObjectListBlocTestData.century,
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
            limit: ArtObjectListBlocTestData.limit,
            century: ArtObjectListBlocTestData.century,
          )).called(1);
          verify(artObjectRepository.getArtObjectList(
            page: 2,
            limit: ArtObjectListBlocTestData.limit,
            century: ArtObjectListBlocTestData.century,
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
          ArtObjectListBlocTestData.contentStateWithHeaderAnd2Items(),
        ],
        verify: (_) {
          verify(artObjectRepository.getArtObjectList(
            page: 1,
            limit: ArtObjectListBlocTestData.limit,
            century: ArtObjectListBlocTestData.century,
          )).called(2);
          verify(artObjectRepository.getArtObjectList(
            page: 2,
            limit: ArtObjectListBlocTestData.limit,
            century: ArtObjectListBlocTestData.century,
          )).called(1);
          verifyNoMoreInteractions(artObjectRepository);
        },
      );
    });
  });
}
