import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_app_domain/test_app_domain.dart';

import 'art_object_list_event.dart';
import 'art_object_list_state.dart';
import 'view_models/art_object_list_view_model.dart';

class ArtObjectListBloc extends Bloc<ArtObjectListEvent, ArtObjectListState> {
  ArtObjectListBloc({required this.repository})
      : super(const ArtObjectListState.initialLoading()) {
    on<ArtObjectListFetchedEvent>(
      _onFetchedEvent,
      transformer: _throttleTimeTransformer(),
    );
    on<ArtObjectListFullReloadEvent>(_onFullReloadEvent);
  }

  final IArtObjectRepository repository;

  static const _limit = 10;
  static const _throttleTimeout = 500;
  static const _startCentury = 21;
  static const _endCentury = 19;
  static const _startFetchPage = 1;

  EventTransformer<MyEvent> _throttleTimeTransformer<MyEvent>() {
    return (events, mapper) => events
        .throttleTime(const Duration(milliseconds: _throttleTimeout))
        .flatMap(mapper);
  }

  Future<void> _onFetchedEvent(
    ArtObjectListFetchedEvent event,
    Emitter<ArtObjectListState> emit,
  ) async {
    try {
      await state.maybeWhen(
        initialLoading: () {
          return _initialLoading(emit);
        },
        content: (listItems, reachedMax, century, fetchPage) async {
          if (reachedMax) {
            emit(state);
            return;
          }
          final nextFetchPage = fetchPage + 1;
          // fetch art objects for current century
          final nextPageArtObjects = await repository.getArtObjectList(
            page: nextFetchPage,
            limit: _limit,
            century: century,
          );
          // all items loaded
          if (nextPageArtObjects.isEmpty) {
            // all items loaded for all centuries
            if (century == _endCentury) {
              return emit(ArtObjectListState.content(
                listItems,
                true,
                century,
                nextFetchPage,
              ));
            }
            // all items loaded for current century
            final nextCentury = century - 1;
            final nextCenturyHeaderItem = _headerItem(nextCentury);
            return emit(ArtObjectListState.content(
              List.of(listItems)..add(nextCenturyHeaderItem),
              false,
              nextCentury,
              0,
            ));
          }
          // not all century items loaded
          final nextPageListItems = nextPageArtObjects
              .map((e) => ArtObjectListViewModel(artObject: e))
              .toList();
          emit(ArtObjectListState.content(
            List.of(listItems)..addAll(nextPageListItems),
            false,
            century,
            nextFetchPage,
          ));
        },
        orElse: () {},
      );
    } on ApiClientRequestException catch (e) {
      emit(ArtObjectListState.error(e.cause));
    }
  }

  Future<void> _onFullReloadEvent(
    ArtObjectListFullReloadEvent event,
    Emitter<ArtObjectListState> emit,
  ) async {
    emit(const ArtObjectListState.initialLoading());
    // refetch art objects after trottling timeout
    await Future<void>.delayed(const Duration(milliseconds: _throttleTimeout));
    add(const ArtObjectListEvent.fetched());
  }

  Future<void> _initialLoading(Emitter<ArtObjectListState> emit) async {
    final nextPageArtObjects = await repository.getArtObjectList(
      page: _startFetchPage,
      limit: _limit,
      century: _startCentury,
    );
    final nextPageListItems = nextPageArtObjects
        .map((e) => ArtObjectListViewModel(artObject: e))
        .toList();
    final listItems = [
      _headerItem(_startCentury),
      ...nextPageListItems,
    ];
    emit(ArtObjectListState.content(
      listItems,
      false,
      _startCentury,
      _startFetchPage,
    ));
  }

  ArtObjectListViewModel _headerItem(int century) {
    final centuryString = century.toString();
    return ArtObjectListViewModel(
      isHeader: true,
      headerTitle: '$centuryString century',
    );
  }
}
