
import 'package:Labas/model/clinic.dart';
import 'package:Labas/model/insurance.dart';
import 'package:Labas/model/usersingalton.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:Labas/utilis/globals.dart';
import 'package:Labas/utilis/shared_preferences.dart';
import 'package:Labas/widgets/clinic_card.dart';
import 'package:Labas/widgets/navigation_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'clinic_screen.dart';

class DepartmentScreen2 extends StatefulWidget {
  final String departmentLogo;
  final String departmentName;
  final String departmentId;

  DepartmentScreen2({
    Key key,
    this.departmentLogo,
    this.departmentName,
    @required this.departmentId,
  }) : super(key: key);

  @override
  _DepartmentScreen2State createState() => _DepartmentScreen2State();
}

class _DepartmentScreen2State extends State<DepartmentScreen2> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List vendorData = new List();
  List<Clinic> finalData = new List<Clinic>();
  int style = 1;
  int page = 1;
  TextEditingController searchTextEditingController = TextEditingController();
  String search;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  ApiClient apiClient = ApiClient();

  searchClinic(
      {@required String keyword,
        @required String departmentId,
        @required BuildContext context,
        @required int pageNo}) async {
    String token = await getBearerToken();
    List<Clinic> searchClinics = [];
print("department ID: " + departmentId.toString());
    var body = {
      "department_id": "$departmentId",
      "search": keyword ?? '',
    };
    print("token/;  $token");
    var _dataProvider = Provider.of<DataProvider>(context, listen: false);
    if (token.isNotEmpty) {
      BotToast.showCustomLoading(toastBuilder: (e) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
      print(APINetwork.BASE_URL + APINetwork.SEARCH);
      var re = await http.post(
          "${APINetwork.BASE_URL}${APINetwork.GET_CLINICS}?page=$pageNo",
          headers: {
            "Authorization": 'Bearer $token',
          },
          body: body);
      if (re.statusCode == 200) {
        var response = json.decode(re.body);
        print("$response");
        User.userData.totalpages = response['data']['total'];
        print("total no of pages: ${User.userData.totalpages}");
        var r = response['data'];
        print("data length:  ${r.length}");
        BotToast.closeAllLoading();
        for(int i=0;i<response['data']['data'].length;i++)
          {
            searchClinics.add(Clinic.fromMap(response['data']['data'][i]['clinic']));
            print("Search Clinics are: ${searchClinics.length}");
          }

        if (searchClinics.length <= response['data']['total']) {
          setState(() {
            finalData.addAll(searchClinics);
          });

          finalData.forEach((element) {
            print("Elements are:${element.name}");
          });
        }

        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    }
    print(searchClinics);
    BotToast.closeAllLoading();
    if (User.userData.searchClinics.contains(searchClinics)) {
    } else {
      User.userData.searchClinics.addAll(searchClinics);
    }
    return searchClinics;
  }

  @override
  void initState() {
    super.initState();
    searchClinic(
        departmentId: widget.departmentId,
        context: context,
        keyword: search ?? '',
        pageNo: page);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _dataProvider = Provider.of<DataProvider>(context);
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      // bottomNavigationBar: SafeArea(
      //   child: CustomBottomNavBar(),
      // ),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          //color: mainColor,
          child: Column(
            children: [
              // Container(
              //   height: height * .08,
              //   width: width,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           SizedBox(
              //             width: width * .03,
              //           ),
              //           InkWell(
              //             onTap: () {
              //               Navigator.pop(context);
              //             },
              //             child: Icon(
              //               Icons.arrow_back_ios,
              //               color: Colors.white,
              //             ),
              //           ),
              //           Spacer(),
              //           Container(
              //             width: width * .3,
              //             child: Text(
              //               // getTranslated(context, 'Home'),
              //               widget.departmentName,
              //               textAlign: TextAlign.center,
              //               overflow: TextOverflow.clip,
              //               style: labelTextStyle.copyWith(
              //                 color: Colors.white,
              //                 fontSize: width * .04,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //               maxLines: 1,
              //             ),
              //           ),
              //           Spacer(),
              //           SizedBox(
              //             width: width * .12,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Column(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                "${getTranslated(context, "clinics")}",
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
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width * .9,
                        height: height * .065,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            width * .02,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * .05,
                            ),
                            // SizedBox(
                            //   child: Icon(
                            //     Icons.search,
                            //     size: width * .05,
                            //     color: mainColor,
                            //   ),
                            // ),
                            SizedBox(
                              width: width * .01,
                            ),
                            Flexible(
                              child: TextField(
                                controller: searchTextEditingController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintStyle: hintTextStyle.copyWith(
                                      fontSize: width * .04,
                                      color: Colors.black),
                                  hintText:
                                  getTranslated(context, 'searchbyName'),
                                ),
                                onSubmitted: (value) {
                                  setState(() {
                                    search = value;
                                  });
                                },
                                style: labelTextStyle.copyWith(
                                  fontSize: width * .04,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: InkWell(
                                onTap: () {
                                  finalData.clear();
                                  setState(() {
                                    search = searchTextEditingController.text;
                                  });
                                  searchClinic(
                                      departmentId: widget.departmentId,
                                      context: context,
                                      keyword: search ?? '',
                                      pageNo: page);
                                },
                                child: Icon(
                                  Icons.search,
                                  size: width * .05,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * .01,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .04,
                    ),
                    child: Row(
                      children: [
                        Text(
                          getTranslated(context, 'clinics'),
                          style: labelTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (_dataProvider.departmentStyle == 1) {
                              _dataProvider.changeDepartmentStyle(2);
                            } else {
                              _dataProvider.changeDepartmentStyle(1);
                            }
                          },
                          child: Icon(
                            _dataProvider.departmentStyle == 1
                                ? Icons.grid_view
                                : Icons.list,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                ],
              ),
              ////////////////////////////////Se
              Expanded(
                  child: finalData.length == 0
                      ? Container(
                    child: Center(
                      child: Text(
                        getTranslated(context, 'noClinicFound'),
                        style: labelTextStyle.copyWith(
                          fontSize: width * .04,
                        ),
                      ),
                    ),
                  )
                      : Wrap(
                    children: [
                      Container(
                        height: height * .55,
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: false,
                          enablePullUp: true,
                          header: WaterDropHeader(),
                          onLoading: () async {
                            if (page < User.userData.totalpages) {
                              setState(() {
                                page = page + 1;
                                print("page increment: $page");
                                searchClinic(
                                    departmentId: widget.departmentId,
                                    context: context,
                                    keyword: search ?? '',
                                    pageNo: page);
                              });
                              _refreshController.loadComplete();
                            } else {
                              _refreshController.loadComplete();
                            }
                          },
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                              _dataProvider.departmentStyle,
                              mainAxisSpacing: .1,
                              crossAxisSpacing: .2,
                              childAspectRatio:
                              _dataProvider.departmentStyle == 1
                                  ? 1.8
                                  : 0.9,
                            ),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (finalData.length == 0) {
                                return Container(
                                  child: Center(
                                    child: Text(
                                      getTranslated(
                                          context, 'noClinicFound'),
                                      style: labelTextStyle.copyWith(
                                        fontSize: width * .04,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                LatLng clinicLocation = LatLng(
                                    double.parse(finalData[index]
                                        .latitude
                                        .toString()),
                                    double.parse(finalData[index]
                                        .longitude
                                        .toString()));

                                _dataProvider.departmentName =
                                    widget.departmentName;
                                return GestureDetector(
                                  onTap: () async {
                                    _dataProvider.departmentName =
                                        widget.departmentName;
                                    _dataProvider.clinicName =
                                    _widgetProvider.languageIndex == 1
                                        ? finalData[index].arabicName
                                        : finalData[index].name;

                                    final coordinates = Coordinates(
                                      clinicLocation.latitude,
                                      clinicLocation.longitude,
                                    );
                                    var findAddress = await Geocoder.local
                                        .findAddressesFromCoordinates(
                                        coordinates);
                                    String clinicAddress =
                                        findAddress.first.addressLine;
                                    Provider.of<DataProvider>(context,
                                        listen: false)
                                        .changeClinicAddress(
                                        clinicAddress);
                                    Provider.of<DataProvider>(context,
                                        listen: false)
                                        .changeSelectedDepartmentIndex(
                                        int.tryParse(
                                            widget.departmentId));
                                    Future.delayed(
                                      Duration(seconds: 0),
                                          () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => ClinicScreen(
                                                  clinicName: _widgetProvider.languageIndex == 1 ? finalData[index].name : finalData[index].arabicName,
                                                  clinicImage: APINetwork.BASE_URL + imagePath + finalData[index].imageURL,
                                                  departmentId: widget.departmentId,
                                                  clinicId: finalData[index].id.toString(),
                                                  clinicPhoneNumber: finalData[index].contactNo,
                                                  clinicTiming: finalData[index].openingTime.substring(0, 5) +
                                                      " " +
                                                      "-" +
                                                      " " +
                                                      finalData[index]
                                                          .closingTime
                                                          .substring(0, 5),
                                                  clinicLogo:
                                                  APINetwork.BASE_URL +
                                                      imagePath +
                                                      finalData[index]
                                                          .imageURL,
                                                  departmentName:
                                                  widget.departmentName,
                                                  clinicAddress:
                                                  clinicAddress,
                                                  currentLatLng: LatLng(
                                                    finalData[index].latitude,
                                                    finalData[index]
                                                        .longitude,
                                                  ),
                                                  insurances: finalData[index]
                                                      .insurances ??
                                                      [],
                                                  clinicRatings:
                                                  finalData[index]
                                                      .averageRatings
                                                      .toDouble(),
                                                ),
                                              ),
                                            );
                                      },
                                    );
                                  },
                                  child: ClinicCard(
                                    style: style,
                                    imageURL: APINetwork.BASE_URL +
                                        imagePath +
                                        finalData[index].imageURL,
                                    name:
                                    _widgetProvider.languageIndex == 1
                                        ? finalData[index].name
                                        : finalData[index].arabicName,
                                    clinicLocation: clinicLocation,
                                    ratings: finalData[index]
                                        .averageRatings
                                        .toDouble(),
                                  ),
                                );
                              }
                            },
                            itemCount: finalData.length,
                          ),
                        ),
                      ),
                    ],
                  )),
              // SizedBox(height: height*0.05,)
              // Container(
              //   //color: Colors.green,
              //   height: height * .7,
              //   width: width,
              //   //clipBehavior: Clip.hardEdge,
              //   // decoration: BoxDecoration(
              //   //   color: Theme.of(context).scaffoldBackgroundColor,
              //   //   borderRadius: BorderRadius.only(
              //   //     topLeft: Radius.circular(
              //   //       30,
              //   //     ),
              //   //     topRight: Radius.circular(
              //   //       30,
              //   //     ),
              //   //   ),
              //   // ),
              //   child: Container(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: width * .03,
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [

              //         // SizedBox(
              //         //   height: height * .08,
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   top: height * .08,
              //   left: width / 2.8,
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(
              //         20,
              //       ),
              //     ),
              //     clipBehavior: Clip.hardEdge,
              //     child: Container(
              //       width: width * .25,
              //       height: width * .25,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: NetworkImage(
              //             widget.departmentLogo,
              //           ),
              //           fit: BoxFit.fill,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
