import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/location_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/all_departments.dart';
import 'package:Labas/widgets/info_tile.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final VoidCallback onTap;
  List options;

  CategoryScreen({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    options = [
      getTranslated(context, 'all'),
      getTranslated(context, 'dentist'),
      getTranslated(context, 'ortodonist'),
      getTranslated(context, 'cardiologist'),
      getTranslated(context, 'gynecologist'),
      getTranslated(context, 'nephologist'),
    ];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    var _locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: width * .05,
                ),
                Expanded(
                  child: Text(
                    _locationProvider.address ?? '',
                    maxLines: 1,
                    style: labelTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: width * .035,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    BotToast.showCustomLoading(toastBuilder: (v) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                    await _locationProvider.getPatientLocation();
                    BotToast.closeAllLoading();
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: width * .06,
                  ),
                ),
                SizedBox(
                  width: width * .03,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .02,
              ),
              SizedBox(
                height: height * .03,
              ),
              Text(
                getTranslated(context, 'departments'),
                style: labelTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Container(
                alignment: Alignment.center,
                child: Departments(
                  isDepartmentRoute: false,
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
