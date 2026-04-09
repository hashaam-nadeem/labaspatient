class Insurance {
  var id;
  var name;
  var arabicName;
  var imagePath;
  Insurance({
    this.id,
    this.name,
    this.arabicName,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'arabic_name': arabicName,
      'image_path': imagePath,
    };
  }

  factory Insurance.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Insurance(
      id: map['id'],
      name: map['name'],
      arabicName: map['arabic_name'],
      imagePath: map['image_path'],
    );
  }
}
