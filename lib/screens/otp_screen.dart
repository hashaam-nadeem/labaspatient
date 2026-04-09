import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/widgets/poweredBy.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/labas_button.dart';

class OTPScreen extends StatefulWidget {
  final bool isSetNewPasswordRoute;
  final String mobileNumber;

  OTPScreen({
    Key key,
    this.isSetNewPasswordRoute = true,
    @required this.mobileNumber,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _otpTextEditingController = TextEditingController();

  final _formKey = GlobalKey<FormFieldState>();

  ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: powered(context),
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                  SizedBox(
                    height: height * .07,
                  ),
                  Center(
                    child: SizedBox(
                      height: width * .30,
                      width: width * .30,
                      child: Image.asset(
                        appLogo,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      labas_text,
                      width: width * .20,
                      height: height * .07,
                    ),
                  ),
                  SizedBox(
                    height: height * .06,
                  ),
                  Center(
                    child: Text(
                      "OTP",
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .06,
                  ),
                  // Text(
                  //   getTranslated(context, 'verification'),
                  // style: headingStyle.copyWith(
                  //   fontWeight: FontWeight.bold,
                  //   color: Colors.black,
                  // ),
                  // ),
                  // Text(
                  //   getTranslated(context, 'verificationText'),
                  //   textAlign: TextAlign.start,
                  //   style: hintTextStyle.copyWith(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: height * .1,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * .8,
                        child: PinCodeTextField(
                          controller: _otpTextEditingController,
                          appContext: context,
                          length: 4,
                          validator: (value) {
                            if (value.isEmpty) {
                              return getTranslated(context, 'fieldEmptyText');
                            }
                            if (value.length < 4) {
                              return getTranslated(context, 'fullPinCode');
                            } else {
                              return '';
                            }
                          },
                          onChanged: (_) {},
                          backgroundColor: Colors.transparent,
                          keyboardType: TextInputType.number,
                          pinTheme: PinTheme.defaults(
                            shape: PinCodeFieldShape.box,
                            activeColor: Colors.grey,
                            inactiveColor: Colors.grey,
                            selectedColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Center(
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          print("otp code is: ${_otpTextEditingController.text}");
                          if (_otpTextEditingController.text.length == 4) {
                            if (widget.isSetNewPasswordRoute) {
                              apiClient.verifyRegistrationOTP(
                                mobileNumber: widget.mobileNumber,
                                otpCode: _otpTextEditingController.text,
                                context: context,
                              );
                            } else {
                              apiClient.verifyOTPForgotPassword(
                                  mobileNumber: widget.mobileNumber,
                                  otpCode: _otpTextEditingController.text,
                                  context: context);
                            }
                          } else {
                            BotToast.showText(
                              text: 'Field missing!',
                              textStyle: labelTextStyle.copyWith(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              contentColor: Colors.red,
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              getTranslated(context, 'verify'),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.isSetNewPasswordRoute) {
                            apiClient.registerMobileNumber(
                              mobileNumber: widget.mobileNumber,
                              context: context,
                            );
                          } else {
                            apiClient.forgotPasswordMobileNumber(
                              mobileNumber: widget.mobileNumber,
                              context: context,
                            );
                          }
                        },
                        child: Text(
                          getTranslated(context, 'resend'),
                          style: labelTextStyle.copyWith(
                            fontSize: width * .04,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              
              ),
            ),
          ),
        ),
      ),
    );
  }


}
