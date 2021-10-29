import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_event.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_state.dart';
import 'package:test_app_domain/test_app_domain.dart';

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
    } on ApiClientRequestException catch (e) {
      return ArtObjectDetailState.error(e.message);
    }
  }
}
