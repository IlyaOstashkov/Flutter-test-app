import 'package:equatable/equatable.dart';
import 'package:test_app_domain/test_app_domain.dart';

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
