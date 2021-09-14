import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/pages/art_object_list/models/art_object_list_item.dart';

enum ArtObjectListStatus { initialLoading, success, failure }

class ArtObjectListState extends Equatable {
  const ArtObjectListState({
    this.status = ArtObjectListStatus.initialLoading,
    this.listItems = const <ArtObjectListItem>[],
    this.hasReachedMax = false,
    this.errorMessage = '',
    this.century = 21,
    this.fetchPage = 1,
  });

  final ArtObjectListStatus status;
  final List<ArtObjectListItem> listItems;
  final bool hasReachedMax;
  final String errorMessage;
  final int century;
  final int fetchPage;

  ArtObjectListState copyWith({
    ArtObjectListStatus? status,
    List<ArtObjectListItem>? listItems,
    bool? hasReachedMax,
    String? errorMessage,
    int? century,
    int? fetchPage,
  }) {
    return ArtObjectListState(
      status: status ?? this.status,
      listItems: listItems ?? this.listItems,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? '',
      century: century ?? this.century,
      fetchPage: fetchPage ?? this.fetchPage,
    );
  }

  @override
  List<Object> get props => [
        status,
        listItems,
        hasReachedMax,
        errorMessage,
        century,
      ];
}
