// coverage:ignore-file
import 'package:freezed_annotation/freezed_annotation.dart';

import 'view_models/art_object_list_view_model.dart';
part 'art_object_list_state.freezed.dart';

@freezed
abstract class ArtObjectListState with _$ArtObjectListState {
  const factory ArtObjectListState.initialLoading() =
      _ArtObjectListStateInitialLoading;
  const factory ArtObjectListState.content(
    List<ArtObjectListViewModel> listItems,
    bool reachedMax,
    int century,
    int fetchPage,
  ) = _ArtObjectListStateContent;
  const factory ArtObjectListState.error(String errorMessage) =
      _ArtObjectListStateError;
}
