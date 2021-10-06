import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rijks_api/rijks_api.dart';

class ArtObjectRequestException implements Exception {}

class ArtObjectEmptyResponseException implements Exception {}

abstract class IRijksApiClient {
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  });

  Future<ArtObject> getArtObject({required String objectNumber});
}

class RijksApiClient implements IRijksApiClient {
  RijksApiClient({required http.Client httpClient}) : _httpClient = httpClient;

  final http.Client _httpClient;

  static const _baseUrl = 'www.rijksmuseum.nl';
  static const _apiKey = '0fiuZFh4';
  static const _technique = 'painting';
  static const _timeoutSeconds = 3;

  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  }) async {
    final params = <String, String>{
      'key': _apiKey,
      'p': page.toString(),
      'ps': limit.toString(),
      'technique': _technique,
      'f.dating.period': century.toString(),
    };
    final Uri request = Uri.https(
      _baseUrl,
      '/api/en/collection',
      params,
    );
    final Map<String, dynamic> json = await _makeRequest(request);
    final ArtObjectPack pack = ArtObjectPack.fromJson(json);
    return pack.artObjects;
  }

  Future<ArtObject> getArtObject({required String objectNumber}) async {
    final params = <String, String>{
      'key': _apiKey,
    };
    final path = '/api/en/collection/$objectNumber';
    final Uri request = Uri.https(
      _baseUrl,
      path,
      params,
    );
    final Map<String, dynamic> json = await _makeRequest(request);
    final ArtObjectDetail detail = ArtObjectDetail.fromJson(json);
    return detail.artObject;
  }

  Future<Map<String, dynamic>> _makeRequest(Uri request) async {
    final http.Response response = await _httpClient.get(request).timeout(
          const Duration(seconds: _timeoutSeconds),
        );
    if (response.statusCode != 200) {
      throw ArtObjectRequestException();
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    if (json.isEmpty) {
      throw ArtObjectEmptyResponseException();
    }
    return json;
  }
}
