import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
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

class UpdatePasswordScreen extends StatefulWidget {
  final VoidCallback onTap;

  UpdatePasswordScreen({Key key, this.onTap}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController(),
      newPasswordController = TextEditingController(),
      confirmPasswordController = TextEditingController();

  ApiClient _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     getTranslated(context, 'changePassword'),
      //     style: labelTextStyle.copyWith(
      //       fontSize: width * .05,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      bottomNavigationBar: powered(context),
      body: SafeArea(
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   height: height * .08,
                  //   width: width,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           SizedBox(
                  //             width: width * .03,
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               widget.onTap();
                  //             },
                  //             child: Icon(
                  //               Icons.menu,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           Spacer(),
                  //           Text(
                  //             getTranslated(context, 'changePassword'),
                  //             style: labelTextStyle.copyWith(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           Spacer(),
                  //           SizedBox(
                  //             width: width * .04,
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: height * 0.005,
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
                      height: width * .25,
                      width: width * .25,
                      child: Image.asset(
                        appLogo,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      labas_text,
                      width: width * .18,
                      height: height * .065,
                    ),
                  ),
                  SizedBox(
                    height: height * .015,
                  ),
                  Center(
                    child: Text(
                      getTranslated(context, 'changePassword'),
                      style: hintTextStyle.copyWith(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * .02,
                        ),
                        Text(
                          getTranslated(context, 'oldPassword'),
                          textAlign: TextAlign.start,
                          style: hintTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        LabasTextField(
                          textEditingController: oldPasswordController,
                          hintText: '',
                          isPasswordText: true,
                          obsecure: true,
                          isTextFormField: true,
                          isFormType: 3,
                          // validatorText: password,
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Text(
                          getTranslated(context, 'newPassword'),
                          textAlign: TextAlign.start,
                          style: hintTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        LabasTextField(
                          textEditingController: newPasswordController,
                          hintText: '',
                          isPasswordText: true,
                          obsecure: true,
                          isTextFormField: true,
                          isFormType: 3,
                          // validatorText: password,
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Text(
                          getTranslated(context, 'Confirm Password'),
                          textAlign: TextAlign.start,
                          style: hintTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        LabasTextField(
                          textEditingController: confirmPasswordController,
                          hintText: '',
                          isPasswordText: true,
                          obsecure: true,
                          isTextFormField: true,
                          isFormType: 3,
                          // validatorText: password,
                        ),
                        SizedBox(
                          height: height * .05,
                        ),
                        Center(
                          child: Container(
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () {
                                if (newPasswordController.text != null &&
                                    confirmPasswordController.text != null &&
                                    oldPasswordController.text.isNotEmpty) {
                                  if (newPasswordController.text.isNotEmpty &&
                                      confirmPasswordController
                                          .text.isNotEmpty &&
                                      oldPasswordController.text.isNotEmpty) {
                                    if (newPasswordController.text ==
                                        confirmPasswordController.text) {
                                      _apiClient.changePassword(
                                        oldPassword: oldPasswordController.text,
                                        newPassword: newPasswordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text,
                                        context: context,
                                      );
                                    } else {
                                      BotToast.showText(
                                        text: getTranslated(
                                            context, 'passwordMismatched'),
                                        textStyle: labelTextStyle.copyWith(
                                            fontSize: 10, color: Colors.white),
                                        contentColor: Colors.red,
                                      );
                                    }
                                  } else {
                                    BotToast.showText(
                                      text:
                                          getTranslated(context, 'fillFields'),
                                      textStyle: labelTextStyle.copyWith(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                      contentColor: Colors.red,
                                    );
                                  }
                                } else {
                                  BotToast.showText(
                                    text: getTranslated(context, 'fillFields'),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
