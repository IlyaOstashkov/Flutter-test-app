import '../art_object_repository.dart';

class ApiClientRequestException implements Exception {}

class ApiClientEmptyResponseException implements Exception {}

abstract class IApiClient {
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  });

  Future<ArtObject> getArtObject({required String objectNumber});
}
