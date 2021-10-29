import '../models/art_object.dart';

class ApiClientRequestException implements Exception {
  const ApiClientRequestException({required this.message});
  final String message;
}

abstract class IApiClient {
  Future<List<ArtObject>> getArtObjectList({
    required int page,
    required int limit,
    required int century,
  });

  Future<ArtObject> getArtObject({required String objectNumber});
}
