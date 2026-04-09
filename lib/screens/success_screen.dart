import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/screens/main_screen.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';

class SucessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: SafeArea(
        child: Container(
          height: height,
          width: width,
          color: Color(0xff1B71DE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .2,
              ),
              Container(
                width: height * .22,
                height: height * .22,
                decoration: BoxDecoration(
                  color: Color(0xff2378DF),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    width * .04,
                  ),
                  child: Container(
                    width: height * .18,
                    height: height * .18,
                    decoration: BoxDecoration(
                      color: Color(0xff2C7EE0),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        width * .04,
                      ),
                      child: Container(
                        width: height * .15,
                        height: height * .15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.done,
                            color: mainColor,
                            size: width * .18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Text(
                getTranslated(context, 'success'),
                style: labelTextStyle.copyWith(
                  fontSize: width * .07,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Text(
                getTranslated(context, 'successfullyBooked'),
                style: labelTextStyle.copyWith(
                  fontSize: width * .04,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              Container(
                width: width * .8,
                child: FlatButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      width * .03,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: height * .08,
                    child: Center(
                      child: Text(
                        getTranslated(context, 'continue').toUpperCase(),
                        style: labelTextStyle.copyWith(
                          fontSize: width * .05,
                          color: Color(0xff1B71DE),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
