import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rijks_api/rijks_api.dart';

class ArtObjectListRequestException implements Exception {}

class ArtObjectListMappingException implements Exception {}

class ArtObjectDetailRequestException implements Exception {}

class ArtObjectDetailMappingException implements Exception {}

class RijksApiClient {
  RijksApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'www.rijksmuseum.nl/api/en';
  static const _apiKey = '0fiuZFh4';
  final http.Client _httpClient;

  Future<List<ArtObject>> getArtObjectList(
    int offset,
    int limit,
  ) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'key': _apiKey,
      'p': offset,
      'ps': limit,
    };
    final Uri request = Uri.https(
      _baseUrl,
      '/collection',
      params,
    );
    final json = await _getJson(
      request,
      ArtObjectListRequestException(),
      ArtObjectListMappingException(),
    );
    final ArtObjectPack pack =
        ArtObjectPack.fromJson(json.first as Map<String, dynamic>);
    return pack.artObjects;
  }

  Future<ArtObject> getArtObject(String objectNumber) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'key': _apiKey,
      'objectNumber': objectNumber,
    };
    final path = '/collection/$objectNumber';
    final Uri request = Uri.https(
      _baseUrl,
      path,
      params,
    );
    final json = await _getJson(
      request,
      ArtObjectDetailRequestException(),
      ArtObjectDetailMappingException(),
    );
    final ArtObjectDetail detail =
        ArtObjectDetail.fromJson(json.first as Map<String, dynamic>);
    return detail.artObject;
  }

  Future<List<dynamic>> _getJson(
    Uri request,
    Exception statusException,
    Exception emptyJsonException,
  ) async {
    final http.Response response = await _httpClient.get(request);
    if (response.statusCode != 200) {
      throw statusException;
    }
    final json = jsonDecode(
      response.body,
    ) as List;
    if (json.isEmpty) {
      throw emptyJsonException;
    }
    return json;
  }
}
