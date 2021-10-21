import 'package:art_object_repository/art_object_repository.dart';
import 'package:art_object_repository/models/art_object.dart';
import 'package:art_object_repository/repository/art_object_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockRijksApiClient extends Mock implements IApiClient {}

void main() {
  group('ArtObjectRepository', () {
    late IApiClient apiClient;
    late ArtObjectRepository artObjectRepository;
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

    setUp(() {
      apiClient = MockRijksApiClient();
      artObjectRepository = ArtObjectRepository(apiClient: apiClient);
    });

    group('getArtObjectList', () {
      const page = 1;
      const limit = 10;
      const century = 21;
      test('calls getArtObjectList with correct parameters', () async {
        try {
          await artObjectRepository.getArtObjectList(
            page: page,
            limit: limit,
            century: century,
          );
        } catch (_) {}
        verify(() => apiClient.getArtObjectList(
              page: page,
              limit: limit,
              century: century,
            )).called(1);
      });

      test('throws when getArtObjectList fails', () async {
        final exception = Exception('custom-exception');
        when(() => apiClient.getArtObjectList(
              page: page,
              limit: limit,
              century: century,
            )).thenThrow(exception);
        expect(
          () async => artObjectRepository.getArtObjectList(
            page: page,
            limit: limit,
            century: century,
          ),
          throwsA(exception),
        );
      });

      test('returns correct ArtObject on success', () async {
        when(() => apiClient.getArtObjectList(
              page: page,
              limit: limit,
              century: century,
            )).thenAnswer(
          (_) async => [_artObject()],
        );
        final actual = await artObjectRepository.getArtObjectList(
          page: page,
          limit: limit,
          century: century,
        );
        expect(
          actual,
          [_artObject()],
        );
      });
    });

    group('getArtObject', () {
      test('calls getArtObject with correct parameters', () async {
        try {
          await artObjectRepository.getArtObject(
            objectNumber: someObjectNumber,
          );
        } catch (_) {}
        verify(
          () => apiClient.getArtObject(objectNumber: someObjectNumber),
        ).called(1);
      });

      test('throws when getArtObject fails', () async {
        final exception = Exception('custom-exception');
        when(
          () => apiClient.getArtObject(objectNumber: someObjectNumber),
        ).thenThrow(exception);
        expect(
          () async => artObjectRepository.getArtObject(
            objectNumber: someObjectNumber,
          ),
          throwsA(exception),
        );
      });

      test('returns correct ArtObject on success', () async {
        when(() => apiClient.getArtObject(objectNumber: someObjectNumber))
            .thenAnswer(
          (_) async => _artObject(),
        );
        final actual = await artObjectRepository.getArtObject(
          objectNumber: someObjectNumber,
        );
        expect(
          actual,
          _artObject(),
        );
      });
    });
  });
}
