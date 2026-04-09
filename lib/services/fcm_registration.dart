import 'dart:async';

import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/model/appoitmentCancleModel.dart';
import 'package:Labas/model/doctor.dart';
import 'package:Labas/screens/doctor_profile_screen.dart';
import 'package:Labas/screens/emergency_screen.dart';
import 'package:Labas/screens/home_screen.dart';
import 'package:Labas/screens/languagescreen.dart';
import 'package:Labas/screens/main_screen.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'dart:convert';
import 'dart:io';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bot_toast/bot_toast.dart';

import '../app_router.dart';
import '../locator.dart';
import 'navigation_service.dart';

// ignore: camel_case_types
class Firebase_Notification {
  final BuildContext context;
  ApiClient apiClient = ApiClient();
  // var _navigationService = locator<NavigationService>();
  Firebase_Notification(this.context);
  FirebaseMessaging _firebaseMessaging;

  void setupfirebase(_navigatorKey, navigatorKey) {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners(_navigatorKey, navigatorKey);
  }

  // ignore: non_constant_identifier_names
  void firebaseCloudMessaging_Listeners(_navigatorKey, navigatorKey) {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      var response = message['data']['title'];
      FlutterBeep.playSysSound(41);
      // BotToast.showSimpleNotification(
      //     title: "$response",
      //     backgroundColor: Colors.white,
      //     //   closeIcon: null,
      //     hideCloseButton: true,
      //     titleStyle: headingStyle.copyWith(
      //         color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300));
      Future.delayed(Duration(seconds: 2), () {
        navigationAfterNotification(message, navigatorKey);
      });
    }, onResume: (Map<String, dynamic> message) async {
      //_navigateToItemDetail(message);
      print('on Resume $message');
      ArsProgressDialog progressDialog = ArsProgressDialog(context,
          blur: 2,
          backgroundColor: Color(0x33000000),
          animationDuration: Duration(milliseconds: 500));
      progressDialog.show();
      Future.delayed(Duration(seconds: 2), () {
        navigationAfterNotification(message, navigatorKey);
        progressDialog.dismiss();
      });
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     content: ListTile(
      //       title: Text(message['notification']['title']),
      //       subtitle: Text(message['notification']['body']),
      //     ),
      //     actions: <Widget>[
      //       FlatButton(
      //         child: Text('Ok'),
      //         onPressed: () => Navigator.of(context).pop(),
      //       ),
      //     ],
      //   ),
      // );
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');

      // String response = (message['notification']['title']);
      // if (response == 'Reminder') {
      //   BotToast.showSimpleNotification(
      //       title: "${message['notification']['body']}",
      //       backgroundColor: Colors.blueGrey,
      //       //   closeIcon: null,
      //       hideCloseButton: true,
      //       titleStyle: headingStyle.copyWith(
      //           color: Colors.black,
      //           fontSize: 14,
      //           fontWeight: FontWeight.w300));
      //   //return;
      // } else {
      //   // print(response);
      //   var res = message['data']['data'];
      //   print(res);

      //   var dd = json.decode(res);
      //   var doctor = dd['doctor'];
      //   print('Doctor name: ${doctor['name']}');
      //   print('Doctor department_id: ${doctor['department_id']}');
      //   print('Doctor services: ${doctor['services']}');
      //   print('Doctor short_description: ${doctor['short_description']}');
      //   print('Doctor specialization: ${doctor['specialization']}');
      //   print('Doctor mobile: ${doctor['mobile']}');
      //   print('Doctor long_description: ${doctor['long_description']}');
      //   print('Doctor education: ${doctor['education']}');
      //   print('Doctor experience: ${doctor['experience']}');
      //   print('Doctor id: ${doctor['id']}');
      //   print('Doctor clinic_id: ${doctor['clinic_id']}');
      //   print('Doctor name: ${doctor['name']}');
      //   print('Doctor averagerating: ${doctor['averagerating']}');
      //   // print('Page is:${dd['data']['page']}');
      //   // if (dd['data']['page'] != null) {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => DoctorProfileScreen(
      //                 departmentId: doctor['department_id'].toString(),
      //                 doctorName: doctor['name'],
      //                 services: doctor['services'],
      //                 shortDescription: doctor['short_description'],
      //                 specialization: doctor['specialization'],
      //                 mobileNumber: doctor['mobile'],
      //                 longDescription: doctor['long_description'],
      //                 education: doctor['education'],
      //                 experience: doctor['experience'],
      //                 imageURL: APINetwork.BASE_URL + doctor['image_path'],
      //                 doctorId: doctor['id'].toString(),
      //                 clinicId: doctor['clinic_id'].toString(),
      //                 clinicName: doctor['name'],
      //                 averageRatings: doctor['averagerating'] != null
      //                     ? double.parse(doctor['averagerating'].toString())
      //                     : 0.0,
      //               )));
      //   // Future.delayed(
      //   //   Duration(seconds: 3), () {
      //   //     navigatorKey.currentState.push(MaterialPageRoute(
      //   //     builder: (_) => ));
      //   // });

      // }
      Future.delayed(Duration(seconds: 3), () {
        navigationAfterNotification(message, navigatorKey);
      });
      //   ArsProgressDialog progressDialog = ArsProgressDialog(context,
      //       blur: 2,
      //       backgroundColor: Color(0x33000000),
      //       animationDuration: Duration(milliseconds: 500));
      //   progressDialog.show();
      //   //_navigateToItemDetail(message);

      //   String response = (message['notification']['title']);
      //   await apiClient.getProfile(context);
      //   await apiClient.getSliderImages(context: context);
      //   await apiClient.getDepartments(context);
      //   await apiClient.getInsurances(context);
      //   progressDialog.dismiss();

      //   // _navigationService.navigateAndRemoveUntil(
      //   //   AppRoute.mainScreen,
      //   // );
      //   updateDialog(context);
      // },
    });
  }

  // void _navigateToItemDetail(Map<String, dynamic> message) {
  //   final Item item = _itemForMessage(message);
  //   // Clear away dialogs
  //   Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
  //   if (!item.route.isCurrent) {
  //     Navigator.push(context, item.route);
  //   }
  // }

  navigationAfterNotification(message, navigatorKey) {
    NotificationModel notificationModel = NotificationModel();
    // print('on Message $message');
    // print('First ride complete message');
    // String titl = (message['data']['title']);
    // print('title is: $titl');
    print("MESSAGE: $message");
    String response =
        Platform.isIOS ? (message["title"]) : (message['data']['title']);
    print(response);
    //String response = (message['data']['title']);
    if (response == 'Reminder') {
      BotToast.showSimpleNotification(
          title: Platform.isIOS ? message['body'] : message['data']['body'],
          backgroundColor: Colors.blueGrey,
          //   closeIcon: null,
          hideCloseButton: true,
          titleStyle: headingStyle.copyWith(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300));
      //return;
    } else {
      // print(response);
      var res = Platform.isIOS ? (message['data']) : (message['data']['data']);
      // var res = message['data']['data'];
      //print(res);

      var dd = json.decode(res);
      var doctor = dd['doctor'];
      // print('Doctor name: ${doctor['name']}');
      // print('Doctor department_id: ${doctor['department_id']}');
      // print('Doctor services: ${doctor['services']}');
      // print('Doctor short_description: ${doctor['short_description']}');
      // print('Doctor specialization: ${doctor['specialization']}');
      // print('Doctor mobile: ${doctor['mobile']}');
      // print('Doctor long_description: ${doctor['long_description']}');
      // print('Doctor education: ${doctor['education']}');
      // print('Doctor experience: ${doctor['experience']}');
      // print('Doctor id: ${doctor['id']}');
      // print('Doctor clinic_id: ${doctor['clinic_id']}');
      // print('Doctor name: ${doctor['name']}');
      // print('Doctor averagerating: ${doctor['averagerating']}');
      // print('Page is:${dd['data']['page']}');
      // if (dd['data']['page'] != null) {
      //Future.delayed(Duration(seconds: 3), () {
      navigatorKey.currentState.push(MaterialPageRoute(
          builder: (_) => DoctorProfileScreen(
                departmentId: doctor['department_id'].toString(),
                doctorName: doctor['name'],
                services: doctor['services'],
                shortDescription: doctor['short_description'],
                specialization: doctor['specialization'],
                mobileNumber: doctor['mobile'],
                longDescription: doctor['long_description'],
                education: doctor['education'],
                experience: doctor['experience'],
                imageURL: APINetwork.BASE_URL + doctor['image_path'],
                doctorId: doctor['id'].toString(),
                clinicId: doctor['clinic_id'].toString(),
                clinicName: doctor['name'],
                averageRatings: doctor['averagerating'] != null
                    ? double.parse(doctor['averagerating'].toString())
                    : 0.0,
              )));
      // });
    }
  }

  void updateDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.transparent,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(15.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                  width: MediaQuery.of(context).size.width * .7,
                  height: MediaQuery.of(context).size.height * .32,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              width: MediaQuery.of(context).size.width * .7,
                              height: MediaQuery.of(context).size.height * .25,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .06,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        getTranslated(
                                            context, "appointmentCanceled"),
                                        style: headingStyle.copyWith(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ))),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .1,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.ban,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ));
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}

class Item {
  Item({this.itemId});
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }
}
