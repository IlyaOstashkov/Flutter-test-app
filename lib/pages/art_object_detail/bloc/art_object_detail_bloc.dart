import 'package:art_object_repository/art_object_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_event.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_state.dart';

class ArtObjectDetailBloc
    extends Bloc<ArtObjectDetailEvent, ArtObjectDetailState> {
  ArtObjectDetailBloc({
    required this.repository,
    required this.initialArtObject,
  }) : super(const ArtObjectDetailState());

  final IArtObjectRepository repository;
  final ArtObject initialArtObject;

  @override
  Stream<ArtObjectDetailState> mapEventToState(
      ArtObjectDetailEvent event) async* {
    if (event is ArtObjectDetailFetchedEvent) {
      yield await _mapArtObjectDetailFetchedEventToState();
    }
  }

  Future<ArtObjectDetailState> _mapArtObjectDetailFetchedEventToState() async {
    return state.copyWith(status: ArtObjectDetailStatus.success);
  }
}
