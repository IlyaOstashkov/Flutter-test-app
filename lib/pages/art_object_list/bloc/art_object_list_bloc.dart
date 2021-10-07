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
      : super(const ArtObjectListState()) {
    on<ArtObjectListFetchedEvent>(
      _onArtObjectListFetchedEvent,
      transformer: _throttleTimeTransformer(),
    );
    on<ArtObjectListFullReloadEvent>(_onArtObjectListFullReloadEvent);
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

  Future<void> _onArtObjectListFetchedEvent(
    ArtObjectListFetchedEvent event,
    Emitter<ArtObjectListState> emit,
  ) async {
    if (state.hasReachedMax) {
      emit(state);
      return;
    }
    try {
      if (state.status == ArtObjectListStatus.initialLoading) {
        await _initialLoading(emit);
        return;
      }
      final int nextFetchPage = state.fetchPage + 1;
      // fetch art objects for current century
      final List<ArtObject> nextPageArtObjects =
          await repository.getArtObjectList(
        page: nextFetchPage,
        limit: _limit,
        century: state.century,
      );
      // all items loaded
      if (nextPageArtObjects.isEmpty) {
        _allCenturyItemsLoaded(
          nextFetchPage: nextFetchPage,
          emit: emit,
        );
        return;
      }
      _notAllCenturyItemsLoaded(
        nextPageArtObjects: nextPageArtObjects,
        nextFetchPage: nextFetchPage,
        emit: emit,
      );
    } on ArtObjectException {
      emit(state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: FetchErrorConstants.serverError,
      ));
    } on PlatformException catch (e) {
      emit(state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: e.message,
      ));
    } on SocketException catch (_) {
      emit(state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: FetchErrorConstants.noInternetConnection,
      ));
    } on TimeoutException {
      emit(state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: FetchErrorConstants.timeout,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: FetchErrorConstants.undefinedError,
      ));
    }
  }

  Future<void> _onArtObjectListFullReloadEvent(
    ArtObjectListFullReloadEvent event,
    Emitter<ArtObjectListState> emit,
  ) async {
    emit(const ArtObjectListState());
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
    emit(state.copyWith(
      status: ArtObjectListStatus.success,
      listItems: listItems,
      hasReachedMax: false,
      century: _startCentury,
      fetchPage: _startFetchPage,
    ));
  }

  void _allCenturyItemsLoaded({
    required int nextFetchPage,
    required Emitter<ArtObjectListState> emit,
  }) {
    // all items loaded for all centuries
    if (state.century == _endCentury) {
      emit(state.copyWith(
        hasReachedMax: true,
        fetchPage: nextFetchPage,
      ));
      return;
    }
    // all items loaded for current century
    final int nextCentury = state.century - 1;
    final ArtObjectListItem nextCenturyHeaderItem = _headerItem(nextCentury);
    emit(state.copyWith(
      century: nextCentury,
      listItems: List.of(state.listItems)..add(nextCenturyHeaderItem),
      fetchPage: 0,
    ));
  }

  void _notAllCenturyItemsLoaded({
    required List<ArtObject> nextPageArtObjects,
    required int nextFetchPage,
    required Emitter<ArtObjectListState> emit,
  }) {
    final List<ArtObjectListItem> nextPageListItems =
        nextPageArtObjects.map((e) => ArtObjectListItem(artObject: e)).toList();
    emit(state.copyWith(
      status: ArtObjectListStatus.success,
      listItems: List.of(state.listItems)..addAll(nextPageListItems),
      hasReachedMax: false,
      fetchPage: nextFetchPage,
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
