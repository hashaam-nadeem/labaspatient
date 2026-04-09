import 'package:Labas/bloc/connectivity.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../main.dart';

BlocClass myBloc;
void changeLanguage(String language, BuildContext context) async {
  Locale _locale = await setLocale(language);
  MyApp.setLocale(context, _locale);
}

final imageURL =
    "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop";
final center = LatLng(45.52, -122.67);

final imagePath = "/uploads/thumbnail/";
