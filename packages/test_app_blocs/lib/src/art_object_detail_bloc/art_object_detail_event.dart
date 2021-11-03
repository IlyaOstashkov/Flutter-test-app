import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app_domain/test_app_domain.dart';
part 'art_object_detail_event.freezed.dart';

@freezed
abstract class ArtObjectDetailEvent with _$ArtObjectDetailEvent {
  const factory ArtObjectDetailEvent.initialLoad(ArtObject artObject) =
      ArtObjectDetailPartialContentEvent;
}
