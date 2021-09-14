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
      : super(const ArtObjectListState());

  final IArtObjectRepository repository;

  static const _limit = 10;
  static const _throttleMilliseconds = 500;
  static const _startCentury = 21;
  static const _endCentury = 19;
  static const _startFetchPage = 1;

  @override
  Stream<Transition<ArtObjectListEvent, ArtObjectListState>> transformEvents(
    Stream<ArtObjectListEvent> events,
    TransitionFunction<ArtObjectListEvent, ArtObjectListState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: _throttleMilliseconds)),
      transitionFn,
    );
  }

  @override
  Stream<ArtObjectListState> mapEventToState(ArtObjectListEvent event) async* {
    if (event is ArtObjectListFetchedEvent) {
      yield await _mapArtObjectListFetchedEventToState();
    } else if (event is ArtObjectListFullReloadEvent) {
      yield await _mapArtObjectListReloadEventToState();
    }
  }

  Future<ArtObjectListState> _mapArtObjectListReloadEventToState() async {
    // plan to fetch art objects
    Future.delayed(Duration(milliseconds: 500), () {
      add(ArtObjectListFetchedEvent());
    });
    return const ArtObjectListState();
  }

  Future<ArtObjectListState> _mapArtObjectListFetchedEventToState() async {
    if (state.hasReachedMax) return state;
    try {
      // initial loading
      if (state.status == ArtObjectListStatus.initialLoading) {
        final List<ArtObject> nextPageArtObjects =
            await repository.getArtObjectList(
          page: _startFetchPage,
          limit: _limit,
          century: _startCentury,
        );
        final List<ArtObjectListItem> nextPageListItems = nextPageArtObjects
            .map((e) => ArtObjectListItem(artObject: e))
            .toList();
        final List<ArtObjectListItem> listItems = [
          _headerItem(_startCentury),
        ]..addAll(nextPageListItems);
        return state.copyWith(
          status: ArtObjectListStatus.success,
          listItems: listItems,
          hasReachedMax: false,
          century: _startCentury,
          fetchPage: _startFetchPage,
        );
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
        // all items loaded for all centuries
        if (state.century == _endCentury) {
          return state.copyWith(
            hasReachedMax: true,
            fetchPage: nextFetchPage,
          );
        }
        // all items loaded for current century
        final int nextCentury = state.century - 1;
        final ArtObjectListItem nextCenturyHeaderItem =
            _headerItem(nextCentury);
        // plan to fetch art objects for next century
        Future.delayed(Duration(milliseconds: 500), () {
          add(ArtObjectListFetchedEvent());
        });
        return state.copyWith(
          century: nextCentury,
          listItems: List.of(state.listItems)..add(nextCenturyHeaderItem),
          fetchPage: 0,
        );
      }
      // not all items in century loaded
      final List<ArtObjectListItem> nextPageListItems = nextPageArtObjects
          .map((e) => ArtObjectListItem(artObject: e))
          .toList();
      return state.copyWith(
        status: ArtObjectListStatus.success,
        listItems: List.of(state.listItems)..addAll(nextPageListItems),
        hasReachedMax: false,
        fetchPage: nextFetchPage,
      );
    } on ArtObjectException {
      return state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: FetchErrorConstants.serverError,
      );
    } on PlatformException catch (e) {
      return state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: e.message,
      );
    } on SocketException catch (_) {
      return state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: FetchErrorConstants.noInternetConnection,
      );
    } on TimeoutException {
      return state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: FetchErrorConstants.timeout,
      );
    } catch (e) {
      print(e);
      return state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: FetchErrorConstants.undefinedError,
      );
    }
  }

  ArtObjectListItem _headerItem(int century) {
    return ArtObjectListItem(
      isHeader: true,
      headerTitle: century.toString() + ' century',
    );
  }
}
