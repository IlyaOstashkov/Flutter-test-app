import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_domain/test_app_domain.dart';

import 'art_object_detail_event.dart';
import 'art_object_detail_state.dart';
import 'art_object_detail_state.dart';

class ArtObjectDetailBloc
    extends Bloc<ArtObjectDetailEvent, ArtObjectDetailState> {
  ArtObjectDetailBloc({required this.repository})
      : super(const ArtObjectDetailState.initialLoading()) {
    on<ArtObjectDetailPartialContentEvent>(_onPartialContentEvent);
  }

  final IArtObjectRepository repository;

  Future<void> _onPartialContentEvent(
    ArtObjectDetailPartialContentEvent event,
    Emitter<ArtObjectDetailState> emit,
  ) async {
    emit(ArtObjectDetailState.partialContent(event.artObject));
    emit(await _fetchDetailInfo(event.artObject.objectNumber));
  }

  Future<ArtObjectDetailState> _fetchDetailInfo(String objectNumber) async {
    try {
      final artObjectDetail = await repository.getArtObject(
        objectNumber: objectNumber,
      );
      return ArtObjectDetailState.fullContent(artObjectDetail);
    } on ApiClientRequestException catch (e) {
      return ArtObjectDetailState.error(e.cause);
    }
  }
}
