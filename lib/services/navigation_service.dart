// import 'package:flutter/material.dart';

// class NavigationService {
//   GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   Future<dynamic> navigateTo(String routeName) {
//     return navigatorKey.currentState.pushNamed(routeName);
//   }

//   Future<dynamic> navigateReplace(String routeName) {
//     return navigatorKey.currentState.pushReplacementNamed(routeName);
//   }

//   Future<dynamic> navigateAndRemoveUntil(String routeName) {
//     return navigatorKey.currentState
//         .pushNamedAndRemoveUntil(routeName, (route) => false);
//   }

//   void goBack() {
//     return navigatorKey.currentState.pop();
//   }
// }
import 'package:flutter/material.dart';

class AppRoutes {
  static void push(BuildContext context, Widget page) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static void replace(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static void makeFirst(BuildContext context, Widget page) {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void dismissAlert(context) {
    Navigator.of(context).pop();
  }
}
