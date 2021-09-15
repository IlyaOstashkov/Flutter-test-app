import 'package:art_object_repository/art_object_repository.dart' as repository;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_bloc.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_event.dart';
import 'package:flutter_test_app/pages/art_object_list/bloc/art_object_list_state.dart';
import 'package:flutter_test_app/pages/art_object_list/models/art_object_list_item.dart';
import 'package:mocktail/mocktail.dart';

class MockArtObjectRepository extends Mock
    implements repository.ArtObjectRepository {}

void main() {
  group('ArtObjectListBloc', () {
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

    ArtObjectListItem _header() {
      return ArtObjectListItem(
        isHeader: true,
        headerTitle: someHeader,
      );
    }

    List<ArtObjectListItem> _listItems(List<repository.ArtObject?> artObjects) {
      return artObjects
          .map((e) => ArtObjectListItem(
                artObject: e,
                isHeader: false,
                headerTitle: '',
              ))
          .toList();
    }

    Future<void> _delayToWaitThrottleChecking() {
      return Future.delayed(Duration(milliseconds: _throttleTimeout + 100));
    }

    setUp(() {
      artObjectRepository = MockArtObjectRepository();
      when(() => artObjectRepository.getArtObjectList(
            page: 1,
            limit: limit,
            century: century,
          )).thenAnswer((_) async => [
            _artObject(1),
            _artObject(2),
          ]);
      when(() => artObjectRepository.getArtObjectList(
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
      expect(artObjectListBloc.state, ArtObjectListState());
    });

    group('add ArtObjectListFetchedEvent', () {
      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'emits correct listItems when ArtObjectListFetchedEvent is added',
        build: () => artObjectListBloc,
        act: (bloc) => bloc.add(ArtObjectListFetchedEvent()),
        expect: () => [
          ArtObjectListState(
            century: century,
            status: ArtObjectListStatus.success,
            listItems: [_header()]..addAll(_listItems([
                _artObject(1),
                _artObject(2),
              ])),
          )
        ],
      );

      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'check throttling when ArtObjectListFetchedEvent is added twice',
        build: () => artObjectListBloc,
        act: (bloc) async {
          bloc..add(ArtObjectListFetchedEvent());
          bloc..add(ArtObjectListFetchedEvent());
        },
        skip: 1,
        expect: () => [],
      );

      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'emits correct listItems when ArtObjectListFetchedEvent is added twice',
        build: () => artObjectListBloc,
        act: (bloc) async {
          bloc..add(ArtObjectListFetchedEvent());
          await _delayToWaitThrottleChecking();
          bloc..add(ArtObjectListFetchedEvent());
        },
        skip: 1,
        expect: () => [
          ArtObjectListState(
            century: century,
            status: ArtObjectListStatus.success,
            listItems: [_header()]..addAll(_listItems([
                _artObject(1),
                _artObject(2),
                _artObject(3),
                _artObject(4),
              ])),
          )
        ],
      );
    });

    group('add ArtObjectListFullReloadEvent', () {
      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'emits ArtObjectListStatus.initialLoading status at first when ArtObjectListFullReloadEvent is added',
        build: () => artObjectListBloc,
        act: (bloc) async {
          bloc..add(ArtObjectListFetchedEvent());
          await _delayToWaitThrottleChecking();
          bloc..add(ArtObjectListFetchedEvent());
          await _delayToWaitThrottleChecking();
          bloc..add(ArtObjectListFullReloadEvent());
        },
        skip: 2,
        expect: () => [
          ArtObjectListState(
            century: century,
            status: ArtObjectListStatus.initialLoading,
            listItems: [],
          )
        ],
      );

      blocTest<ArtObjectListBloc, ArtObjectListState>(
        'emits correct listItems when ArtObjectListFullReloadEvent is added',
        build: () => artObjectListBloc,
        act: (bloc) async {
          bloc..add(ArtObjectListFetchedEvent());
          await _delayToWaitThrottleChecking();
          bloc..add(ArtObjectListFetchedEvent());
          await _delayToWaitThrottleChecking();
          bloc..add(ArtObjectListFullReloadEvent());
          await _delayToWaitThrottleChecking();
        },
        skip: 3,
        expect: () => [
          ArtObjectListState(
            century: century,
            status: ArtObjectListStatus.success,
            listItems: [_header()]..addAll(_listItems([
                _artObject(1),
                _artObject(2),
              ])),
          )
        ],
      );
    });
  });
}
