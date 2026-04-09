import 'package:Labas/model/patient.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Patient _patient;
  Patient get patientData => _patient;
  TextEditingController nameTextEditingController = TextEditingController(),
      ageTextEditingController = TextEditingController(),
      addressTextEditingController = TextEditingController(),
      genderTextEditingController = TextEditingController();

  String patientAddress = 'Tap the button!';
  String mobileNumber = '';
  int index = 0;

  changeData({
    String name,
    String age,
    String address,
    int gender,
    String number,
  }) {
    nameTextEditingController.text = name;
    patientAddress = address;
    ageTextEditingController.text = age;
    index = gender;
    mobileNumber = number;
    print('Name is::: ${nameTextEditingController.text}');
    notifyListeners();
  }

  clearData() {
    nameTextEditingController.text = '';
    addressTextEditingController.text = '';
    ageTextEditingController.text = '';
    genderTextEditingController.text = '';
    patientAddress = 'Tap the button!';
    index = 0;
  }

  changePatientData(Patient patient) {
    _patient = patient;
    notifyListeners();
  }

  String bearerToken;
  changeBearerToken(String token) {
    bearerToken = token;
    notifyListeners();
  }
}
