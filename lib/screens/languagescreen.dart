import 'dart:ffi';

import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/emergency_screen.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/globals.dart';
import 'package:Labas/utilis/routes.dart';
import 'package:Labas/utilis/shared_preferences.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/poweredBy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class Languages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Languages();
  }
}

class _Languages extends State<Languages> {
  var width, height;
  @override
  Widget build(BuildContext context) {
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    // TODO: implement build
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: powered(context),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(width * .1),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              mainColor.withOpacity(0.2),
              mainColor.withOpacity(0.2),
              containerColor.withOpacity(0.3),
              mainColor.withOpacity(0.2),
              containerColor
            ])),
        child: Column(
              children: [
            SizedBox(
              height: height * .04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  appLogo,
                  width: width * .5,
                  height: height * .15,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  labas_text,
                  width: width * .5,
                  height: height * .14,
                )
              ],
            ),
            SizedBox(
              height: height * .18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    _widgetProvider.changeLanguageIndex(1);
                    changeLanguage('en', context);
                    await setVisitingFlag();
                    String language = await getLaunguagePrefs();
                    print('Selected Language: $language');
                    setLanguage("English");
                    AppRoutes.replace(context, EmergencyScreen());
                    //AppRoutes.replace(context, LoginScreen());
                  },
                  child: Container(
                    width: width * .3,
                    height: height * .06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent,
                        border: Border.all(
                            color: mainColor.withOpacity(0.2), width: 2)),
                    child: Center(
                      child: Text(
                        "English",
                        style: headingStyle.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    _widgetProvider.changeLanguageIndex(2);
                    await setVisitingFlag();
                    String language = await getLaunguagePrefs();
                    print('Selected Language: $language');
                    setLanguage("Arbic");
                    changeLanguage('ar', context);
                    AppRoutes.replace(context, EmergencyScreen());
                  },
                  child: Container(
                    width: width * .3,
                    height: height * .06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent,
                        border: Border.all(
                            color: mainColor.withOpacity(0.2), width: 2)),
                    child: Center(
                      child: Text(
                        "Arabic",
                        style: headingStyle.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select your Language",
                  style: headingStyle.copyWith(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
     ),
      ),
    );
  }
}
