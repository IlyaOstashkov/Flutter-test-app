import 'dart:io';

import 'package:art_object_repository/art_object_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/constants/fetch_constants.dart';
import 'package:rxdart/rxdart.dart';

import 'art_object_list_event.dart';
import 'art_object_list_state.dart';

class ArtObjectListBloc extends Bloc<ArtObjectListEvent, ArtObjectListState> {
  ArtObjectListBloc({required this.repository})
      : super(const ArtObjectListState());

  final IArtObjectRepository repository;

  static const _limit = 10;
  static const _throttleMilliseconds = 500;

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
      yield await _mapArtObjectListFetchedEventToState(state);
    }
  }

  Future<ArtObjectListState> _mapArtObjectListFetchedEventToState(
      ArtObjectListState state) async {
    if (state.hasReachedMax) return state;
    final int nextPage = _nextPage(state);
    try {
      final nextPageList = await repository.getArtObjectList(
        page: nextPage,
        limit: _limit,
        century: 21,
      );
      if (state.status == ArtObjectListStatus.initialLoading) {
        return state.copyWith(
          status: ArtObjectListStatus.success,
          artObjects: nextPageList,
          hasReachedMax: false,
        );
      }
      return nextPageList.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ArtObjectListStatus.success,
              artObjects: List.of(state.artObjects)..addAll(nextPageList),
              hasReachedMax: false,
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
    } on Exception {
      return state.copyWith(
        status: ArtObjectListStatus.failure,
        errorMessage: FetchErrorConstants.undefinedError,
      );
    }
  }

  int _currentPage(ArtObjectListState state) {
    final int count = state.artObjects.length;
    final int page = count ~/ _limit;
    final int remainder = count % _limit;
    return remainder == 0 ? page : page + 1;
  }

  int _nextPage(ArtObjectListState state) {
    return _currentPage(state) + 1;
  }
}
