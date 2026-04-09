import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/location_provider.dart';
import 'package:Labas/services/fcm_registration.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/all_departments.dart';
import 'package:Labas/widgets/banners.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onTap;

  HomeScreen({Key key, this.onTap}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String address = '';
  bool isDoctorSelected = true;
  ApiClient apiClient = ApiClient();
  String keyword;
  @override
  void initState() {
    super.initState();

    //Firebase_Notification().setupfirebase(context, _scaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _locationProvider = Provider.of<LocationProvider>(context);
    var _dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   actions: [
      //     Expanded(
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           SizedBox(
      //             width: width * .05,
      //           ),
      //           Expanded(
      //             child: Text(
      //               _locationProvider.address ?? '',
      //               maxLines: 1,
      //               style: labelTextStyle.copyWith(
      //                 color: Colors.white,
      //                 fontSize: width * .035,
      //               ),
      //             ),
      //           ),
      //           IconButton(
      //             onPressed: () async {
      //               BotToast.showCustomLoading(toastBuilder: (v) {
      //                 return Center(
      //                   child: CircularProgressIndicator(),
      //                 );
      //               });
      //               await _locationProvider.getPatientLocation();
      //               BotToast.closeAllLoading();
      //             },
      //             icon: Icon(
      //               Icons.location_on,
      //               color: Colors.white,
      //               size: width * .06,
      //             ),
      //           ),
      //           SizedBox(
      //             width: width * .03,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: width,
                  height: height * .22,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipPath(
                          clipper: OvalBottomBorderClipper(),
                          child: Container(
                            height: height * .22,
                            width: width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [greenColor, mainColor]),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(width * .13),
                                    bottomRight: Radius.circular(width * .13))),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: width,
                            height: height * .18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(width * .9),
                                  bottomRight: Radius.circular(width * .9),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: width * .21,
                                      width: width * .21,
                                      child: Image.asset(
                                        appLogo,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Image.asset(
                                      labas_text,
                                      width: width * .15,
                                      height: height * .06,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * .001,
            ),
            Container(
              height: height * .85,
              width: width,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width * .03,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * .03,
                    ),
                    LabasBanner(),
                    SizedBox(
                      height: height * .03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * .03,
                      ),
                      child: Text(
                        getTranslated(context, 'departments'),
                        style: labelTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
                      height: height * .2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
