import 'dart:async';
import '../art_object_repository.dart';
import 'api_client_interface.dart';

abstract class IArtObjectRepository {
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  });

  Future<ArtObject> getArtObject({required String objectNumber});
}

class ArtObjectRepository implements IArtObjectRepository {
  ArtObjectRepository({required IApiClient apiClient}) : _apiClient = apiClient;

  final IApiClient _apiClient;

  @override
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  }) async {
    try {
      return await _apiClient.getArtObjectList(
        page: page,
        limit: limit,
        century: century,
      );
    } on ApiClientRequestException {
      // NOTE: we can add exception specific logic here
      rethrow;
    } on ApiClientEmptyResponseException {
      rethrow;
    }
  }

  @override
  Future<ArtObject> getArtObject({required String objectNumber}) async {
    try {
      return await _apiClient.getArtObject(objectNumber: objectNumber);
    } on ApiClientRequestException {
      // NOTE: we can add exception specific logic here
      rethrow;
    } on ApiClientEmptyResponseException {
      rethrow;
    }
  }
}
