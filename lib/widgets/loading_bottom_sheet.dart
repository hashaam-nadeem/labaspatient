import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';

showBottomLoading(
  BuildContext context, {
  @required String title,
  @required String message,
}) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return showModalBottomSheet(
    isDismissible: true,
    isScrollControlled: false,
    enableDrag: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          width * .08,
        ),
        topRight: Radius.circular(
          width * .08,
        ),
      ),
    ),
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          height: height * .18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .015,
                  vertical: height * .01,
                ),
                child: GestureDetector(
                  child: Text(
                    title ?? getTranslated(context, 'loading'),
                    style: labelTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: width * .05,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .015,
                ),
                child: GestureDetector(
                  child: Text(
                    message ?? getTranslated(context, 'pleaseHoldOn'),
                    style: labelTextStyle.copyWith(
                      fontSize: width * .035,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  darkGreyColor,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
