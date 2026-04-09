import 'package:shared_preferences/shared_preferences.dart';

Future setPatientPrefs(
  String patientId,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(
    "id",
    patientId,
  );
}

Future<String> getPatientPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("id");
}

Future setBearerToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
}

Future<String> getBearerToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}
setVisitingFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("UserVisited", true);
    print('True is called');
  }
  Future getVisitingFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool alreadyVisited = preferences.getBool("UserVisited") ?? false;
    return alreadyVisited;
  }

  setLanguage(String language) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("language", language);
    print('Language changed to: $language');
  }

  Future<String> getLaunguagePrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("language");
}
