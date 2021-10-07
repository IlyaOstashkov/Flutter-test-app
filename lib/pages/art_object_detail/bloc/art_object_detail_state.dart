import 'package:art_object_repository/art_object_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'art_object_detail_state.freezed.dart';

@freezed
abstract class ArtObjectDetailState with _$ArtObjectDetailState {
  const factory ArtObjectDetailState.initialContent(ArtObject artObject) =
      _ArtObjectDetailStateInitialContent;
  const factory ArtObjectDetailState.fullContent(ArtObject artObject) =
      _ArtObjectDetailStateFullContent;
  const factory ArtObjectDetailState.error(String errorMessage) =
      _ArtObjectDetailStateError;
}
