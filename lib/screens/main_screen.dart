import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/user_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/category_screen.dart';
import 'package:Labas/screens/clinic_main_screen.dart';
import 'package:Labas/screens/home_screen.dart';
import 'package:Labas/screens/quick_appointment.dart';
import 'package:Labas/screens/settings_screen.dart';
import 'package:Labas/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ApiClient apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    apiClient.getProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    var _userProvider = Provider.of<UserProvider>(context);
    print(_userProvider.nameTextEditingController.text);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            _widgetProvider.bottomIndex == 0
                ? HomeScreen(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  )
                : _widgetProvider.bottomIndex == 1
                    ? QuickAppointment()
                    : _widgetProvider.bottomIndex == 2
                        ? MainClinicScreen()
                        : _widgetProvider.bottomIndex == 3
                            ? SettingsScreen()
                            : Container(
                                child: Center(
                                  child: Text(
                                    getTranslated(context, 'searchScreenText'),
                                  ),
                                ),
                              ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomNavBar(),
      ),
    );
  }
}
