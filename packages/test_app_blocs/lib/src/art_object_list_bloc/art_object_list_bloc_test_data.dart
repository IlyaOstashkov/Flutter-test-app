import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_domain/test_app_domain.dart' as domain;

class ArtObjectListBlocTestData {
  static const limit = 10;
  static const century = 21;
  static const someHeader = '21 century';

  static domain.ArtObject artObject(int number) {
    return domain.ArtObject(
      objectNumber: number.toString(),
      title: 'title ${number.toString()}',
      imageUrl: null,
      description: null,
      principalOrFirstMaker: null,
      presentingDate: null,
    );
  }

  static ArtObjectListViewModel header() {
    return const ArtObjectListViewModel(
      isHeader: true,
      headerTitle: someHeader,
    );
  }

  static List<ArtObjectListViewModel> listItems(
      List<domain.ArtObject?> artObjects) {
    return artObjects
        .map((e) => ArtObjectListViewModel(
              artObject: e,
              isHeader: false,
              headerTitle: '',
            ))
        .toList();
  }

  static ArtObjectListState contentStateWithHeaderAnd2Items() {
    return ArtObjectListState.content([
      ArtObjectListBlocTestData.header(),
      ...listItems([
        ArtObjectListBlocTestData.artObject(1),
        ArtObjectListBlocTestData.artObject(2),
      ])
    ], false, ArtObjectListBlocTestData.century, 1);
  }
}
