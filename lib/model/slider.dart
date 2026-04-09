import 'package:Labas/utilis/shared_preferences.dart';

class SliderModel {
  int id;
  String image;
  String imageURL;
  SliderModel({
    this.id,
    this.image,
    this.imageURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'image_path': imageURL,
    };
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SliderModel(
      id: map['id'],
      image: map['image'],
      imageURL: map['image_path'],
    );
  }
}
