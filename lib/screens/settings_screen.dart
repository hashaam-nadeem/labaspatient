import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/location_provider.dart';
import 'package:Labas/provider/user_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/all_appointments_screen.dart';
import 'package:Labas/screens/contactUs.dart';
import 'package:Labas/screens/edit_profile_screen.dart';
import 'package:Labas/screens/profile_screen.dart';
import 'package:Labas/utilis/shared_preferences.dart';
import 'package:share/share.dart';
import 'package:Labas/screens/update_password.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/globals.dart';
import 'package:Labas/utilis/prefs.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    var _userProvider = Provider.of<UserProvider>(context);
    var _dataProvider = Provider.of<DataProvider>(context);
    var _locationProvider = Provider.of<LocationProvider>(context);
    return SafeArea(
      child: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: width,
                  height: height * .22,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipPath(
                          clipper: OvalBottomBorderClipper(),
                          child: Container(
                            height: height * .22,
                            width: width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [greenColor, mainColor]),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(width * .13),
                                    bottomRight: Radius.circular(width * .13))),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: width,
                            height: height * .18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(width * .9),
                                    bottomRight: Radius.circular(width * .9))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GradientText(
                                        "${getTranslated(context, "setting")}",
                                        gradient: LinearGradient(colors: [
                                          mainColor,
                                          greenColor,
                                        ]),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(3),
                                      width: width * .3,
                                      height: height * .06,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [greenColor, mainColor]),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: width * .3,
                                          height: height * .06,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Center(
                                              child: Icon(
                                            Icons.settings,
                                            color: greenColor,
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Container(
            //   height: height * .08,
            //   width: width,
            //   color: mainColor,
            //   child: Center(
            //     child: Text(
            //       getTranslated(context, 'account'),
            //       style: labelTextStyle.copyWith(
            //         fontSize: width * .04,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListTile(
                leading: Text(
                  getTranslated(context, 'allAppointments'),
                  style: labelTextStyle.copyWith(
                    fontSize: width * .04,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: greenColor,
                  size: width * .05,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Material(
                        child: AllAppointmentScreen(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListTile(
                leading: Text(
                  getTranslated(context, 'editProfile'),
                  style: labelTextStyle.copyWith(
                    fontSize: width * .04,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: greenColor,
                  size: width * .05,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Material(
                        child: EditProfileScreen(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListTile(
                leading: Text(
                  getTranslated(context, 'changePassword'),
                  style: labelTextStyle.copyWith(
                      fontSize: width * .04, color: Colors.black87
                      // fontWeight: FontWeight.bold
                      ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: greenColor,
                  size: width * .05,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Material(
                        child: UpdatePasswordScreen(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListTile(
                leading: Text(
                  getTranslated(context, 'contactUs'),
                  style: labelTextStyle.copyWith(
                      fontSize: width * .04, color: Colors.black87
                      // fontWeight: FontWeight.bold
                      ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: greenColor,
                  size: width * .05,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Material(
                        child: ContactUs(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListTile(
                leading: Text(
                  getTranslated(context, 'share'),
                  style: labelTextStyle.copyWith(
                      fontSize: width * .04, color: Colors.black87
                      // fontWeight: FontWeight.bold
                      ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: greenColor,
                  size: width * .05,
                ),
                onTap: () async {
                  await Share.share("https://play.google.com/store/apps/details?id=com.brightqtr.labas.Labas",
                      subject: 'This is Labbas application');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Divider(
                height: height * 0.01,
                //color: Colors.black54,
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTranslated(context, 'general'),
                      style: labelTextStyle.copyWith(
                        fontSize: width * .05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Text(
                    getTranslated(context, 'setting'),
                    style: labelTextStyle.copyWith(
                      fontSize: width * .05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListTile(
                leading: Text(
                  _widgetProvider.languageIndex == 1 ? 'العربية' : 'English',
                  style: labelTextStyle.copyWith(
                    fontSize: width * .04,
                  ),
                ),
                trailing: Icon(
                  Icons.g_translate,
                  size: width * .05,
                ),
                onTap: () {
                  print(_widgetProvider.languageIndex);

                  if (_widgetProvider.languageIndex == 1) {
                    changeLanguage('ar', context);
                    setLanguage("Arabic");
                    _widgetProvider.changeLanguageIndex(2);
                  } else if (_widgetProvider.languageIndex == 2) {
                    setLanguage("English");
                    changeLanguage('en', context);
                    _widgetProvider.changeLanguageIndex(1);
                  } else {
                    changeLanguage('en', context);
                    setLanguage("English");
                    _widgetProvider.changeLanguageIndex(1);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListTile(
                leading: Text(
                  getTranslated(context, 'Log Out'),
                  style: labelTextStyle.copyWith(
                    fontSize: width * .04,
                  ),
                ),
                trailing: Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: greenColor,
                  size: width * .054,
                ),
                onTap: () async {
                  _userProvider.clearData();
                  _widgetProvider.clearData();
                  _dataProvider.clearData();
                  _locationProvider.clearData();
                  clearPrefs();
                  _widgetProvider.changeTabbarIndex(0);
                  Future.delayed(Duration(milliseconds: 500), () {
                    _widgetProvider.changeTabbarIndex(1);
                  });
                  await setVisitingFlag();
                  if (_widgetProvider.languageIndex == 1) {
                    // changeLanguage('ar', context);
                    setLanguage("English");
                    // _widgetProvider.changeLanguageIndex(2);
                  } else if (_widgetProvider.languageIndex == 2) {
                    // changeLanguage('en', context);
                    setLanguage("Arabic");
                    // _widgetProvider.changeLanguageIndex(1);
                  } else {
                    setLanguage("English");
                    //changeLanguage('en', context);
                    //_widgetProvider.changeLanguageIndex(1);
                  }

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
