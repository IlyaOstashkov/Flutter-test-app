import 'package:equatable/equatable.dart';

abstract class ArtObjectDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ArtObjectDetailFetchedEvent extends ArtObjectDetailEvent {}
