class Doctor {
  int id;
  String name;
  String title;
  String arabicTitle;
  String mobileNumber;
  String education;
  String services;
  String specialization;
  String experience;
  String longDescription;
  String shortDescription;
  String imageURL;
  int clinicId;
  int departmentId;
  var averageRatings;
  Doctor({
    this.id,
    this.name,
    this.title,
    this.arabicTitle,
    this.mobileNumber,
    this.education,
    this.services,
    this.specialization,
    this.experience,
    this.longDescription,
    this.shortDescription,
    this.imageURL,
    this.clinicId,
    this.departmentId,
    this.averageRatings,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'arabic_name': arabicTitle,
      'mobile': mobileNumber,
      'education': education,
      'services': services,
      'specialization': specialization,
      'experience': experience,
      'long_description': longDescription,
      'short_description': shortDescription,
      'image_path': imageURL,
      'clinic_id': clinicId,
      'department_id': departmentId,
      'averagerating': averageRatings ?? 0.0,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Doctor(
      id: map['id'],
      name: map['name'],
      title: map['title'],
      arabicTitle: map['arabic_name'],
      mobileNumber: map['mobileNumber'],
      education: map['education'],
      services: map['services'],
      specialization: map['specialization'],
      experience: map['experience'],
      longDescription: map['long_description'],
      shortDescription: map['short_description'],
      imageURL: map['image_path'],
      clinicId: map['clinic_id'],
      departmentId: map['department_id'],
      averageRatings: map['averagerating'] ?? 0.0,
    );
  }
}
