import 'package:art_object_repository/art_object_repository.dart';
import 'package:equatable/equatable.dart';

enum ArtObjectListStatus { initialLoading, success, failure }

class ArtObjectListState extends Equatable {
  const ArtObjectListState({
    this.status = ArtObjectListStatus.initialLoading,
    this.artObjects = const <ArtObject>[],
    this.hasReachedMax = false,
    this.errorMessage = '',
  });

  final ArtObjectListStatus status;
  final List<ArtObject> artObjects;
  final bool hasReachedMax;
  final String errorMessage;

  ArtObjectListState copyWith({
    ArtObjectListStatus? status,
    List<ArtObject>? artObjects,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return ArtObjectListState(
      status: status ?? this.status,
      artObjects: artObjects ?? this.artObjects,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? '',
    );
  }

  @override
  List<Object> get props => [
        status,
        artObjects,
        hasReachedMax,
      ];
}
