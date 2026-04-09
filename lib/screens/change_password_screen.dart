import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/labas_button.dart';
import 'package:Labas/widgets/labas_text_field.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatefulWidget {
  final String mobileNumber;

  String password = '';
  final int type;
  final String otp;

  ChangePasswordScreen({
    Key key,
    @required this.mobileNumber,
    this.password,
    @required this.otp,
    this.type = 1,
  }) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _passwordTextEditingController =
          TextEditingController(),
      _confirmPasswordTextEditingController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  ApiClient _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: powered(),
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
                    SizedBox(
                      height: height * .01,
                    ),
                    widget.type == 2
                        ? InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 28,
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: widget.type == 2 ? height * .07 : height * .1,
                    ),
                    Text(
                      getTranslated(context, 'resetPassword'),
                      style: headingStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      getTranslated(context, 'passwordText'),
                      textAlign: TextAlign.start,
                      style: hintTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: height * .1,
                    ),
                    LabasTextField(
                      textEditingController: _passwordTextEditingController,
                      hintText: getTranslated(context, 'newPassword'),
                      isPasswordText: true,
                      obsecure: true,
                      isTextFormField: true,
                      isFormType: 3,
                      validatorText: widget.password,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    LabasTextField(
                      textEditingController:
                          _confirmPasswordTextEditingController,
                      hintText: getTranslated(context, 'Confirm Password'),
                      isPasswordText: true,
                      obsecure: true,
                      isTextFormField: true,
                      isFormType: 3,
                      validatorText: widget.password,
                    ),
                    SizedBox(
                      height: height * .2,
                    ),
                    LabasButton(
                      title: getTranslated(context, 'submit'),
                      onPress: () {
                        if (_formKey.currentState.validate()) {
                          if (_passwordTextEditingController.text ==
                              _confirmPasswordTextEditingController.text) {
                            _apiClient.resetPassword(
                              mobileNumber: widget.mobileNumber,
                              otpCode: widget.otp,
                              password: _passwordTextEditingController.text,
                              context: context,
                            );
                          } else {
                            BotToast.showText(
                              text: getTranslated(context, 'passwordMisMatch'),
                              textStyle: labelTextStyle.copyWith(
                                fontSize: width * .03,
                                color: Colors.white,
                              ),
                              contentColor: Colors.red,
                            );
                          }
                        }
                      },
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

  Widget powered() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Developed & Powered by ",
                style: headingStyle.copyWith(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .04,
              ),
              Image.asset(
                brightMediaLogo,
                width: MediaQuery.of(context).size.width * .16,
                height: MediaQuery.of(context).size.height * .12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
