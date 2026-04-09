import 'dart:convert';
import 'package:Labas/model/appointment_detail.dart';
import 'package:Labas/model/clinic.dart';
import 'package:Labas/model/department.dart';
import 'package:Labas/model/doctor.dart';
import 'package:Labas/model/insurance.dart';
import 'package:Labas/model/slot.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  int _screenIndex = 0;
  int totalPages;
  int get screenIndex => _screenIndex;
  String listRatingdata;

  setIndex(int i) {
    _screenIndex = i;
    notifyListeners();
  }

  setRatings(listrating, index) {
    ratings[index] = double.parse(listrating.toString());
    print("helloo: ${ratings[0]}");
    // notifyListeners();
  }

  settotalPage(value) {
    totalPages = value;
    // notifyListeners();
  }

  int getPages() {
    return totalPages;
  }

  String _language;
  String get language => _language;
  changeLanguage(String language) {
    _language = language ?? 'English';
    notifyListeners();
  }

  List<double> ratings;
  List<Department> allDepartments;

  List<Department> filterList;
  List<Clinic> allClinics;



  changeClinicData(List<Clinic> clinicList) {
    allClinics = clinicList;
    notifyListeners();
  }

  List<Insurance> eachClinicInsuranceList;

  Future<List<Doctor>> getDoctors(BuildContext context,
      {@required String clinicId, String departmentId}) async {
    BotToast.showCustomLoading(
      toastBuilder: (c) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    allDoctors = [];

    Map body;
    if (departmentId.isEmpty) {
      body = {
        "clinic_id": clinicId,
      };
    } else {
      body = {
        "clinic_id": clinicId,
        "department_id": departmentId,
      };
    }
    print(body);
    await http
        .post(
      APINetwork.BASE_URL + APINetwork.GET_DOCTORS,
      body: body,
    )
        .then((value) async {
      var response = json.decode(value.body);
      print("doctor response: $response");
      if (!response['error']) {
        await response['data'].forEach((e) {
          Doctor doctor = Doctor.fromMap(e);
          if (doctor.id != null) {
            if (!allDoctors.contains(doctor.id)) {
              allDoctors.add(doctor);
              // ratings.add(double.parse(doctor.averageRatings.toString()));
              //  setRatings(doctor.averageRatings, e);
            }
          } else {
            allDoctors = [];
          }
        });

        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    });
    BotToast.closeAllLoading();
    print(allDoctors);

    return allDoctors;
  }

  String clinicAddress = '';
  changeClinicAddress(String address) {
    clinicAddress = address;
    notifyListeners();
  }


  int departmentStyle = 1;
  changeDepartmentStyle(int style) {
    departmentStyle = style;
    notifyListeners();
  }

  List<Doctor> allDoctors;
  changeDoctorsData(List<Doctor> doctor) {
    allDoctors = doctor;
    notifyListeners();
  }

  List<Slot> slots;
  getAllSlots(List<Slot> slot) {
    slots = slot;
    notifyListeners();
  }

  List<Clinic> listofClinics;
  changeListOfAllAppointments(List<Clinic> clinic) {
    listofClinics = clinic;
    notifyListeners();
  }

  List<Insurance> insuranceData;
  changeInsuranceData(List<Insurance> data) {
    insuranceData = data;
    notifyListeners();
  }

  Doctor doctor;
  String clinicId;
  String currentDate;
  String clinicName;
  String departmentName;
  String departmentNa;
  String patientName;
  String doctorName;

  clearData() {
    doctor = null;
    clinicId = null;
    currentDate = null;
    clinicName = null;
    departmentName = null;
    patientName = null;
    doctorName = null;
  }

  changeCurrentDate(String date) {
    currentDate = date;
    notifyListeners();
  }

  int clinicStyle = 1;
  changeClinicStyle(int style) {
    clinicStyle = style;
    notifyListeners();
  }

  int departmentSelectedIndex;
  changeSelectedDepartmentIndex(int index) {
    departmentSelectedIndex = index;
    notifyListeners();
  }

  List<AppointmentDetail> allAppointments;
}

final listener = DataProvider();
