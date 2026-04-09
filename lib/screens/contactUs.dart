import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/services/navigation_service.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gradient_text/gradient_text.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        AppRoutes.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: greenColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: GradientText(
                                        "${getTranslated(context, "contactUs")}",
                                        gradient: LinearGradient(colors: [
                                          mainColor,
                                          greenColor,
                                        ]),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                  Expanded(flex: 1, child: Container()),
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
                                          Icons.email,
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
          SizedBox(
            height: height * 0.22,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                final Uri _emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'info@labbasonline.com',
                    queryParameters: {'subject': 'Labas Patient Application'});
                launch(_emailLaunchUri.toString());
              },
              child: Container(
                width: width * .72,
                height: height * .08,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      width * .03,
                    ),
                    border: Border.all(color: greenColor)),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * .03,
                    ),
                    Icon(
                      Icons.mail,
                      size: width * .07,
                      color: greenColor,
                    ),
                    SizedBox(
                      width: width * .02,
                    ),
                    Container(
                      height: height * .04,
                      width: width * .005,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(
                          width * .03,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * .02,
                    ),
                    Text(
                      'info@labbasonline.com',
                      style: TextStyle(
                        fontSize: width * .045,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
