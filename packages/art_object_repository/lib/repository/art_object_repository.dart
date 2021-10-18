import 'dart:async';
import 'package:art_object_repository/models/art_object.dart';
import 'package:rijks_api/rijks_api.dart' as api;

class ArtObjectException implements Exception {}

abstract class IArtObjectRepository {
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  });

  Future<ArtObject> getArtObject({required String objectNumber});
}

class ArtObjectRepository implements IArtObjectRepository {
  ArtObjectRepository({required api.IRijksApiClient apiClient})
      : _apiClient = apiClient;

  final api.IRijksApiClient _apiClient;

  @override
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  }) async {
    try {
      final response = await _apiClient.getArtObjectList(
        page: page,
        limit: limit,
        century: century,
      );
      final artObjectList =
          response.map((e) => _mapArtObject(response: e)).toList();
      return artObjectList;
    } on api.ArtObjectRequestException {
      // NOTE: we can add exception specific logic here
      throw ArtObjectException();
    } on api.ArtObjectEmptyResponseException {
      throw ArtObjectException();
    }
  }

  @override
  Future<ArtObject> getArtObject({required String objectNumber}) async {
    try {
      final response =
          await _apiClient.getArtObject(objectNumber: objectNumber);
      final artObject = _mapArtObject(response: response);
      return artObject;
    } on api.ArtObjectRequestException {
      // NOTE: we can add exception specific logic here
      throw ArtObjectException();
    } on api.ArtObjectEmptyResponseException {
      throw ArtObjectException();
    }
  }

  ArtObject _mapArtObject({required api.ArtObject response}) {
    return ArtObject(
      objectNumber: response.objectNumber,
      title: response.title ?? '',
      imageUrl: response.webImage?.url,
      description: response.description,
      principalOrFirstMaker: response.principalOrFirstMaker,
      presentingDate: response.dating?.presentingDate,
    );
  }
}
