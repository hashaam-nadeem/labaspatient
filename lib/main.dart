import 'package:Labas/bloc/connectivity.dart';
import 'package:Labas/locator.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/location_provider.dart';
import 'package:Labas/provider/user_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/splash_screen.dart';
import 'package:Labas/services/navigation_service.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'localization/appLocalizatin.dart';
import 'localization/language_constants.dart';
import './utilis/globals.dart' as global;
import 'package:overlay_support/overlay_support.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  global.myBloc = BlocClass(true);
  //setupLocator();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  static void setLocale(
      BuildContext context,
      Locale newLocale,
      ) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey(debugLabel: "Main Navigator");
  Locale _locale;
  var lang;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      lang = locale.languageCode;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: mainColor, systemNavigationBarColor: mainColor));
    return OverlaySupport(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<WidgetProvider>(
            create: (_) => WidgetProvider(),
            lazy: false,
          ),
          ChangeNotifierProvider<DataProvider>(
            create: (_) => DataProvider(),
            lazy: false,
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
            lazy: false,
          ),
          ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider(),
            lazy: true,
          )
        ],
        child: StreamBuilder<bool>(
          stream: global.myBloc,
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'LABAS',
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              theme: ThemeData(
                primaryColor: mainColor,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primarySwatch: kBlackPrimary,
              ),
              debugShowCheckedModeBanner: false,
              // initialRoute: AppRoute.splashScreen,
              home: SplashScreen(
                navigatorKey: navigatorKey,
                languageCode: lang,
              ),
              // home: SucessScreen(),
              onGenerateRoute: AppRoute.generateRoute,
              navigatorKey: navigatorKey,
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              locale: _locale,
              localizationsDelegates: [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale("en", "US"),
                Locale("ar", "SA"),
              ],
            );
          },
        ),
      ),
    );
  }
}
