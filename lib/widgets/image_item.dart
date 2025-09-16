import 'package:uuid/uuid.dart';

final uuid = Uuid();

class ImageItem {
  ImageItem({
    required this.id,
    required this.imageUrl,
    required this.name,
  });
  
  final String id;
  final String imageUrl;
  final String name;

  
}