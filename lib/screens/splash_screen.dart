import 'package:Labas/app_router.dart';
import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language.dart';
import 'package:Labas/locator.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/emergency_screen.dart';
import 'package:Labas/screens/languagescreen.dart';
import 'package:Labas/services/fcm_registration.dart';
import 'package:Labas/services/navigation_service.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/routes.dart';
import 'package:Labas/utilis/shared_preferences.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/poweredBy.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final languageCode;
  final navigatorKey;

  SplashScreen({
    Key key,
    this.navigatorKey,
    this.languageCode,
  }) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // var _navigationService = locator<NavigationService>();
  // final GlobalKey<NavigatorState> navigatorKey =
  //     new GlobalKey<NavigatorState>();
  ApiClient apiClient = ApiClient();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool visitingFlag;
  void firebaseCloudMessagingToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    //SharedPreferences localStorage = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken().then((token) {
      print("Mobile Token is: $token");
      setState(() {
        print("tokennnnn; $token");
        //User.userData.notificationToken = token;
      });
      //print(User.userData.notificationToken);
      //localStorage.setString('notificationToken', token);
    }).catchError((onError) {
      print(onError);
    });
  }

  void checkUserStatus() async {
    visitingFlag = await getVisitingFlag();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingToken();
    checkUserStatus();
    checkLanguage();
    // Locale myLocale = Localizations.localeOf(context);
    // print("Language code is: ${myLocale.languageCode}");
    Firebase_Notification(context)
        .setupfirebase(_scaffoldKey, widget.navigatorKey);

    if (widget.languageCode == "ar") {
      Provider.of<WidgetProvider>(context, listen: false)
          .changeLanguageIndex(1);
    } else {
      Provider.of<WidgetProvider>(context, listen: false)
          .changeLanguageIndex(2);
    }
    Future.delayed(
      Duration(
        seconds: 1,
      ),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    visitingFlag == true ? EmergencyScreen() : Languages()));
        //AppRoutes.replace(context, Languages());
      },
    );
  }

  checkLanguage() async {
    String language = await getLaunguagePrefs();
    print('Selected language is: $language');
    if (language == "Arbic") {
      Provider.of<WidgetProvider>(context, listen: false)
          .changeLanguageIndex(2);
    } else if (language == "English") {
      Provider.of<WidgetProvider>(context, listen: false)
          .changeLanguageIndex(1);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: powered(context),
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
          ],
        ),
      ),
    );
  }
}
