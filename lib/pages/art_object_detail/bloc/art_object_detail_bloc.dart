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
  ArtObjectDetailBloc({
    required this.repository,
    required ArtObject artObject,
  }) : super(ArtObjectDetailState.initialContent(artObject)) {
    on<ArtObjectDetailFetchFullContentEvent>(_onInitialEvent);
  }

  final IArtObjectRepository repository;

  Future<void> _onInitialEvent(
    ArtObjectDetailFetchFullContentEvent event,
    Emitter<ArtObjectDetailState> emit,
  ) async {
    emit(await _fetchDetailInfo(event));
  }

  Future<ArtObjectDetailState> _fetchDetailInfo(
      ArtObjectDetailFetchFullContentEvent event) async {
    try {
      final artObjectDetail = await repository.getArtObject(
        objectNumber: event.objectNumber,
      );
      return ArtObjectDetailState.fullContent(artObjectDetail);
    } on ApiClientRequestException {
      return const ArtObjectDetailState.error(FetchErrorConstants.serverError);
    } on PlatformException catch (e) {
      return ArtObjectDetailState.error(
          e.message ?? FetchErrorConstants.serverError);
    } on SocketException catch (_) {
      return const ArtObjectDetailState.error(
          FetchErrorConstants.noInternetConnection);
    } on TimeoutException {
      return const ArtObjectDetailState.error(FetchErrorConstants.timeout);
    } catch (e) {
      return const ArtObjectDetailState.error(
          FetchErrorConstants.undefinedError);
    }
  }
}
