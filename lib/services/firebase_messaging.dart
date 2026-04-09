// import 'dart:io';
// import 'package:SathaCaptain/locator.dart';
// import 'package:SathaCaptain/provider/data_provider.dart';
// import 'package:SathaCaptain/provider/driver_provider.dart';
// import 'package:SathaCaptain/services/navigation_service.dart';
// import 'package:SathaCaptain/utilis/prefs.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class PushNotificationService {
//   Future init({@required BuildContext context}) async {
//     final FirebaseMessaging _fcm = FirebaseMessaging();
//     String token = await _fcm.getToken();
//     String deviceToken = await getDeviceToken();
//     var _dataProvider = Provider.of<DataProvider>(context, listen: false);
//     var _driverProvider = Provider.of<DriverProvider>(context, listen: false);

//     //FIREBASE PUSH NOTIFICATION INITIALISATION AND CONFIGURATION
//     if (_dataProvider.isPushNotificationEnabled) {
//       if (token == deviceToken) {
//         try {
//           if (Platform.isIOS) {
//             await _fcm.requestNotificationPermissions(
//               const IosNotificationSettings(
//                 sound: true,
//                 badge: true,
//                 alert: true,
//                 provisional: true,
//               ),
//             );
//             _fcm.onIosSettingsRegistered.listen((settings) async {
//               print("$settings");
//             });
//           }
//           _fcm.configure(
//             onMessage: (Map<String, dynamic> message) async {
//               _dataProvider.setShowPopUp(true ?? false, message ?? {}, context);
//               _driverProvider.setIsVehiclePicked(false);
//               Provider.of<DriverProvider>(context, listen: false)
//                   .checkCurrentTripStatus('');
//             },
//           );
//         } on PlatformException {
//           print('Error Found');
//         }
//       }
//     } else {
//       setDeviceToken(token);
//     }
//   }
// }
