class Department {
  int id;
  String name;
  String arabicName;
  String imageURL;
  Department({
    this.id,
    this.name,
    this.arabicName,
    this.imageURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'arabic_name': arabicName,
      'image_path': imageURL,
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Department(
      id: map['id'],
      name: map['name'],
      arabicName: map['arabic_name'],
      imageURL: map['image_path'],
    );
  }
}
