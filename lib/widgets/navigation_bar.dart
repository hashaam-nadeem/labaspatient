import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/location_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatefulWidget {
  CustomBottomNavBar({Key key}) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    var _locationProvider = Provider.of<LocationProvider>(context);

    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: Colors.white,
        selectedItemBorderColor: mainColor,
        selectedItemBackgroundColor: mainColor,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: mainColor,
        selectedItemTextStyle: labelTextStyle.copyWith(
          color: Colors.black,
          fontSize: width * .03,
          fontWeight: FontWeight.bold,
        ),
        //  itemWidth: 40,
        showSelectedItemShadow: true,
        unselectedItemTextStyle: labelTextStyle.copyWith(
          color: Colors.white,
          fontSize: width * .03,
          fontWeight: FontWeight.normal,
        ),
        barHeight: height * .065,
      ),
      selectedIndex: _widgetProvider.bottomIndex,
      onSelectTab: (index) {
        setState(() {
          _widgetProvider.changeBottomIndex(index);
        });
      },
      items: [
        FFNavigationBarItem(
          iconData: FontAwesomeIcons.home,
          label: getTranslated(context, 'Home'),
        ),
        FFNavigationBarItem(
          iconData: FontAwesomeIcons.calendarCheck,
          label: getTranslated(context, 'quickAppointment'),
        ),
        FFNavigationBarItem(
          iconData:
              FontAwesomeIcons.clipboard, // getTranslated(context, 'search'),
          label: getTranslated(context, 'clinic'),
        ),
        FFNavigationBarItem(
          iconData: FontAwesomeIcons.cog,
          label: getTranslated(context, 'setting'),
        ),
      ],
    );
  }
}
