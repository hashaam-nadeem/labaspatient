import 'package:Labas/model/slider.dart';
import 'package:Labas/utilis/globals.dart';
import 'package:flutter/material.dart';

class WidgetProvider with ChangeNotifier {
  Icon icon = Icon(
    Icons.visibility,
    color: Colors.black,
  );
  changeIcon(Icon newIcon) {
    icon = newIcon;
    notifyListeners();
  }

  int languageIndex;
  changeLanguageIndex(int index) {
    languageIndex = index;
    notifyListeners();
  }

  List<SliderModel> sliderImages;

  init() {
    icon = Icon(Icons.clear);
    languageIndex = 1;
    tabIconIndex = 1;
    profileTabIndex = 1;
    categoryIndex = 0;
    listLength = 3;
    image = imageURL;
    doctorTabbarIndex = 1;
    specialisation = "Specialisation";
  }

  clearData() {
    bottomIndex = 0;
    profileTabIndex = 1;
    categoryIndex = 0;
    tabIconIndex = 1;
    doctorTabbarIndex = 1;
  }

  int bottomIndex = 0;
  changeBottomIndex(int index) {
    bottomIndex = index;
    notifyListeners();
  }

  int tabIconIndex;
  changeTabbarIndex(int index) {
    tabIconIndex = index;
    notifyListeners();
  }

  int profileTabIndex;
  changeProfileTabIndex(int index) {
    profileTabIndex = index;
    notifyListeners();
  }

  int categoryIndex;
  changeCategoryIndex(int index) {
    categoryIndex = index;
    notifyListeners();
  }

  WidgetProvider() {
    init();
  }

  String specialisation;
  changeSpecialisation(String spec) {
    specialisation = spec;
    notifyListeners();
  }

  String image;
  changeImageURL(String img) {
    image = img;
    notifyListeners();
  }

  int listLength;
  changeListLength(int index) {
    listLength = index;
    notifyListeners();
  }

  int doctorTabbarIndex;
  changeDoctorTabbarIndex(int i) {
    doctorTabbarIndex = i;
    notifyListeners();
  }
}
