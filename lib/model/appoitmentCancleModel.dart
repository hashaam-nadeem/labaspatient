class NotificationModel {
  final NotificationResult result;

  NotificationModel({
    this.result,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      result: NotificationResult.fromJson(json),
    );
  }
}

class NotificationResult {
  var id;
  var clinic_id;
  var department_id;
  var time_per_patient;
  var name;
  var arabic_name;
  var mobile;
  var password;
  var education;
  var services;
  var specialization;
  var experience;
  var long_description;
  var short_description;
  Images images;
  var active;
  NotificationResult(
      {this.active,
      this.arabic_name,
      this.clinic_id,
      this.department_id,
      this.education,
      this.experience,
      this.id,
      this.images,
      this.long_description,
      this.mobile,
      this.name,
      this.password,
      this.services,
      this.short_description,
      this.specialization,
      this.time_per_patient});

  factory NotificationResult.fromJson(Map<String, dynamic> json) {
    return NotificationResult(
      images: Images.fromJson(json['image_path']),
      id: json['id'],
      clinic_id: json['clinic_id'],
      department_id: json['department_id'],
      name: json['name'] ?? "",
      arabic_name: json['arabic_name'] ?? "",
      mobile: json['mobile'] ?? "",
      education: json['education'] ?? "",
      services: json['services'],
      specialization: json['specialization'],
      experience: json['experience'] ?? "",
      long_description: json['long_description'] ?? "",
      short_description: json['short_description'] ?? "",
    );
  }
}

class Images {
  String thumbnail;
  String original;
  String normal;
  Images({this.thumbnail, this.original, this.normal});
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      thumbnail: json['thumbnail'] ?? 0,
      original: json['orignal'] ?? "",
      normal: json['normal'] ?? "",
    );
  }
}
