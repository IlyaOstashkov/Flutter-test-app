import 'package:equatable/equatable.dart';

class ArtObject extends Equatable {
  const ArtObject({
    required this.objectNumber,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.principalOrFirstMaker,
    required this.presentingDate,
  });

  final String objectNumber;
  final String title;
  final String? imageUrl;
  final String? description;
  final String? principalOrFirstMaker;
  final String? presentingDate;

  @override
  List<Object?> get props => [
        objectNumber,
        title,
        imageUrl,
        description,
        principalOrFirstMaker,
        presentingDate,
      ];
}
