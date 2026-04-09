import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/forgot_password.dart';
import 'package:Labas/screens/registration_screen.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/labas_text_field.dart';
import 'package:Labas/widgets/poweredBy.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _mobileNumberTextEditingController =
          TextEditingController(),
      _passwordTextEditingController = TextEditingController();

  // var _navigationService = locator<NavigationService>();

  String mobileNumber = '', password = '', fcmToken = '';

  var _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ApiClient apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingToken();
    apiClient.getDepartments(context);
  }

  void firebaseCloudMessagingToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    //SharedPreferences localStorage = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken().then((token) {
      // print("Mobile Token is: $token");
      setState(() {
        fcmToken = token;
        //User.userData.notificationToken = token;
      });
      //print(User.userData.notificationToken);
      //localStorage.setString('notificationToken', token);
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: powered(context),
      body: SafeArea(
        child: Container(
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
                          height: height * .04,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     showModalBottomSheet(
                        //       context: context,
                        //       builder: (ctx) {
                        //         return Container(
                        //           height: height * .13,
                        //           child: Padding(
                        //             padding: EdgeInsets.all(
                        //               width * .04,
                        //             ),
                        //             child: Column(
                        //               children: [
                        //                 InkWell(
                        //                   onTap: () {
                        //                     _widgetProvider.changeLanguageIndex(1);
                        //                     changeLanguage('en', context);
                        //                   },
                        //                   child: Row(
                        //                     children: [
                        //                       Text(
                        //                         'English',
                        //                         style: labelTextStyle.copyWith(
                        //                           fontSize: width * .04,
                        //                           fontWeight: _widgetProvider
                        //                                       .languageIndex ==
                        //                                   1
                        //                               ? FontWeight.bold
                        //                               : FontWeight.normal,
                        //                         ),
                        //                       ),
                        //                       Spacer(),
                        //                       _widgetProvider.languageIndex == 1
                        //                           ? Icon(
                        //                               Icons.done,
                        //                               size: width * .05,
                        //                             )
                        //                           : SizedBox(),
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 Divider(
                        //                   thickness: 1,
                        //                   color: Colors.grey[300],
                        //                 ),
                        //                 InkWell(
                        //                   onTap: () {
                        //                     _widgetProvider.changeLanguageIndex(2);
                        //                     changeLanguage('ar', context);
                        //                   },
                        //                   child: Row(
                        //                     children: [
                        //                       Text(
                        //                         'العربية',
                        //                         style: labelTextStyle.copyWith(
                        //                           fontSize: width * .04,
                        //                           fontWeight: _widgetProvider
                        //                                       .languageIndex ==
                        //                                   2
                        //                               ? FontWeight.bold
                        //                               : FontWeight.normal,
                        //                         ),
                        //                       ),
                        //                       Spacer(),
                        //                       _widgetProvider.languageIndex == 2
                        //                           ? Icon(
                        //                               Icons.done,
                        //                               size: width * .05,
                        //                             )
                        //                           : SizedBox(),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(
                        //             width * .06,
                        //           ),
                        //           topRight: Radius.circular(
                        //             width * .06,
                        //           ),
                        //         ),
                        //       ),
                        //       clipBehavior: Clip.hardEdge,
                        //     );
                        //   },
                        //   child: Container(
                        //     width: _widgetProvider.languageIndex == 1
                        //         ? width * .26
                        //         : _widgetProvider.languageIndex == 2
                        //             ? width * .26
                        //             : width * .45,
                        //     height: height * .04,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(
                        //         width * .04,
                        //       ),
                        //       color: mainColor,
                        //     ),
                        //     child: Center(
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //         children: [
                        //           Text(
                        //             _widgetProvider.languageIndex == 1
                        //                 ? 'English'
                        //                 : _widgetProvider.languageIndex == 2
                        //                     ? 'العربية'
                        //                     : 'Choose Language',
                        //             style: labelTextStyle.copyWith(
                        //               fontSize: width * .04,
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //           Icon(
                        //             Icons.arrow_forward_ios,
                        //             size: width * .028,
                        //             color: Colors.white,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                          height: height * .02,
                        ),
                        Center(
                          child: Text(
                            getTranslated(
                              context,
                              'enterCredentials' ?? '',
                            ),
                            textAlign: TextAlign.start,
                            style: hintTextStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
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
                          hintText: getTranslated(context, '') ?? '',
                          obsecure: false,
                          isTextFormField: true,
                          validatorText: mobileNumber,
                          maxLength: 8,
                          textInputType: TextInputType.number,
                          isFormType: 1,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            getTranslated(
                              context,
                              'enterPassword' ?? '',
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
                          textEditingController: _passwordTextEditingController,
                          hintText: getTranslated(context, '') ?? '',
                          isPasswordText: true,
                          obsecure: true,
                          isTextFormField: true,
                          // isFormType: 2,
                          isFormType: 1,
                          validatorText: password,
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Center(
                          child: Container(
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () async {
                                // print('FCM Tokem from variable is: $fcmToken');
                                if (_mobileNumberTextEditingController
                                        .text.isNotEmpty &&
                                    _passwordTextEditingController
                                        .text.isNotEmpty) {
                                  apiClient.signIn(
                                      mobileNo: "974" +
                                          _mobileNumberTextEditingController
                                              .text,
                                      password:
                                          _passwordTextEditingController.text,
                                      context: context,
                                      token: fcmToken);
                                } else {
                                  BotToast.showText(
                                    text: getTranslated(context, 'fillFields'),
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
                                    getTranslated(context, 'Login'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => OTPScreen(
                                  //             mobileNumber: "77916925",
                                  //           )),
                                  // );
                                  // _navigationService.navigateTo(
                                  //   AppRoute.otpScreen,
                                  // );
                                },
                                child: Text(
                                  getTranslated(context, 'Forgot Password?'),
                                  style: labelTextStyle.copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ForgotPasswordScreen()));
                                },
                                child: Text(
                                  getTranslated(context, 'recoverNow'),
                                  style: labelTextStyle.copyWith(
                                      color: Colors.blue[400],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated(context, 'dontHaveAccount'),
                              style: labelTextStyle.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                              },
                              child: Text(
                                getTranslated(context, 'signUp'),
                                style: labelTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                ),
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
