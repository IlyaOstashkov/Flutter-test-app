import 'package:rijks_api/rijks_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('RijksApiClient', () {
    late http.Client httpClient;
    late IRijksApiClient rijksApiClient;

    setUpAll(() {
      registerFallbackValue<Uri>(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      rijksApiClient = RijksApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require httpClient', () {
        expect(RijksApiClient(), isNotNull);
      });
    });

    group('getArtObjectList', () {
      const String apiKey = '0fiuZFh4';
      const int offset = 0;
      const int limit = 10;
      test('makes correct https request', () async {
        final MockResponse response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await rijksApiClient.getArtObjectList(
            offset: offset,
            limit: limit,
          );
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'www.rijksmuseum.nl',
              '/api/en/collection',
              <String, dynamic>{
                'key': apiKey,
                'p': '0',
                'ps': '10',
              },
            ),
          ),
        ).called(1);
      });

      test('throws ArtObjectRequestException on 400 status', () async {
        final MockResponse response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await await rijksApiClient.getArtObjectList(
            offset: offset,
            limit: limit,
          ),
          throwsA(isA<ArtObjectRequestException>()),
        );
      });

      test('throws ArtObjectEmptyResponseException on empty response',
          () async {
        final MockResponse response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await rijksApiClient.getArtObjectList(
            offset: offset,
            limit: limit,
          ),
          throwsA(isA<ArtObjectEmptyResponseException>()),
        );
      });

      test('returns List<ArtObject> on valid response', () async {
        final MockResponse response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {
            "elapsedMilliseconds": 0,
            "count": 727625,
            "countFacets": {
                "hasimage": 506807,
                "ondisplay": 8402
            },
            "artObjects": [
                {
                    "links": {
                        "self": "http://www.rijksmuseum.nl/api/en/collection/BK-17496",
                        "web": "http://www.rijksmuseum.nl/en/collection/BK-17496"
                    },
                    "id": "en-BK-17496",
                    "objectNumber": "BK-17496",
                    "title": "Blue Macaw",
                    "hasImage": true,
                    "principalOrFirstMaker": "Meissener Porzellan Manufaktur",
                    "longTitle": "Blue Macaw, Meissener Porzellan Manufaktur, 1731",
                    "showImage": true,
                    "permitDownload": true,
                    "webImage": {
                        "guid": "fb490c6f-638a-44a8-81d3-ea27a04eae46",
                        "offsetPercentageX": 0,
                        "offsetPercentageY": 0,
                        "width": 1822,
                        "height": 2500,
                        "url": "https://lh3.ggpht.com/5sc-SGzzgobkHnmnykUi4B1PqMtadoFqXOhYLQmsAI0Mcs_FeCoXT6loaiAUhr_zKvp2iyXntDxVhCzeVwjFulsjzRE=s0"
                    },
                    "headerImage": {
                        "guid": "a355f7dd-d274-4797-9d71-e8f2fb0661ec",
                        "offsetPercentageX": 0,
                        "offsetPercentageY": 0,
                        "width": 1822,
                        "height": 437,
                        "url": "https://lh3.ggpht.com/uXIT4pKPtocEUVmq6KZNWz4tSygyUZPi7HCCTq4big12nOUFBxJCIBM8vrDwepAM62ABjG-V6JnALRGgxJqWCfBLTQ=s0"
                    },
                    "productionPlaces": []
                }
              ]
            }
        ''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final List<ArtObject> list = await rijksApiClient.getArtObjectList(
          offset: offset,
          limit: limit,
        );
        expect(
          list,
          isA<List<ArtObject>>()
              .having((p0) => p0.isNotEmpty, 'is not empty', true),
        );
        final ArtObject firstElement = list.first;
        expect(
          firstElement,
          isA<ArtObject>()
              .having((p0) => p0.objectNumber, 'objectNumber', 'BK-17496')
              .having((p0) => p0.title, 'title', 'Blue Macaw')
              .having(
                (p0) => p0.principalOrFirstMaker,
                'principalOrFirstMaker',
                'Meissener Porzellan Manufaktur',
              ),
        );
        final WebImage? webImage = firstElement.webImage;
        expect(
          webImage,
          isA<WebImage>()
              .having((p0) => p0.guid, 'guid',
                  'fb490c6f-638a-44a8-81d3-ea27a04eae46')
              .having((p0) => p0.url, 'url',
                  'https://lh3.ggpht.com/5sc-SGzzgobkHnmnykUi4B1PqMtadoFqXOhYLQmsAI0Mcs_FeCoXT6loaiAUhr_zKvp2iyXntDxVhCzeVwjFulsjzRE=s0'),
        );
      });
    });
  });
}
