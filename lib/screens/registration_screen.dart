import 'package:Labas/app_router.dart';
import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/locator.dart';
import 'package:Labas/screens/login_screen.dart';
import 'package:Labas/services/navigation_service.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/labas_text_field.dart';
import 'package:Labas/widgets/poweredBy.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _mobileNumberTextEditingController =
      TextEditingController();

  //var _navigationService = locator<NavigationService>();

  String mobileNumber = '';

  var _formKey = GlobalKey<FormState>();

  ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                        SizedBox(
                          height: height * .03,
                        ),
                        Center(
                          child: Text(
                            getTranslated(context, 'registration'),
                            style: headingStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            getTranslated(
                              context,
                              'phoneNumber' ?? '',
                            ),
                            textAlign: TextAlign.start,
                            style: hintTextStyle.copyWith(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        LabasTextField(
                          textEditingController:
                              _mobileNumberTextEditingController,
                          hintText: getTranslated(context, ''),
                          obsecure: false,
                          validatorText: mobileNumber,
                          isFormType: 1,
                          isTextFormField: true,
                          textInputType: TextInputType.number,
                          maxLength: 8,
                        ),
                        SizedBox(
                          height: height * .08,
                        ),
                        Center(
                          child: Container(
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () async {
                                if (_mobileNumberTextEditingController
                                    .text.isNotEmpty) {
                                  apiClient.registerMobileNumber(
                                    mobileNumber: "+974" +
                                        _mobileNumberTextEditingController.text,
                                    context: context,
                                  );
                                } else {
                                  BotToast.showText(
                                    text: getTranslated(
                                        context, 'mobileNumberMissing'),
                                    textStyle: labelTextStyle.copyWith(
                                      fontSize: width * .03,
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
                                    getTranslated(context, 'Register'),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated(context, 'alreadyHaveAccount'),
                              style: labelTextStyle.copyWith(
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginScreen()));
                              },
                              child: Text(
                                getTranslated(context, 'signIn'),
                                style: labelTextStyle.copyWith(
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ),
                            ),
                          ],
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
