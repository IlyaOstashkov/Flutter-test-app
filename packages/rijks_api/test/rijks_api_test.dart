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
    late RijksApiClient rijksApiClient;

    setUpAll(() {
      registerFallbackValue<Uri>(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      rijksApiClient = RijksApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(RijksApiClient(), isNotNull);
      });
    });

    group('getArtObjectList', () {
      const apiKey = '0fiuZFh4';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await rijksApiClient.getArtObjectList(
            offset: 0,
            limit: 10,
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
    });
  });
}
