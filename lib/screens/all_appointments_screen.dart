import 'dart:convert';
import 'package:Labas/model/clinic.dart';
import 'package:Labas/services/navigation_service.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/appointment_detail.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:Labas/utilis/globals.dart';
import 'package:Labas/utilis/shared_preferences.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/alert_dialog.dart';
import 'package:Labas/widgets/appointment_tile.dart';
import 'package:Labas/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AllAppointmentScreen extends StatefulWidget {
  @override
  _AllAppointmentScreenState createState() => _AllAppointmentScreenState();
}

class _AllAppointmentScreenState extends State<AllAppointmentScreen> {
  int page = 1;
  int pages = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<AppointmentDetail> finalData = new List<AppointmentDetail>();
  @override
  void initState() {
    super.initState();
    appointmentHistory();
  }

  appointmentHistory() async {
    String token = await getBearerToken();

    var _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _dataProvider.allAppointments = [];
    if (token != null) {
      print(
        "${APINetwork.BASE_URL}${APINetwork.APPOINTMENT_HISTORY}?page=$page",
      );
      print({'Authorization': 'Bearer $token'});
      await http.post(
        "${APINetwork.BASE_URL}${APINetwork.APPOINTMENT_HISTORY}?page=$page",
        headers: {'Authorization': 'Bearer $token'},
      ).then((value) {
        var response = json.decode(value.body);
        print("all appontment respiosse: $response");
        int length = response['data']['data'].length;
        if (!response['error']) {
          print("all data length: ${response['data']['data'].length}");
          response['data']['data'].forEach((e) {
            if (length <= response['data']['total']) {
              finalData.add(AppointmentDetail.fromMap(e));
            }
          });
          setState(() {
            pages = response['data']['last_page'];
          });
          print("all appontment respiosse: ${_dataProvider.allAppointments}");
          // if (_dataProvider.allAppointments.length <= response['total']) {
          //   // data = searchClinic;
          //   setState(() {
          //     finalData.addAll(_dataProvider.allAppointments);
          //   });
          // }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiClient apiClient = ApiClient();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _widgetProvider = Provider.of<WidgetProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     getTranslated(context, 'appointment'),
      //     style: labelTextStyle.copyWith(
      //       fontSize: width * .05,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     Icon(
      //       Icons.location_on,
      //       color: Colors.white,
      //     ),
      //     SizedBox(
      //       width: width * .03,
      //     )
      //   ],
      // ),
      // bottomNavigationBar: SafeArea(
      //   child: CustomBottomNavBar(),
      // ),
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          child: Column(
            children: [
              //Header
              Column(
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
                                          bottomLeft:
                                              Radius.circular(width * .13),
                                          bottomRight:
                                              Radius.circular(width * .13))),
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
                                          bottomLeft:
                                              Radius.circular(width * .9),
                                          bottomRight:
                                              Radius.circular(width * .9))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                AppRoutes.pop(context);
                                              },
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                color: greenColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 9,
                                            child: GradientText(
                                                "${getTranslated(context, "allAppointments")}",
                                                gradient:
                                                    LinearGradient(colors: [
                                                  mainColor,
                                                  greenColor,
                                                ]),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.all(3),
                                            width: width * .3,
                                            height: height * .06,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    greenColor,
                                                    mainColor
                                                  ]),
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: width * .3,
                                                height: height * .06,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.notifications,
                                                  color: greenColor,
                                                )),
                                              ),
                                            ),
                                          )
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
                ],
              ),
              Container(
                  width: width,
                  height: height * .65,
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: false,
                    enablePullUp: true,
                    header: WaterDropHeader(),
                    onLoading: () async {
                      if (page < pages) {
                        setState(() {
                          page = page + 1;
                          print("page increment: $page");
                          appointmentHistory();
                        });
                        _refreshController.loadComplete();
                      } else {
                        _refreshController.loadComplete();
                      }
                    },
                    child: ListView.builder(
                      itemCount: finalData.length,
                      itemBuilder: (context, index) {
                        String imageURL = APINetwork.BASE_URL +
                            imagePath +
                            finalData[index].doctorImage;

                        DateTime dateTime =
                            DateTime.tryParse(finalData[index].appointmentDate);
                        String correcTime =
                            DateFormat('dd-MM-yyyy').format(dateTime);
                        print(correcTime);

                        return AppointmentTile(
                          doctorName: _widgetProvider.languageIndex == 1
                              ? finalData[index].doctorName
                              : finalData[index].doctorArabic ?? '',
                          clinicName: _widgetProvider.languageIndex == 1
                              ? finalData[index].clinicName
                              : finalData[index].clinicArabic,
                          currentDate: correcTime ?? '',
                          startTime:
                              finalData[index].startTime.substring(0, 5) ?? '',
                          endTime:
                              finalData[index].endTime.substring(0, 5) ?? '',
                          doctorSpecialization:
                              finalData[index].doctorSpecialization ?? '',
                          latitude: finalData[index].clinicLat,
                          longitude: finalData[index].clinicLong,
                          doctorImageURL: imageURL,
                          appointmentId: finalData[index].id.toString(),
                          doctorId: finalData[index].doctorId.toString(),
                          clinicId: finalData[index].clinicId.toString(),
                          rating: finalData[index].rating,
                          patientAvailability:
                              finalData[index].patientAvailability,
                          submitRatingsFunction: () async {
                            var ratingCheck = await showCustomAlertDialog(
                              context,
                              doctorName: _widgetProvider.languageIndex == 1
                                  ? finalData[index].doctorName
                                  : finalData[index].doctorArabic,
                              clinicName: _widgetProvider.languageIndex == 1
                                  ? finalData[index].clinicName
                                  : finalData[index].clinicArabic,
                              appointmentId: finalData[index].id.toString(),
                              clinicId: finalData[index].clinicId.toString(),
                              doctorId: finalData[index].doctorId.toString(),
                            );

                            setState(() {
                              apiClient.appointmentHistory(context);
                            });
                            print("rating check: $ratingCheck");
                          },
                          cancelAppointmentFunction: () async {
                            await apiClient.cancelAppointment(
                              finalData[index].id.toString(),
                            );
                            appointmentHistory();
                            setState(() {
                              appointmentHistory();
                            });
                            AppRoutes.replace(context, AllAppointmentScreen());
                          },
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  showCustomAlertDialog(
    context, {
    @required String doctorName,
    @required String clinicName,
    @required String clinicId,
    @required String doctorId,
    @required String appointmentId,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double doctorRating = 0.0;
    double clinicRating = 0.0;
    ApiClient apiClient = ApiClient();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: greenColor, width: 8),
            borderRadius: BorderRadius.circular(
              18,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              SizedBox(
                height: width * .2,
                width: width * .2,
                child: Image.asset(
                  rateIcon,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              GradientText(getTranslated(context, 'experienceWithUs'),
                  gradient: LinearGradient(colors: [
                    mainColor,
                    greenColor,
                  ]),
                  style: TextStyle(
                      fontSize: width * .05, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              // Text(
              //   getTranslated(context, 'experienceWithUs'),
              //   style: labelTextStyle.copyWith(
              //     fontSize: width * .05,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(
                height: height * .02,
              ),
              Container(
                width: width * .3,
                child: Text(
                  doctorName,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: labelTextStyle.copyWith(
                      fontSize: width * .04,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SmoothStarRating(
                onRated: (rating) {
                  doctorRating = rating;
                },
              ),

              SizedBox(
                height: height * .02,
              ),
              Container(
                width: width * .3,
                child: Text(
                  clinicName,
                  maxLines: 1,
                  style: labelTextStyle.copyWith(
                      fontSize: width * .04,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SmoothStarRating(
                onRated: (rating) {
                  clinicRating = rating;
                },
              ),
              SizedBox(
                height: height * .02,
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(
            width * .03,
          ),
          actionsPadding: EdgeInsets.all(0),
          buttonPadding: EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(0),
          actions: [
            Container(
              width: width,
              height: height * .06,
              child: FlatButton(
                color: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(
                      10,
                    ),
                  ),
                ),
                onPressed: () async {
                  bool ratingCheck = await apiClient.giveRatings(
                    context: context,
                    appointmentId: appointmentId,
                    clinicId: clinicId,
                    doctorId: doctorId,
                    doctorRatings: doctorRating.toString(),
                    clinicRatings: clinicRating.toString(),
                    // ignore: missing_return
                  );

                  print('Rating is: $ratingCheck');

                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => MainScreen(),
                  //   ),
                  //   (route) => false,
                  // );
                  //     AppRoutes.replace(context, AllAppointmentScreen());
                  setState(() {
                    apiClient.appointmentHistory(context);
                    appointmentHistory();
                  });

                  Navigator.pop(context, ratingCheck);
                  setState(() {
                    apiClient.appointmentHistory(context);
                    appointmentHistory();
                  });
                  AppRoutes.replace(context, AllAppointmentScreen());
                },
                child: Text(
                  getTranslated(context, 'done'),
                  style: labelTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: width * .04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
