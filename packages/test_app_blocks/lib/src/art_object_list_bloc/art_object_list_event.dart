import 'package:freezed_annotation/freezed_annotation.dart';
part 'art_object_list_event.freezed.dart';

@freezed
abstract class ArtObjectListEvent with _$ArtObjectListEvent {
  const factory ArtObjectListEvent.fetched() = ArtObjectListFetchedEvent;
  const factory ArtObjectListEvent.fullReload() = ArtObjectListFullReloadEvent;
}
