import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/labas_button.dart';
import 'package:Labas/widgets/labas_text_field.dart';
import 'package:flutter/material.dart';

class SetNewPasswordScreen extends StatelessWidget {
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  final mobileNumber, otp;

  var _formKey = GlobalKey<FormState>();
  ApiClient apiClient = ApiClient();

  SetNewPasswordScreen(
      {Key key, @required this.mobileNumber, @required this.otp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
                    height: height * .1,
                  ),
                  Text(
                    getTranslated(context, 'setPassword'),
                    style: headingStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    getTranslated(context, 'newPasswordText'),
                    textAlign: TextAlign.start,
                    style: hintTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: height * .04,
                  ),
                  SizedBox(
                    height: height * .1,
                  ),
                  LabasTextField(
                    textEditingController: _passwordTextEditingController,
                    hintText: getTranslated(context, 'password'),
                    obsecure: true,
                    isPasswordText: true,
                    isFormType: 2,
                    isTextFormField: true,
                    // validatorText: mobileNumber,
                  ),
                  SizedBox(
                    height: height * .18,
                  ),
                  LabasButton(
                    title: getTranslated(context, 'submit'),
                    onPress: () async {
                      await apiClient.setNewPassword(
                        mobileNumber: mobileNumber,
                        otpCode: otp,
                        password: _passwordTextEditingController.text,
                        context: context,
                      );
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
    );
  }
}
