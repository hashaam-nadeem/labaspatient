import 'package:Labas/model/clinic.dart';
import 'package:Labas/model/doctor.dart';
import 'package:Labas/model/quick_appointment.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'dart:io';
class LocationProvider with ChangeNotifier {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData locationData;
  String address;
  changeAddress(String currentAddress) {
    address = currentAddress;
    notifyListeners();
  }

  List<Appointment> quickAppointmentDoctor;

  changeQuickAppointmentDoctors(List<Appointment> allDoctors) {
    quickAppointmentDoctor = allDoctors;
    notifyListeners();
  }

  changeLocationData(LocationData loc) {
    locationData = loc;
    notifyListeners();
  }

  clearData() {
    locationData = null;
    address = null;
  }

  getPatientLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    changeLocationData(locationData);
    var coordinates = Coordinates(
      locationData.latitude,
      locationData.longitude,
    );

    var findAddress =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var addresses = findAddress.first.addressLine;
    address = addresses;
    notifyListeners();
  }
}
