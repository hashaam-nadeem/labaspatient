import 'dart:convert';

import 'package:Labas/model/clinic.dart';

class Appointment {
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
  String departmentName;
  String imageURL;
  Clinic clinic;
  var averageRatings;

  Appointment({
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
    this.departmentName,
    this.imageURL,
    this.clinic,
    this.averageRatings,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'arabic_title': arabicTitle,
      'mobile': mobileNumber,
      'education': education,
      'services': services,
      'specialization': specialization,
      'experience': experience,
      'long_description': longDescription,
      'short_description': shortDescription,
      'department_name': departmentName,
      'image_path': imageURL,
      'clinic': clinic?.toMap(),
      'averagerating': averageRatings ?? 0.0,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Appointment(
      id: map['id'],
      name: map['name'],
      title: map['title'],
      arabicTitle: map['arabic_title'],
      mobileNumber: map['mobile'],
      education: map['education'],
      services: map['services'],
      specialization: map['specialization'],
      experience: map['experience'],
      longDescription: map['long_description'],
      shortDescription: map['short_description'],
      departmentName: map['department_name'],
      imageURL: map['image_path'],
      clinic: Clinic.fromMap(map['clinic']),
      averageRatings: map['averagerating'] ?? 0.0,
    );
  }
}
