import 'dart:async';
import 'dart:io';

import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/constants/fetch_error_constants.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_event.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_state.dart';

class ArtObjectDetailBloc
    extends Bloc<ArtObjectDetailEvent, ArtObjectDetailState> {
  ArtObjectDetailBloc({required this.repository})
      : super(const ArtObjectDetailState());

  final IArtObjectRepository repository;

  @override
  Stream<ArtObjectDetailState> mapEventToState(
      ArtObjectDetailEvent event) async* {
    if (event is ArtObjectDetailInitialEvent) {
      yield state.copyWith(artObject: event.artObject);
      yield await _fetchDetailInfo(event);
    }
  }

  Future<ArtObjectDetailState> _fetchDetailInfo(
      ArtObjectDetailInitialEvent event) async {
    if (state.status != ArtObjectDetailStatus.initialLoading) {
      return state;
    }
    try {
      final ArtObject artObjectDetail = await repository.getArtObject(
        objectNumber: event.artObject.objectNumber,
      );
      return state.copyWith(
        status: ArtObjectDetailStatus.success,
        artObject: artObjectDetail,
      );
    } on ArtObjectException {
      return state.copyWith(
        status: ArtObjectDetailStatus.failure,
        errorMessage: FetchErrorConstants.serverError,
      );
    } on PlatformException catch (e) {
      return state.copyWith(
        status: ArtObjectDetailStatus.failure,
        errorMessage: e.message,
      );
    } on SocketException catch (_) {
      return state.copyWith(
        status: ArtObjectDetailStatus.failure,
        errorMessage: FetchErrorConstants.noInternetConnection,
      );
    } on TimeoutException {
      return state.copyWith(
        status: ArtObjectDetailStatus.failure,
        errorMessage: FetchErrorConstants.timeout,
      );
    } catch (e) {
      return state.copyWith(
        status: ArtObjectDetailStatus.failure,
        errorMessage: FetchErrorConstants.undefinedError,
      );
    }
  }
}
