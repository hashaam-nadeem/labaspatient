import 'package:Labas/model/insurances.dart';

class Clinic {
  var id;
  var name;
  var arabicName;
  var contactNo;
  var latitude;
  var longitude;
  var imageURL;
  var openingTime;
  var closingTime;
  List<Insurances> insurances;
  var averageRatings;
  Clinic({
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'arabicName': arabicName,
      'contactNo': contactNo,
      'latitude': latitude,
      'longitude': longitude,
      'imageURL': imageURL,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'insurances': insurances?.map((x) => x?.toMap())?.toList() ?? [],
      'averagerating': averageRatings ?? 0.0,
    };
  }

  factory Clinic.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) return null;

    return Clinic(
      id: map['id'],
      name: map['name'],
      arabicName: map['arabic_name'],
      contactNo: map['contact_no'],
      latitude: map['lat'],
      longitude: map['long'],
      imageURL: map['image'],
      openingTime: map['opening_time'],
      closingTime: map['closing_time'],
      insurances: List<Insurances>.from(
        map['insurances'].map(
          (x) => Insurances.fromMap(x) ?? [],
        ),
      ),
      averageRatings: map['averagerating'] ?? 0.0,
    );
  }
}
