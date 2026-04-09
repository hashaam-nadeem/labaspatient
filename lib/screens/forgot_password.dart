import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/locator.dart';
import 'package:Labas/services/navigation_service.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/labas_button.dart';
import 'package:Labas/widgets/labas_text_field.dart';
import 'package:Labas/widgets/poweredBy.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _mobileNumberTextEditingController =
      TextEditingController();

  // var _navigationService = locator<NavigationService>();

  var _formKey = GlobalKey<FormState>();

  String mobileNumber = '';

  ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     _navigationService.goBack();
                    //   },
                    //   child: Icon(
                    //     Icons.arrow_back_ios,
                    //     size: 32,
                    //   ),
                    // ),
                    SizedBox(
                      height: height * .03,
                    ),
                    GestureDetector(
                      onTap: () {
                        AppRoutes.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: greenColor,
                      ),
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
                    Center(
                      child: Text(
                        getTranslated(context, 'recoverPassword'),
                        style: headingStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        getTranslated(context, 'phoneNumber'),
                        style: headingStyle.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    LabasTextField(
                      textEditingController: _mobileNumberTextEditingController,
                      hintText: getTranslated(context, ''),
                      obsecure: false,
                      isFormType: 1,
                      isTextFormField: true,
                      validatorText: mobileNumber,
                      textInputType: TextInputType.number,
                      maxLength: 8,
                    ),

                    SizedBox(
                      height: height * .10,
                    ),

                    Center(
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () async {
                            if (_mobileNumberTextEditingController
                                .text.isNotEmpty) {
                              apiClient.forgotPasswordMobileNumber(
                                mobileNumber: "974" +
                                    _mobileNumberTextEditingController.text,
                                context: context,
                              );
                            } else {
                              BotToast.showText(
                                text:
                                    getTranslated(context, 'enterPhoneNumber'),
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
                                  colors: [
                                    Color(0xff374ABE),
                                    Color(0xff64B6FF)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                getTranslated(context, 'submit'),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
