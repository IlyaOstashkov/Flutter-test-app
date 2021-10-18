import 'package:art_object_repository/art_object_repository.dart';
import 'package:equatable/equatable.dart';

class ArtObjectListViewModel extends Equatable {
  const ArtObjectListViewModel({
    this.isHeader = false,
    this.headerTitle = '',
    this.artObject,
  });

  final bool isHeader;
  final String headerTitle;
  final ArtObject? artObject;

  @override
  List<Object?> get props => [
        isHeader,
        headerTitle,
        artObject,
      ];
}
