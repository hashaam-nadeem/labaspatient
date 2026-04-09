import 'dart:async';
import 'dart:convert';

import 'package:Labas/app_router.dart';
import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/locator.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/login_screen.dart';
import 'package:Labas/screens/main_screen.dart';
import 'package:Labas/services/fcm_registration.dart';
import 'package:Labas/services/navigation_service.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/shared_preferences.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/labas_button.dart';
import 'package:Labas/widgets/loading_bottom_sheet.dart';
import 'package:Labas/widgets/poweredBy.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EmergencyScreen extends StatefulWidget {
  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  //var _navigationService = locator<NavigationService>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ApiClient apiClient = ApiClient();

  @override
  void initState() {
    super.initState();

    fcmRegistration();
    apiClient.getDepartments(context);
  }

  fcmRegistration() {
    //Future.delayed(Duration(seconds: 1), () {
    //Firebase_Notification().setupfirebase(context, _scaffoldKey);
  }

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    //Firebase_Notification().setupfirebase(context, _scaffoldKey);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context);

    var _dataProvider = Provider.of<DataProvider>(context);
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: powered(context),
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
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
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: height * .01,
                ),
                SizedBox(
                  height: width * .5,
                  width: width * .5,
                  child: Image.asset(
                    appLogo,
                    fit: BoxFit.fill,
                  ),
                ),
                Image.asset(
                  labas_text,
                  width: width * .4,
                  height: height * .12,
                ),
                SizedBox(
                  height: height * .02,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      getTranslated(context,
                          'If you are experiencing a medical emergency, exit and call 999.'),
                      style: labelTextStyle.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .10,
                ),
                GestureDetector(
                  onTap: () async {
                    String token = await getBearerToken();
                    if (token == null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false);
                    } else {
                      //Show Dialog
                      ArsProgressDialog progressDialog = ArsProgressDialog(
                          context,
                          blur: 2,
                          backgroundColor: Color(0x33000000),
                          animationDuration: Duration(milliseconds: 500));
                      progressDialog.show();
                      // showBottomLoading(
                      //   context,
                      //   title: getTranslated(context, 'loading'),
                      //   message: getTranslated(context, 'pleaseStickWithUs'),
                      // );
                      await apiClient.getProfile(context);
                      await apiClient.getSliderImages(context: context);
                      await apiClient.getDepartments(context);
                      await apiClient.getInsurances(context);
                      //Dismiss Dialog
                      progressDialog.dismiss();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MainScreen()),
                          (Route<dynamic> route) => false);
                    }
                    //sendAndRetrieveMessage();
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
                        getTranslated(context, 'Continue'),
                        style: headingStyle.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 16,
                //   ),
                //   child: LabasButton(
                //     title: 'Continue            موافق',
                //     onPress: () async {
                //       String token = await getBearerToken();
                //       if (token == null) {
                //         _navigationService.navigateAndRemoveUntil(
                //           AppRoute.loginScreen,
                //         );
                //       } else {
                //         showBottomLoading(
                //           context,
                //           title: getTranslated(context, 'loading'),
                //           message: getTranslated(context, 'pleaseStickWithUs'),
                //         );
                //         await apiClient.getProfile(context);
                //         await apiClient.getSliderImages(context: context);
                //         await apiClient.getDepartments(context);
                //         await apiClient.getInsurances(context);
                //         _navigationService.navigateAndRemoveUntil(
                //           AppRoute.mainScreen,
                //         );
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final String serverToken =
      'AAAAaSbGMBU:APA91bGcy0HpdlelI_Rfjs_Y4e3yTmeT_HsdpdsyW8_ugrN9X362PGzgDTP2svDKR-PkMaNgJKdJTFYXT6PKlHo0oV3GfRLxtjn-Dxu5tgPvyrIjL9CeTeRp1RBDJAHMuix_nViOS-6_';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    print("hel;podksadsaz");
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to':
              "fyTsYYEHQxCva_413g-qsq:APA91bFT96pu8cot9pnfwBYFh7gZ7rscJlFVKgC5DhV-7XtS2I16jlPPbt3x79Q1JRr4Sy4s6Pv11CnxGYhitn-8x-ZzFzxs_m5ZSfUy2ZehasHu6-M_YHmKkNvgLWNXKuzIW7aghsxE",
        },
      ),
    );

    // return completer.future;
  }
}
