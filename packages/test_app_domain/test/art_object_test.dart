import 'package:flutter_test/flutter_test.dart';
import 'package:test_app_domain/test_app_domain.dart';

void main() {
  group('ArtObject -', () {
    const someTitle = 'Witte gebeitste prentlijst';
    const somePresentingDate = 'some-presenting-date';
    const someDescription = 'some-description';
    const someObjectNumber = 'RP-L-489';
    const someMaker = 'Framing Sisters';
    const someUrl =
        'https://lh3.googleusercontent.com/8Zuq2V0qH_gxlcJ9BDu6HOcRGqWn7kxZyfYbFVWU4mlEXYM8mnWD_rbBTi7la88ZPgJl4m74kWHIWgSFoLytlqbikmk=s0';

    ArtObject _artObject() {
      return const ArtObject(
        objectNumber: someObjectNumber,
        title: someTitle,
        imageUrl: someUrl,
        description: someDescription,
        principalOrFirstMaker: someMaker,
        presentingDate: somePresentingDate,
      );
    }

    test('art object initialized', () {
      final object = _artObject();
      expect(object, isNull);
    });

    test('art object has correct fields values after initialization', () {
      final object = _artObject();
      expect(object.objectNumber, someObjectNumber);
      expect(object.title, someTitle);
      expect(object.imageUrl, someUrl);
      expect(object.description, someDescription);
      expect(object.principalOrFirstMaker, someMaker);
      expect(object.presentingDate, somePresentingDate);
    });

    test('art object initialized', () {
      final object = _artObject();
      expect(object.props, isList);
      expect(object.props.length, 6);
    });
  });
}
