import 'dart:async';
import 'dart:io';

import 'package:art_object_repository/art_object_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/constants/fetch_error_constants.dart';
import 'package:flutter_test_app/pages/art_object_list/models/art_object_list_item.dart';
import 'package:rxdart/rxdart.dart';

import 'art_object_list_event.dart';
import 'art_object_list_state.dart';

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
          final int nextFetchPage = fetchPage + 1;
          // fetch art objects for current century
          final List<ArtObject> nextPageArtObjects =
              await repository.getArtObjectList(
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
            final int nextCentury = century - 1;
            final ArtObjectListItem nextCenturyHeaderItem =
                _headerItem(nextCentury);
            return emit(ArtObjectListState.content(
              List.of(listItems)..add(nextCenturyHeaderItem),
              false,
              nextCentury,
              0,
            ));
          }
          // not all century items loaded
          final List<ArtObjectListItem> nextPageListItems = nextPageArtObjects
              .map((e) => ArtObjectListItem(artObject: e))
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
    } on ArtObjectException {
      emit(const ArtObjectListState.error(FetchErrorConstants.serverError));
    } on PlatformException catch (e) {
      emit(ArtObjectListState.error(
          e.message ?? FetchErrorConstants.serverError));
    } on SocketException catch (_) {
      emit(const ArtObjectListState.error(
          FetchErrorConstants.noInternetConnection));
    } on TimeoutException {
      emit(const ArtObjectListState.error(FetchErrorConstants.timeout));
    } catch (e) {
      emit(const ArtObjectListState.error(FetchErrorConstants.undefinedError));
    }
  }

  Future<void> _onFullReloadEvent(
    ArtObjectListFullReloadEvent event,
    Emitter<ArtObjectListState> emit,
  ) async {
    emit(const ArtObjectListState.initialLoading());
    // refetch art objects after trottling timeout
    await Future.delayed(const Duration(milliseconds: _throttleTimeout));
    add(const ArtObjectListEvent.fetched());
  }

  Future<void> _initialLoading(Emitter<ArtObjectListState> emit) async {
    final List<ArtObject> nextPageArtObjects =
        await repository.getArtObjectList(
      page: _startFetchPage,
      limit: _limit,
      century: _startCentury,
    );
    final List<ArtObjectListItem> nextPageListItems =
        nextPageArtObjects.map((e) => ArtObjectListItem(artObject: e)).toList();
    final List<ArtObjectListItem> listItems = [
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

  ArtObjectListItem _headerItem(int century) {
    final centuryString = century.toString();
    return ArtObjectListItem(
      isHeader: true,
      headerTitle: '$centuryString century',
    );
  }
}
