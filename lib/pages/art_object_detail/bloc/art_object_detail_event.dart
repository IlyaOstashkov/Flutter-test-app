import 'package:art_object_repository/art_object_repository.dart';
import 'package:equatable/equatable.dart';

abstract class ArtObjectDetailEvent extends Equatable {
  const ArtObjectDetailEvent();

  @override
  List<Object> get props => [];
}

class ArtObjectDetailInitialEvent extends ArtObjectDetailEvent {
  const ArtObjectDetailInitialEvent(this.artObject);

  final ArtObject artObject;

  @override
  List<Object> get props => [artObject];
}
