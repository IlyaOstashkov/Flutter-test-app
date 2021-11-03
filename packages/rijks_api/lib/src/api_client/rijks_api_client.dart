import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rijks_api/src/models/models.dart';
import 'package:test_app_domain/test_app_domain.dart' as domain;

class FetchErrorConstants {
  static const String serverError = 'Could not get data from the server';
  static const String noInternetConnection = 'No internet connection';
  static const String timeout =
      'The time for the request is over. Try again later';
  static const String undefinedError =
      'Undefined error. Please write to app support';
}

class RijksApiClient implements domain.IApiClient {
  RijksApiClient({required http.Client httpClient}) : _httpClient = httpClient;

  final http.Client _httpClient;

  static const _baseUrl = 'www.rijksmuseum.nl';
  static const _apiKey = '0fiuZFh4';
  static const _technique = 'painting';
  static const _timeoutSeconds = 3;

  @override
  Future<List<domain.ArtObject>> getArtObjectList({
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
    final request = Uri.https(
      _baseUrl,
      '/api/en/collection',
      params,
    );
    final json = await _makeRequest(request);
    final pack = ArtObjectPack.fromJson(json);
    return pack.artObjects.map((e) => _mapArtObject(response: e)).toList();
  }

  @override
  Future<domain.ArtObject> getArtObject({required String objectNumber}) async {
    final params = <String, String>{
      'key': _apiKey,
    };
    final path = '/api/en/collection/$objectNumber';
    final request = Uri.https(
      _baseUrl,
      path,
      params,
    );
    final json = await _makeRequest(request);
    final detail = ArtObjectDetail.fromJson(json);
    return _mapArtObject(response: detail.artObject);
  }

  Future<Map<String, dynamic>> _makeRequest(Uri request) async {
    try {
      final response = await _httpClient.get(request).timeout(
            const Duration(seconds: _timeoutSeconds),
          );
      if (response.statusCode != 200) {
        throw const domain.ApiClientRequestException(
            cause: FetchErrorConstants.serverError);
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json;
    } on PlatformException {
      throw const domain.ApiClientRequestException(
          cause: FetchErrorConstants.serverError);
    } on SocketException catch (_) {
      throw const domain.ApiClientRequestException(
          cause: FetchErrorConstants.noInternetConnection);
    } on TimeoutException {
      throw const domain.ApiClientRequestException(
          cause: FetchErrorConstants.timeout);
    } catch (e) {
      throw const domain.ApiClientRequestException(
          cause: FetchErrorConstants.undefinedError);
    }
  }

  domain.ArtObject _mapArtObject({required ArtObject response}) {
    return domain.ArtObject(
      objectNumber: response.objectNumber,
      title: response.title ?? '',
      imageUrl: response.webImage?.url,
      description: response.description,
      principalOrFirstMaker: response.principalOrFirstMaker,
      presentingDate: response.dating?.presentingDate,
    );
  }
}
