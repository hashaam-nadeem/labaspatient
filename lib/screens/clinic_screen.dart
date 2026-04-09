import 'dart:convert';

import 'package:Labas/model/insurances.dart';
import 'package:Labas/model/usersingalton.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/routes.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Labas/widgets/doctor_card.dart';
import 'package:Labas/widgets/map_launcher.dart';
import 'package:Labas/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/doctor.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'doctor_profile_screen.dart';

class ClinicScreen extends StatefulWidget {
  final String clinicName;
  final String clinicImage;
  final String departmentId;
  final String clinicId;
  final String clinicPhoneNumber;
  final String clinicTiming;
  final String clinicLogo;
  final String departmentName;
  final String clinicAddress;
  final LatLng currentLatLng;
  final List<Insurances> insurances;
  final double clinicRatings;
  ClinicScreen({
    Key key,
    @required this.clinicName,
    @required this.clinicImage,
    @required this.clinicId,
    @required this.clinicPhoneNumber,
    @required this.departmentId,
    @required this.clinicTiming,
    @required this.clinicLogo,
    @required this.departmentName,
    @required this.clinicAddress,
    @required this.currentLatLng,
    @required this.insurances,
    @required this.clinicRatings,
  }) : super(key: key);

  @override
  _ClinicScreenState createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int page = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Doctor> finalData = new List<Doctor>();
  List<double> rating = List<double>();
  List<Doctor> doctorList = [];
  List<Doctor> allDoctors = new List<Doctor>();
  int pages = 0;
  int style = 1;

  ApiClient apiClient = ApiClient();
  String clinicAddress;
  getDoctors(BuildContext context,
      {@required String clinicId, String departmentId, int pageNo}) async {
    BotToast.showCustomLoading(
      toastBuilder: (c) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    allDoctors = [];

    Map body;
    print("department Id: $departmentId");
    if (departmentId.isEmpty || departmentId == null) {
      body = {
        "clinic_id": clinicId,
      };
    } else {
      body = {
        "clinic_id": clinicId,
        "department_id": "${User.userData.departmentId}",
      };
    }
    print("${APINetwork.BASE_URL}${APINetwork.GET_DOCTORS}?page=$pageNo");
    print(body);
    await http
        .post(
      "${APINetwork.BASE_URL}${APINetwork.GET_DOCTORS}?page=$pageNo",
      body: body,
    )
        .then((value) async {
      var response = json.decode(value.body);
      //print("doctor response: $response");
      if (!response['error']) {
        print('Last response is: $response');
        User.userData.totalpages = response['data']['last_page'];
        var res = response['data']['data'];
        print('Response data is: $res');
        await response['data']['data'].forEach((e) {
          Doctor doctor = Doctor.fromMap(e);
          if (doctor.id != null) {
            if (!allDoctors.contains(doctor.id)) {
              allDoctors.add(doctor);
              //print('Doctor is added name:  ${doctor.name}');
              // ratings.add(double.parse(doctor.averageRatings.toString()));
              //  setRatings(doctor.averageRatings, e);
            }
          } else {
            allDoctors = [];
          }
        });
        // var dataLength = allDoctors.length;

        setState(() {
          pages = response['data']['last_page'];
        });
        print("last page: $pages");
          allDoctors.length == response['data']['total'];
        if (allDoctors.length <= response['data']['total']) {
          print('Data in total is: ${response['data']['total']}');
          // data = searchClinic;
          setState(() {
            finalData.addAll(allDoctors);
          });
          // finalData.forEach((element) {
          //   print('Doctor name is: ${element.id}');
          // });
        }
        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    });
    BotToast.closeAllLoading();
    print(allDoctors);

    return allDoctors;
  }

  @override
  void initState() {
    super.initState();
    getDoctors(context,
        clinicId: widget.clinicId,
        departmentId: User.userData.selectedDepartment.toString(),
        pageNo: page);
    if (finalData.length != 0) {
      for (int i = 0; i < finalData.length; i++) {
        rating.add(double.parse(finalData[i].averageRatings.toString()));
        // _dataProvider.setRatings(
        //     snapshot.data[i].averageRatings, i);
      }
      if (finalData.length > 0) {
        finalData.forEach((element) {
          if (!doctorList.contains(element)) {
            doctorList.add(element);
          }
        });
      }
    }
  }

  var selected = User.userData.departmentId;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _dataProvider = Provider.of<DataProvider>(context);
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    print(widget.clinicRatings);
    return Scaffold(
      key: _scaffoldKey,
      // bottomNavigationBar: SafeArea(
      //   child: CustomBottomNavBar(),
      // ),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                height: height * .25,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.arrow_back_ios,
                                                  color: greenColor,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: GradientText(
                                                  widget.clinicName,
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
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(),
                                            ),
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
                                                      child: Image.asset(
                                                    "assets/images/clinics.png",
                                                    height: height * .04,
                                                    width: width * .15,
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
              ),
              Positioned(
                top: height * .32,
                child: Container(
                  height: height * .8,
                  width: width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        30,
                      ),
                      topRight: Radius.circular(
                        30,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .03,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * .32,
                            ),
                            SmoothStarRating(
                              rating: widget.clinicRatings,
                              isReadOnly: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .035,
                        ),
                        widget.insurances.length == 0
                            ? SizedBox()
                            : Container(
                                width: width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${getTranslated(context, "Insurances")}',
                                      maxLines: 1,
                                      style: labelTextStyle.copyWith(
                                        fontSize: width * .05,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    Wrap(
                                      children: List.generate(
                                        widget.insurances.length,
                                        (index) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * .04,
                                                height: width * .04,
                                                child: Image.asset(
                                                  insurance,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * .02,
                                              ),
                                              Text(
                                                widget.insurances[index]
                                                    .insurance.name,
                                                maxLines: 1,
                                                style: labelTextStyle.copyWith(
                                                  fontSize: width * .032,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                  ],
                                ),
                              ),

                        SingleChildScrollView(
                          //   physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              _dataProvider.filterList.length,
                              (index) {
                                return  GestureDetector(
                                  onTap: () {
                                    finalData.clear();
                                    finalData.addAll(allDoctors);
                                    setState(() {
                                      User.userData.departmentName= _widgetProvider.languageIndex == 1 ? _dataProvider.filterList[index].name : _dataProvider.filterList[index].arabicName;
                                    });
                                    setState(() {
                                      selected =
                                          _dataProvider.filterList[index].id;
                                      print('Selected is: $selected');
                                      if (selected == null) {
                                        selected = null;
                                        print('Selected is empty: $selected');
                                      }
                                    });
                                    getDoctors(context,
                                        clinicId: widget.clinicId,
                                        departmentId: selected.toString(),
                                        pageNo: page);
                                    setState(() {
                                      selected =
                                          _dataProvider.filterList[index].id;
                                    });

                                    // _dataProvider.changeSelectedDepartmentIndex(
                                    //     _dataProvider.filterList[index].id);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: width * .02,
                                    ),
                                    child: Container(
                                      height: height * .04,
                                      decoration: BoxDecoration(
                                        color: selected ==
                                            _dataProvider
                                                .filterList[index].id
                                            ? mainColor
                                            : Colors.blue[50],
                                        borderRadius: BorderRadius.circular(
                                          width * .05,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * .05,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _widgetProvider.languageIndex == 1
                                                  ? _dataProvider
                                                  .filterList[index].name
                                                  : _dataProvider
                                                  .filterList[index]
                                                  .arabicName,
                                              style: labelTextStyle.copyWith(
                                                  fontSize: width * .04,
                                                  color: selected ==
                                                      _dataProvider
                                                          .filterList[index]
                                                          .id
                                                      ? Colors.white
                                                      : mainColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          children: [
                            Text(
                              getTranslated(context, 'doctor'),
                              style: labelTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),

                        finalData.length == 0
                            ? Container(
                          height: height * .3,
                          child: Center(
                            child: Text(
                              getTranslated(context, 'noDoctorFound'),
                              style: labelTextStyle.copyWith(
                                fontSize: width * .04,
                              ),
                            ),
                          ),
                        )
                            : Container(
                          height: height * .4,
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
                                  getDoctors(context,
                                      clinicId: widget.clinicId,
                                      departmentId: _dataProvider
                                          .departmentSelectedIndex
                                          .toString()
                                          // .isEmpty
                                          .isEmpty
                                          ? ""
                                          : _dataProvider
                                          .departmentSelectedIndex
                                          .toString(),
                                      pageNo: page);
                                });
                                _refreshController.loadComplete();
                              } else {
                                _refreshController.loadComplete();
                              }
                            },
                            child: ListView.builder(
                              itemCount: finalData.length,
                              itemBuilder: (context, int index) {


                                print("doctor name: ${finalData[index].name}");
                                if (finalData.length == 0) {
                                  // print("doctor rating: ${finalData[index].name}:=>"
                                  //     "  ${finalData[index].averageRatings.toDouble()}");
                                  return Container(
                                    height: height * .3,
                                    child: Center(
                                      child: Text(
                                        getTranslated(
                                            context, 'noDoctorFound'),
                                        style: labelTextStyle.copyWith(
                                          fontSize: width * .04,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return InkWell(
                                    onTap: () {
                                      _dataProvider.doctor = finalData[index];
                                      _dataProvider.clinicName = widget.clinicName;
                                      _dataProvider.clinicId = widget.clinicId;

                                      _dataProvider.doctorName = _widgetProvider.languageIndex == 1
                                          ? finalData[index].name
                                          : finalData[index]
                                          .arabicTitle;

                                      if (widget.departmentName.isEmpty) {
                                        _dataProvider.departmentName =
                                        "All";
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DoctorProfileScreen(
                                                departmentId: finalData[index]
                                                    .id
                                                    .toString(),
                                                doctorName: _widgetProvider
                                                    .languageIndex ==
                                                    1
                                                    ? finalData[index].name
                                                    : finalData[index]
                                                    .arabicTitle,
                                                services:
                                                finalData[index].services,
                                                shortDescription:
                                                finalData[index]
                                                    .shortDescription,
                                                specialization:
                                                finalData[index]
                                                    .specialization,
                                                mobileNumber: finalData[index]
                                                    .mobileNumber,
                                                longDescription:
                                                finalData[index]
                                                    .longDescription,
                                                education: finalData[index]
                                                    .education,
                                                experience: finalData[index]
                                                    .experience,
                                                imageURL: APINetwork
                                                    .BASE_URL +
                                                    finalData[index].imageURL,
                                                doctorId: finalData[index]
                                                    .id
                                                    .toString(),
                                                clinicId: widget.clinicId,
                                                clinicName: widget.clinicName,
                                                averageRatings:
                                                finalData[index]
                                                    .averageRatings
                                                    .toDouble(),
                                              ),
                                        ),
                                      );
                                    },
                                    child: DoctorCard(
                                      style: _dataProvider.clinicStyle,
                                      imageURL: APINetwork.BASE_URL +
                                          finalData[index].imageURL,
                                      name: _widgetProvider
                                          .languageIndex ==
                                          1
                                          ? finalData[index].name
                                          : finalData[index].arabicTitle,
                                      specialization:
                                      finalData[index].specialization,
                                      ratings: double.parse(
                                          finalData[index]
                                              .averageRatings
                                              .toString()),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),


              Positioned(
                left: width * .35,
                top: height * .25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * .6,
                      child: Row(
                        children: [
                          Icon(
                            Icons.call,
                            size: width * .04,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: width * .05,
                          ),
                          Text(
                            widget.clinicPhoneNumber,
                            style: hintTextStyle.copyWith(
                              fontSize: width * .035,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .005,
                    ),
                    Container(
                      width: width * .6,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: width * .04,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: width * .05,
                          ),
                          Flexible(
                            child: Text(
                              _dataProvider.clinicAddress,
                              maxLines: 1,
                              style: labelTextStyle.copyWith(
                                fontSize: width * .035,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .005,
                    ),
                    Container(
                      width: width * .6,
                      child: Row(
                        children: [
                          Icon(
                            Icons.watch_later,
                            size: width * .04,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: width * .05,
                          ),
                          Text(
                            widget.clinicTiming,
                            style: labelTextStyle.copyWith(
                              fontSize: width * .035,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              print(widget.currentLatLng);
                              openMap(widget.currentLatLng.latitude,
                                  widget.currentLatLng.longitude);
                              // mapLauncher(
                              //   context,
                              //   widget.currentLatLng.latitude,
                              //   widget.currentLatLng.longitude,
                              // );
                            },
                            child: Icon(
                              Icons.directions,
                              size: 28.0,
                              color: Colors.yellow,
                            ),
                          ),
                          SizedBox(
                            width: width * .02,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: height * .24,
                left: width * .02,
                child: Container(
                  width: width * .3,
                  height: width * .3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.clinicLogo,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
