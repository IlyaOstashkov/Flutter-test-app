import 'package:freezed_annotation/freezed_annotation.dart';

part 'art_object_detail_event.freezed.dart';

@freezed
abstract class ArtObjectDetailEvent with _$ArtObjectDetailEvent {
  const factory ArtObjectDetailEvent.fetchFullContent(String objectNumber) =
      ArtObjectDetailEventFetchFullContent;
}
