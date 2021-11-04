import 'package:test_app_domain/test_app_domain.dart' as domain;

class ArtObjectDetailBlocTestData {
  static const correctObjectNumber = '1';
  static const errorObjectNumber = '2';
  static const errorCause = 'error cause';

  static domain.ArtObject artObjectPartialContent(bool isCorrectObjectNumber) {
    return domain.ArtObject(
      objectNumber:
          isCorrectObjectNumber ? correctObjectNumber : errorObjectNumber,
      title: 'title1',
      imageUrl: 'imageUrl1',
      description: null,
      principalOrFirstMaker: null,
      presentingDate: null,
    );
  }

  static domain.ArtObject artObjectFullContent() {
    return const domain.ArtObject(
      objectNumber: correctObjectNumber,
      title: 'title1',
      imageUrl: 'imageUrl1',
      description: 'description1',
      principalOrFirstMaker: 'principalOrFirstMaker1',
      presentingDate: 'presentingDate1',
    );
  }
}
