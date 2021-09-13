import 'package:equatable/equatable.dart';

abstract class ArtObjectListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ArtObjectListFetchedEvent extends ArtObjectListEvent {}
