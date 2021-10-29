import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rijks_api/rijks_api.dart';
import 'package:test/test.dart';
import 'package:test_app_domain/test_app_domain.dart' as domain;

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('RijksApiClient', () {
    late http.Client httpClient;
    late domain.IApiClient rijksApiClient;
    const apiKey = '0fiuZFh4';

    setUpAll(() {
      registerFallbackValue<Uri>(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      rijksApiClient = RijksApiClient(httpClient: httpClient);
    });

    group('getArtObjectList', () {
      const page = 1;
      const limit = 10;
      const century = 21;
      test('makes correct https request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await rijksApiClient.getArtObjectList(
            page: page,
            limit: limit,
            century: century,
          );
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'www.rijksmuseum.nl',
              '/api/en/collection',
              <String, String>{
                'key': apiKey,
                'p': '1',
                'ps': '10',
                'technique': 'painting',
                'f.dating.period': '21',
              },
            ),
          ),
        ).called(1);
      });

      test('throws ArtObjectRequestException on 400 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => rijksApiClient.getArtObjectList(
            page: page,
            limit: limit,
            century: century,
          ),
          throwsA(isA<domain.ApiClientRequestException>()),
        );
      });

      test('returns List<ArtObject> on valid response', () async {
        final response = MockResponse();
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
        final list = await rijksApiClient.getArtObjectList(
          page: page,
          limit: limit,
          century: century,
        );
        expect(
          list,
          isA<List<domain.ArtObject>>()
              .having((p0) => p0.isNotEmpty, 'is not empty', true),
        );
        final firstElement = list.first;
        expect(
          firstElement,
          isA<domain.ArtObject>()
              .having((p0) => p0.objectNumber, 'objectNumber', 'BK-17496')
              .having((p0) => p0.title, 'title', 'Blue Macaw')
              .having(
                (p0) => p0.principalOrFirstMaker,
                'principalOrFirstMaker',
                'Meissener Porzellan Manufaktur',
              ),
        );
        expect(
          firstElement.imageUrl,
          'https://lh3.ggpht.com/5sc-SGzzgobkHnmnykUi4B1PqMtadoFqXOhYLQmsAI0Mcs_FeCoXT6loaiAUhr_zKvp2iyXntDxVhCzeVwjFulsjzRE=s0',
        );
      });
    });

    group('getArtObject', () {
      const objectNumber = 'BK-17496';
      test('makes correct https request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await rijksApiClient.getArtObject(objectNumber: objectNumber);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'www.rijksmuseum.nl',
              '/api/en/collection/BK-17496',
              <String, String>{
                'key': apiKey,
              },
            ),
          ),
        ).called(1);
      });

      test('throws ArtObjectRequestException on 400 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => rijksApiClient.getArtObject(objectNumber: objectNumber),
          throwsA(isA<domain.ApiClientRequestException>()),
        );
      });

      test('returns ArtObject on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {
            "elapsedMilliseconds": 135,
            "artObject": {
                "links": {
                    "search": "http://www.rijksmuseum.nl/api/nl/collection"
                },
                "id": "en-BK-1975-81",
                "priref": "293793",
                "objectNumber": "BK-1975-81",
                "language": "en",
                "title": "Cupboard",
                "copyrightHolder": null,
                "webImage": {
                    "guid": "3134064e-2449-4b00-97a3-3bb7471e8b69",
                    "offsetPercentageX": 50,
                    "offsetPercentageY": 28,
                    "width": 2026,
                    "height": 2500,
                    "url": "https://lh3.googleusercontent.com/tGI4dOAfJLBbewwspzXpUnSZxEKFACv9Y3FHqAxQUtN2p4AXt2MS9oFv6eJyIBtr7gvzmv58vSitMFVeHY0TGsfOfDN2=s0"
                },
                "colors": [],
                "colorsWithNormalization": [],
                "normalizedColors": [],
                "normalized32Colors": [],
                "titles": [],
                "description": "Eiken- en ebbenhouten kast belijmd met meerdere materialen. De vier deuren van de onder- en terugspringende bovenkast tonen verdiepte velden met kussens. De deuren en de schelpnis van de bovenkast worden gescheiden door hermatlanten. In het midden bevindt zich een lade met ramskop. De onderregel met lade vertoont verkroppingen. Op de hoeken geslingerde Corintische losstaande zuilen die een hoofdgestel dragen met versierde verkroppingen. Ingelegde paarlemoeren bloemen op de deuren, zuilen en hermschachten.",
                "labelText": null,
                "objectTypes": [
                    "furniture"
                ],
                "objectCollection": [],
                "makers": [],
                "principalMakers": [
                    {
                        "name": "Herman Doomer",
                        "unFixedName": "Doomer, Herman",
                        "placeOfBirth": null,
                        "dateOfBirth": null,
                        "dateOfBirthPrecision": null,
                        "dateOfDeath": null,
                        "dateOfDeathPrecision": null,
                        "placeOfDeath": null,
                        "occupation": [
                            "woodworker"
                        ],
                        "roles": [
                            "furniture worker"
                        ],
                        "nationality": null,
                        "biography": null,
                        "productionPlaces": [],
                        "qualification": null
                    }
                ],
                "plaqueDescriptionDutch": "In de nalatenschap van de Amsterdamse meubelmaker Herman Doomer bevond zich een kostbare ‘groote ebbekas met parlemoer ingeleydt’. Waarschijnlijk gaat het daarbij om dit meubel, dat helemaal is belijmd met ebbenhout en versierd met inlegwerk van paarlemoer. Met de schuin uitstekende hoeken en gedraaide zuilen was Doomers kast zijn tijd ver vooruit. ",
                "plaqueDescriptionEnglish": "Among the possessions left by cabinetmaker Herman Doomer of Amsterdam was a costly ‘large ebony cupboard inlaid with mother-of-pearl’. It was probably this piece of furniture, which is veneered entirely with ebony and decorated with mother-of-pearl inlay. With its diagonally protruding corners and twisted columns, Doomer’s cupboard was far ahead of its time. ",
                "principalMaker": "Herman Doomer",
                "artistRole": null,
                "associations": [],
                "acquisition": {
                    "method": "purchase",
                    "date": "1975-06-16T00:00:00",
                    "creditLine": null
                },
                "exhibitions": [],
                "materials": [
                    "wood (plant material)",
                    "oak (wood)",
                    "ebony (wood)",
                    "rosewood (wood)",
                    "mother of pearl",
                    "ivory"
                ],
                "techniques": [],
                "productionPlaces": [],
                "dating": {
                    "presentingDate": "c. 1635 - c. 1645",
                    "sortingDate": 1635,
                    "period": 17,
                    "yearEarly": 1635,
                    "yearLate": 1645
                },
                "classification": {
                    "iconClassIdentifier": [
                        "48A9833",
                        "48A9842",
                        "48C161"
                    ],
                    "iconClassDescription": [
                        "flowers ~ ornament",
                        "ram's head ~ ornament",
                        "column, pillar ~ architecture"
                    ],
                    "motifs": [],
                    "events": [],
                    "periods": [],
                    "places": [],
                    "people": [],
                    "objectNumbers": [
                        "BK-1975-81"
                    ]
                },
                "hasImage": true,
                "historicalPersons": [],
                "inscriptions": [],
                "documentation": [
                    "K. Posner en Robert van Langh [red.], Supporting Conservation : Four projects funded by Gieskes-Strijbis Fonds, Amsterdam 2015, p. 6, 15, afb. 1, 8, 9.",
                    "R. Baarsen, 'Collectie : Speurtocht in de eigen collectie', Rijksmuseum Kunstkrant 33 (2007), nr. 4, p. 20-23, afb."
                ],
                "catRefRPK": [],
                "principalOrFirstMaker": "Herman Doomer",
                "dimensions": [
                    {
                        "unit": "cm",
                        "type": "height",
                        "part": null,
                        "value": "220.5"
                    },
                    {
                        "unit": "cm",
                        "type": "width",
                        "part": null,
                        "value": "206.0"
                    },
                    {
                        "unit": "cm",
                        "type": "depth",
                        "part": null,
                        "value": "83.5"
                    }
                ],
                "physicalProperties": [],
                "physicalMedium": "wood (plant material)",
                "longTitle": "Cupboard, Herman Doomer, c. 1635 - c. 1645",
                "subTitle": "h 220.5cm × w 206.0cm × d 83.5cm",
                "scLabelLine": "Herman Doomer (c. 1595–1650), oak, veneered with ebony and mother-of-pearl, c. 1635–1645",
                "label": {
                    "title": "Cupboard",
                    "makerLine": "Herman Doomer (c. 1595–1650), oak, veneered with ebony and mother-of-pearl, c. 1635–1645",
                    "description": "In the early 17th century a new speciality – ebony joinery – was introduced in Amsterdam cabinetry. Ebony cabinetmakers produced furniture veneered in precious exotic woods such as ebony, entirely covering the heartwood carcass. Herman Doomer was Amsterdam’s most famous ebony cabinetmaker, and this cupboard is his masterpiece. Rembrandt, who admired Herman Doomer’s work, portrayed him and his wife in 1640.",
                    "notes": "Multimediatour",
                    "date": "2018-02-27"
                },
                "showImage": true,
                "location": "HG-2.8"
            },
            "artObjectPage": {
                "id": "en-BK-1975-81",
                "similarPages": [],
                "lang": "en",
                "objectNumber": "BK-1975-81",
                "tags": [],
                "plaqueDescription": "Among the possessions left by cabinetmaker Herman Doomer of Amsterdam was a costly ‘large ebony cupboard inlaid with mother-of-pearl’. It was probably this piece of furniture, which is veneered entirely with ebony and decorated with mother-of-pearl inlay. With its diagonally protruding corners and twisted columns, Doomer’s cupboard was far ahead of its time. ",
                "audioFile1": null,
                "audioFileLabel1": null,
                "audioFileLabel2": null,
                "createdOn": "0001-01-01T00:00:00",
                "updatedOn": "2012-09-18T14:06:32.799906+00:00",
                "adlibOverrides": {
                    "titel": null,
                    "maker": null,
                    "etiketText": null
                }
            }
        }
        ''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final artObject =
            await rijksApiClient.getArtObject(objectNumber: objectNumber);
        expect(
          artObject,
          isA<domain.ArtObject>()
              .having((p0) => p0.objectNumber, 'objectNumber', 'BK-1975-81')
              .having((p0) => p0.title, 'title', 'Cupboard')
              .having(
                (p0) => p0.description,
                'description',
                'Eiken- en ebbenhouten kast belijmd met meerdere materialen. De vier deuren van de onder- en terugspringende bovenkast tonen verdiepte velden met kussens. De deuren en de schelpnis van de bovenkast worden gescheiden door hermatlanten. In het midden bevindt zich een lade met ramskop. De onderregel met lade vertoont verkroppingen. Op de hoeken geslingerde Corintische losstaande zuilen die een hoofdgestel dragen met versierde verkroppingen. Ingelegde paarlemoeren bloemen op de deuren, zuilen en hermschachten.',
              )
              .having(
                (p0) => p0.principalOrFirstMaker,
                'principalOrFirstMaker',
                'Herman Doomer',
              ),
        );
        expect(
          artObject.imageUrl,
          'https://lh3.googleusercontent.com/tGI4dOAfJLBbewwspzXpUnSZxEKFACv9Y3FHqAxQUtN2p4AXt2MS9oFv6eJyIBtr7gvzmv58vSitMFVeHY0TGsfOfDN2=s0',
        );
        expect(
          artObject.presentingDate,
          'c. 1635 - c. 1645',
        );
      });
    });
  });
}
