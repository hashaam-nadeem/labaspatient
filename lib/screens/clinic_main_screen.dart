import 'dart:convert';

import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/clinic.dart';
import 'package:Labas/model/insurance.dart';
import 'package:Labas/model/usersingalton.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/location_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:Labas/utilis/globals.dart';
import 'package:Labas/utilis/shared_preferences.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/clinic_card.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'clinic_screen.dart';

class MainClinicScreen extends StatefulWidget {
  const MainClinicScreen({Key key}) : super(key: key);

  @override
  _MainClinicScreenState createState() => _MainClinicScreenState();
}

class _MainClinicScreenState extends State<MainClinicScreen> {
  ApiClient apiClient = ApiClient();
  List<Clinic> finalData = new List<Clinic>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController searchTextEditingController = TextEditingController();
  String search;
  int page = 0;
  searchClinic(
      {@required String keyword,
      @required String departmentId,
      @required BuildContext context,
      @required int pageNo}) async {
    String token = await getBearerToken();
    List<Clinic> searchClinics = [];
    var body = {
      "department_id": "",
      "search": keyword ?? '',
    };
    // print("my body is::$body");
    // print("token/;  $token");
    // var _dataProvider = Provider.of<DataProvider>(context, listen: false);
    if (token.isNotEmpty) {
      BotToast.showCustomLoading(toastBuilder: (e) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
      print(APINetwork.BASE_URL + APINetwork.SEARCH);
      var re = await http.post(
          "${APINetwork.BASE_URL}${APINetwork.SEARCH}?page=$pageNo",
          headers: {
            "Authorization": 'Bearer $token',
          },
          body: body);
      if (re.statusCode == 200) {
        var response = json.decode(re.body);
        // print("$response");
        User.userData.totalpages = response['last_page'];

        // print("total no of pages: ${User.userData.totalpages}");
        var r = response['data'];
        // ClinicNewModel clinicNewModel = ClinicNewModel();
        // clinicNewModel = ClinicNewModel.fromJson(res);
        // print(clinicNewModel.result);
        BotToast.closeAllLoading();
        r.forEach((eachClinic) {
          //  print('Clinics: $eachClinic');
          searchClinics.add(Clinic.fromMap(eachClinic['clinic']));
        });

        var data;
        //maintainedsearchClinics = maintainedsearchClinics + searchClinics;
        var dataLength = searchClinics.length;
        if (searchClinics.length <= response['total']) {
          // data = searchClinic;
          setState(() {
            finalData.addAll(searchClinics);
          });
        }

        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    }
    // print("Search Clinics are :::: $searchClinics");
    //searchClinics.addAll(maintainedsearchClinics);
    BotToast.closeAllLoading();
    if (User.userData.searchClinics.contains(searchClinics)) {
    } else {
      User.userData.searchClinics.addAll(searchClinics);
    }
    // User.userData.searchClinics.addAll(searchClinics);
    return searchClinics;
  }

  @override
  void initState() {
    super.initState();
    searchClinic(
        keyword: search == null ? "" : search,
        context: context,
        departmentId: null,
        pageNo: page);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // var _locationProvider = Provider.of<LocationProvider>(context);
    var _dataProvider = Provider.of<DataProvider>(context);
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    // var totalPages = Provider.of<DataProvider>(context, listen: false).getPages;
    return Scaffold(


      body: SafeArea(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: width,
                      height: height * .21,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: OvalBottomBorderClipper(),
                              child: Container(
                                height: height * .21,
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
                                padding: EdgeInsets.only(left: 10, right: 10),
                                height: height * .18,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(width * .9),
                                        bottomRight:
                                            Radius.circular(width * .9))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //Expanded(child: Container()),
                                        GradientText(
                                            "${getTranslated(context, "clinic")}",
                                            gradient: LinearGradient(colors: [
                                              mainColor,
                                              greenColor,
                                            ]),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center),
                                        // GestureDetector(
                                        //   onTap: () async {
                                        //     BotToast.showCustomLoading(
                                        //         toastBuilder: (v) {
                                        //       return Center(
                                        //         child:
                                        //             CircularProgressIndicator(),
                                        //       );
                                        //     });
                                        //     await _locationProvider
                                        //         .getPatientLocation();
                                        //     BotToast.closeAllLoading();
                                        //   },
                                        //   child: Icon(
                                        //     Icons.location_on,
                                        //     color: greenColor,
                                        //   ),
                                        // ),
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
                                                Icons.calendar_today,
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
                SizedBox(
                  height: height * .01,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    getTranslated(context, 'clinic'),
                    style: labelTextStyle.copyWith(
                      fontSize: width * .06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * .9,
                      height: height * .06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          width * .02,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * .01,
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
                          Container(
                            width: width * .78,
                            height: height * .06,
                            child: TextField(
                              controller: searchTextEditingController,
                              decoration: InputDecoration(
                                hintStyle: hintTextStyle.copyWith(
                                  fontSize: width * .04,
                                ),
                                hintText: getTranslated(context, 'search'),
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
                                setState(() {
                                  finalData.clear();
                                  print(
                                      'List is cleard length is: ${finalData.length}');
                                  search = searchTextEditingController.text;
                                  searchClinic(
                                      keyword: search == null ? "" : search,
                                      context: context,
                                      departmentId: null,
                                      pageNo: page);
                                });
                              },
                              child: Icon(
                                Icons.search,
                                size: width * .08,
                                color: mainColor,
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
                  height: height * .01,
                ),
              ],
            ),
            Expanded(
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
                        departmentId: null,
                        context: context,
                        keyword: search ?? '',
                        pageNo: page);
                  });
                  _refreshController.loadComplete();
                } else {
                  _refreshController.loadComplete();
                }
              },
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
                          //   height: height * .6,
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
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
                                      getTranslated(context, 'noClinicFound'),
                                      style: labelTextStyle.copyWith(
                                        fontSize: width * .04,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                LatLng clinicLocation = LatLng(
                                    double.parse(
                                        finalData[index].latitude.toString()),
                                    double.parse(
                                        finalData[index].longitude.toString()));

                                return GestureDetector(
                                  onTap: () async {
                                    _dataProvider.departmentName = "All";
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
                                        .changeClinicAddress(clinicAddress);

                                    Future.delayed(
                                      Duration(seconds: 0),
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ClinicScreen(
                                              clinicName: _widgetProvider
                                                          .languageIndex ==
                                                      1
                                                  ? finalData[index].name
                                                  : finalData[index].arabicName,
                                              clinicImage: APINetwork.BASE_URL +
                                                  imagePath +
                                                  finalData[index].imageURL,
                                              departmentId: "",
                                              clinicId: finalData[index]
                                                  .id
                                                  .toString(),
                                              clinicPhoneNumber:
                                                  finalData[index].contactNo,
                                              clinicTiming: finalData[index]
                                                      .openingTime
                                                      .substring(0, 5) +
                                                  " " +
                                                  "-" +
                                                  " " +
                                                  finalData[index]
                                                      .closingTime
                                                      .substring(0, 5),
                                              clinicLogo: APINetwork.BASE_URL +
                                                  imagePath +
                                                  finalData[index].imageURL,
                                              departmentName: "",
                                              clinicAddress: clinicAddress,
                                              currentLatLng: LatLng(
                                                finalData[index].latitude,
                                                finalData[index].longitude,
                                              ),
                                              insurances:
                                                  finalData[index].insurances ??
                                                      [],
                                              clinicRatings: finalData[index]
                                                  .averageRatings
                                                  .toDouble(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: ClinicCard(
                                    style: 1,
                                    imageURL: APINetwork.BASE_URL +
                                        imagePath +
                                        finalData[index].imageURL,
                                    name: _widgetProvider.languageIndex == 1
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
                      ],
                    ),
            )),
          ],
        ),
      ),
    );
  }
}
