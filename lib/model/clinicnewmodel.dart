class ClinicNewModel {
  final bool withError;
  final String shortMessage;
  final List<ClinicResult> result;

  ClinicNewModel({
    this.withError,
    this.result,
    this.shortMessage,
  });

  factory ClinicNewModel.fromJson(Map<String, dynamic> json) {
    return ClinicNewModel(
      // withError: json['error'],
      // shortMessage: json['message'],
      result: (json['clinic'] as List)
              .map((e) => ClinicResult.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ClinicResult {
  int id;
  String name;
  String arabicName;
  String contactNo;
  double latitude;
  double longitude;
  String imageURL;
  String openingTime;
  String closingTime;
  List<insuranceResult> insurances;
  var averageRatings;
  ClinicResult({
    this.id,
    this.name,
    this.arabicName,
    this.contactNo,
    this.latitude,
    this.longitude,
    this.imageURL,
    this.openingTime,
    this.closingTime,
    this.insurances,
    this.averageRatings,
  });

  factory ClinicResult.fromJson(Map<String, dynamic> json) {
    return ClinicResult(
      insurances: (json['insurances'] as List)
              .map((e) => insuranceResult.fromJson(e))
              .toList() ??
          [],
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      arabicName: json['arabic_name'] ?? 0.0,
      contactNo: json['contact_no'] ?? 0.0,
      latitude: json['lat'] ?? "",
      longitude: json['long'] ?? "",
      openingTime: json['opening_time'] ?? "",
      closingTime: json['closing_time'] ?? "",
      imageURL: json['image'] ?? "",
      averageRatings: json['averagerating'] ?? "",
    );
  }
}

class insuranceResult {
  int id;
  int clinicId;
  int insuranceId;
  Insurancees insurance;
  insuranceResult({
    this.id,
    this.clinicId,
    this.insuranceId,
    this.insurance,
  });
  factory insuranceResult.fromJson(Map<String, dynamic> json) {
    return insuranceResult(
      insurance: json['insurance'] == null
          ? null
          : Insurancees.fromJson(json['insurance']),
      id: json['id'],
      clinicId: json['clinic_id'],
      insuranceId: json['insurance_id'],
    );
  }
}

class Insurancees {
  int id;
  String name;
  String arabicName;
  String imagePath;
  Insurancees({
    this.id,
    this.name,
    this.arabicName,
    this.imagePath,
  });
  factory Insurancees.fromJson(Map<String, dynamic> json) {
    return Insurancees(
      id: json['id'],
      name: json['name'],
      arabicName: json['arabic_name'],
      imagePath: json['image_path'],
    );
  }
}
