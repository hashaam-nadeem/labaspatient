import 'package:Labas/screens/emergency_screen.dart';
import 'package:Labas/screens/forgot_password.dart';
import 'package:Labas/screens/login_screen.dart';
import 'package:Labas/screens/main_screen.dart';
import 'package:Labas/screens/registration_screen.dart';
import 'package:Labas/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageViewTransition<T> extends MaterialPageRoute<T> {
  PageViewTransition({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (animation.status == AnimationStatus.reverse)
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(opacity: animation, child: child);
  }
}

class AppRoute {
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';
  static const String registrationScreen = '/registrationScreen';
  // static const String otpScreen = '/otpScreen';
  static const String forgotPassword = '/forgotPassword';
  // static const String changePasswordScreen = '/changePasswordScreen';
  static const String selectLanguageScreen = '/selectLanguageScreen';
  static const String mainScreen = '/mainScreen';
  static const String emergencyScreen = '/emergencyScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return PageViewTransition(builder: (_) => SplashScreen());
      case loginScreen:
        return PageViewTransition(builder: (_) => LoginScreen());
      case registrationScreen:
        return PageViewTransition(builder: (_) => RegistrationScreen());
      // case otpScreen:
      // return PageViewTransition(builder: (_) => OTPScreen());
      case forgotPassword:
        return PageViewTransition(builder: (_) => ForgotPasswordScreen());
      // case changePasswordScreen:
      // return PageViewTransition(builder: (_) => ChangePasswordScreen());

      case mainScreen:
        return PageViewTransition(builder: (_) => MainScreen());
      case emergencyScreen:
        return PageViewTransition(builder: (_) => EmergencyScreen());
      default:
        return PageViewTransition(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
