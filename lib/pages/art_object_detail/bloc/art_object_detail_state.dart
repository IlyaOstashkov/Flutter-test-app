import 'package:art_object_repository/art_object_repository.dart';
import 'package:equatable/equatable.dart';

enum ArtObjectDetailStatus { initialLoading, success, failure }

class ArtObjectDetailState extends Equatable {
  const ArtObjectDetailState({
    this.status = ArtObjectDetailStatus.initialLoading,
    this.artObject,
    this.errorMessage = '',
  });

  final ArtObjectDetailStatus status;
  final ArtObject? artObject;
  final String errorMessage;

  ArtObjectDetailState copyWith({
    ArtObjectDetailStatus? status,
    ArtObject? artObject,
    String? errorMessage,
  }) {
    return ArtObjectDetailState(
      status: status ?? this.status,
      artObject: artObject ?? this.artObject,
      errorMessage: errorMessage ?? '',
    );
  }

  @override
  List<Object?> get props => [
        status,
        artObject,
        errorMessage,
      ];
}
