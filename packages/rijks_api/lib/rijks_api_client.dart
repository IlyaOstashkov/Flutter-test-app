import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rijks_api/rijks_api.dart';

class ArtObjectListRequestException implements Exception {}

class ArtObjectListMappingException implements Exception {}

class ArtObjectDetailRequestException implements Exception {}

class ArtObjectDetailMappingException implements Exception {}

abstract class IRijksApiClient {
  Future<List<ArtObject>> getArtObjectList({
    required int offset,
    required int limit,
  });

  Future<ArtObject> getArtObject({required String objectNumber});
}

class RijksApiClient implements IRijksApiClient {
  RijksApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'www.rijksmuseum.nl';
  static const _apiKey = '0fiuZFh4';
  final http.Client _httpClient;

  Future<List<ArtObject>> getArtObjectList({
    required int offset,
    required int limit,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'key': _apiKey,
      'p': offset,
      'ps': limit,
    };
    final Uri request = Uri.https(
      _baseUrl,
      '/api/en/collection',
      params,
    );
    final Map<String, dynamic> json = await _getJson(
      request,
      ArtObjectListRequestException(),
      ArtObjectListMappingException(),
    );
    final ArtObjectPack pack = ArtObjectPack.fromJson(json);
    return pack.artObjects;
  }

  Future<ArtObject> getArtObject({required String objectNumber}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'key': _apiKey,
      'objectNumber': objectNumber,
    };
    final path = '/api/en/collection/$objectNumber';
    final Uri request = Uri.https(
      _baseUrl,
      path,
      params,
    );
    final Map<String, dynamic> json = await _getJson(
      request,
      ArtObjectDetailRequestException(),
      ArtObjectDetailMappingException(),
    );
    final ArtObjectDetail detail = ArtObjectDetail.fromJson(json);
    if (detail.artObject == null) {
      throw ArtObjectDetailMappingException();
    }
    return detail.artObject!;
  }

  Future<Map<String, dynamic>> _getJson(
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
    ) as Map<String, dynamic>;
    if (json.isEmpty) {
      throw emptyJsonException;
    }
    return json;
  }
}
