import 'package:uuid/uuid.dart';

final uuid = Uuid();

class ImageItem {
  final String id;
  final String imageUrl;
  final String description;

  ImageItem({
    required this.id,
    required this.imageUrl,
    required this.description,
  });
}