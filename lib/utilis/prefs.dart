import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setUserLoginPrefs({
  @required String userId,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("userId", userId);
}

Future<String> getUserIdPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("userId");
}

Future setLanguagePrefs({@required String language}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("language", language ?? 'English');
}

Future<String> getLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("language");
}

Future clearPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
