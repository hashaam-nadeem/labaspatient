import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/screens/main_screen.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

showSuccessMeetingCustomAlertDialog(
  BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  // double doctorRating = 0.0;
  // double clinicRating = 0.0;
  // ApiClient apiClient = ApiClient();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: greenColor,
            width: 8
            ),
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 GestureDetector(
                  onTap: () =>Navigator.pop(context),
                  child: Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                ),
            ],),
            Container(
              margin: EdgeInsets.all(20),
              width: width*0.2,
              height: height*0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                 colors: [
                          greenColor,
                          mainColor
                          ]),
              ),
              child: FlatButton(
                child: Icon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            GradientText(
              getTranslated(context, 'appointmentBookedSuccessfully'),
               gradient: LinearGradient(
                 colors: [mainColor,
                          greenColor,
                          ]),
                  style: TextStyle(
                   fontSize: width * .048,
                   fontWeight: FontWeight.bold),
                   textAlign: TextAlign.center),
            


          ],
        ),
        contentPadding: EdgeInsets.all(
          width * .03,
        ),
        actionsPadding: EdgeInsets.all(0),
        buttonPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(0),
        actions: [
        ],
      );
    },
  );
}
