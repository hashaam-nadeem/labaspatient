import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/quick_appointment.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/location_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/doctor_profile_screen.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/doctor_card.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gradient_text/gradient_text.dart';
import 'department_to_clinics.dart';
import 'package:zo_gradient_icon/zo_gradient_icon.dart';

class QuickAppointment extends StatefulWidget {
  final String address;

  QuickAppointment({
    Key key,
    this.address,
  }) : super(key: key);

  @override
  _QuickAppointmentState createState() => _QuickAppointmentState();
}

class _QuickAppointmentState extends State<QuickAppointment> {
  int selectedIndex = 0;

  ApiClient apiClient = ApiClient();
  int currentPage = 1;
  DateTime currentDateTime = DateTime.now();

  String currentDate;
  String startTime, endTime;

  @override
  void initState() {
    super.initState();
    currentDate = DateFormat('yyyy-MM-dd').format(currentDateTime);
    startTime = DateFormat('HH:mm').format(currentDateTime);
    endTime = DateFormat('HH:mm:ss').format(currentDateTime);
  }

  TimeOfDay _time = TimeOfDay.now().replacing(minute: 0);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double aspectRadio = MediaQuery.of(context).size.aspectRatio;
    var _locationProvider = Provider.of<LocationProvider>(context);
    var _dataProvider = Provider.of<DataProvider>(context);
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(showPicker(
            context: context,
            value: _time,
            onChange: onTimeChanged,
            minuteInterval: MinuteInterval.FIVE,
            disableHour: false,
            disableMinute: false,
            minMinute: 7,
            maxMinute: 56,
            // Optional onChange to receive value as DateTime
            onChangeDateTime: (DateTime dateTime) {
              setState(() {
                startTime = DateFormat('HH:mm').format(dateTime);
                print('Time is :$startTime');
              });
            },
          ));
        },
        child: Container(
          width: width * .3,
          height: height * .05,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: mainColor),
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.timelapse, color: Colors.white),
                  Text(
                    "${getTranslated(context, 'startDate')}",
                    style: headingStyle.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          width: width * 1,
          height: height * 1,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: width,
                    height: height * .2,
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
                                      bottomLeft: Radius.circular(width * .9),
                                      bottomRight:
                                          Radius.circular(width * .9))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GradientText(
                                          "${getTranslated(context, "quickAppointment")}",
                                          gradient: LinearGradient(colors: [
                                            mainColor,
                                            greenColor,
                                          ]),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                              colors: [greenColor, mainColor]),
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
              Center(
                child: Text(
                  "${getTranslated(context, 'nearByDoctor')}",
                  maxLines: 1,
                  style: headingStyle.copyWith(
                    fontSize: width * .04,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // BotToast.showCustomLoading(toastBuilder: (v) {
                      //   return Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // });
                      await _locationProvider.getPatientLocation();
                      // BotToast.closeAllLoading();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlacePicker(
                            apiKey: 'AIzaSyBTG6MlmkHSmhWwKdAd3pZYMOz6Nz2sNqk',
                            initialPosition: _locationProvider.locationData ==
                                    null
                                ? LatLng(
                                    25.2854,
                                    51.5310,
                                  )
                                : LatLng(
                                    _locationProvider.locationData.latitude,
                                    _locationProvider.locationData.longitude,
                                  ),
                            useCurrentLocation: true,
                            onPlacePicked: (value) async {
                              final coordinates = Coordinates(
                                value.geometry.location.lat,
                                value.geometry.location.lng,
                              );
                              final findAddresses = await Geocoder.local
                                  .findAddressesFromCoordinates(
                                coordinates,
                              );
                              _locationProvider.changeAddress(
                                  findAddresses.first.addressLine);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: width,
                      height: height * .06,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [greenColor, mainColor]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Text(
                                  _locationProvider.address ??
                                      getTranslated(context, 'pickLocation') ??
                                      '',
                                  maxLines: 1,
                                  style: headingStyle.copyWith(
                                    fontSize: width * .04,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Container(
              //   height: height * .05,
              //   decoration: BoxDecoration(
              //     color: Colors.grey[200],
              //     borderRadius: BorderRadius.circular(
              //       width * .03,
              //     ),
              //   ),
              //   clipBehavior: Clip.antiAliasWithSaveLayer,
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: width * .02,
              //       ),
              //       Expanded(
              //         child: Text(
              //           _locationProvider.address ??
              //               getTranslated(context, 'pickLocation') ??
              //               '',
              //           maxLines: 1,
              //           style: labelTextStyle.copyWith(
              //             fontSize: width * .035,
              //             color: Colors.grey[600],
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       Container(
              //         width: width * .36,
              //         height: height * .06,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(
              //             width * .03,
              //           ),
              //           color: mainColor,
              //         ),
              //         clipBehavior: Clip.antiAliasWithSaveLayer,
              //         child: InkWell(
              //           onTap: () async {
              //             BotToast.showCustomLoading(toastBuilder: (v) {
              //               return Center(
              //                 child: CircularProgressIndicator(),
              //               );
              //             });
              //             await _locationProvider.getPatientLocation();
              //             BotToast.closeAllLoading();
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (_) => PlacePicker(
              //                   apiKey:
              //                       'AIzaSyBTG6MlmkHSmhWwKdAd3pZYMOz6Nz2sNqk',
              //                   initialPosition: LatLng(
              //                     _locationProvider.locationData.latitude,
              //                     _locationProvider.locationData.longitude,
              //                   ),
              //                   useCurrentLocation: true,
              //                   onPlacePicked: (value) async {
              //                     final coordinates = Coordinates(
              //                       value.geometry.location.lat,
              //                       value.geometry.location.lng,
              //                     );
              //                     final findAddresses = await Geocoder.local
              //                         .findAddressesFromCoordinates(
              //                       coordinates,
              //                     );
              //                     _locationProvider.changeAddress(
              //                         findAddresses.first.addressLine);
              //                     Navigator.pop(context);
              //                   },
              //                 ),
              //               ),
              //             );
              //           },
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               Flexible(
              //                 child: Text(
              //                   getTranslated(context, 'selectLocation') ?? '',
              //                   maxLines: 1,
              //                   style: labelTextStyle.copyWith(
              //                     fontSize: width * .032,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: width * .01,
              //               ),
              //               Icon(
              //                 Icons.my_location,
              //                 color: Colors.white,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              SizedBox(
                height: height * .02,
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    _dataProvider.allDepartments.length,
                    (index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            width * .04,
                          ),
                        ),
                        color: selectedIndex ==
                                _dataProvider.allDepartments[index].id
                            ? Colors.blue[100]
                            : null,
                        shadowColor: Colors.grey[200],
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 05,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex =
                                  _dataProvider.allDepartments[index].id;
                            });
                          },
                          child: Container(
                            width: height * .15,
                            height: height * .12,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: height * .08,
                                      height: height * .08,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: SizedBox(
                                        width: width * .08,
                                        height: height * .08,
                                        child: FadeInImage.assetNetwork(
                                          placeholder: appLogo,
                                          image: APINetwork.BASE_URL +
                                              _dataProvider
                                                  .allDepartments[index]
                                                  .imageURL,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          width * .03,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        _widgetProvider.languageIndex == 1
                                            ? _dataProvider
                                                .allDepartments[index].name
                                            : _dataProvider
                                                .allDepartments[index]
                                                .arabicName,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        style: labelTextStyle.copyWith(
                                          fontSize: width * .03,
                                          color: selectedIndex ==
                                                  _dataProvider
                                                      .allDepartments[index].id
                                              ? mainColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: currentDateTime,
                selectionColor: mainColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    currentDateTime = date;
                    currentDate = DateFormat('yyyy-MM-dd').format(date);
                  });
                },
                daysCount: 7,
              ),
              SizedBox(
                height: height * .03,
              ),
              FutureBuilder<List<Appointment>>(
                future: apiClient.quickAppointment(
                  context,
                  selectedIndex == 0 ? null : "$selectedIndex",
                  currentDate,
                  startTime,
                  endTime,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: height * .25,
                      color: Colors.white,
                      child: GridView.builder(
                        padding: EdgeInsets.all(0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: width * .03,
                          crossAxisSpacing: width * .06,
                          childAspectRatio: aspectRadio * 1.82,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data.length != 0) {
                            return GestureDetector(
                              onTap: () {
                                _dataProvider.doctorName =
                                    _widgetProvider.languageIndex == 1
                                        ? snapshot.data[index].arabicTitle
                                        : snapshot.data[index].name;
                                _dataProvider.clinicName =
                                    snapshot.data[index].clinic.name;
                                print(snapshot.data[index].imageURL);
                                _dataProvider.departmentName =
                                    snapshot.data[index].departmentName;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DoctorProfileScreen(
                                      selectedDate: currentDateTime,
                                      departmentId:
                                          snapshot.data[index].id.toString(),
                                      doctorName:
                                          snapshot.data[index].name ?? '',
                                      mobileNumber:
                                          snapshot.data[index].mobileNumber ??
                                              '',
                                      education:
                                          snapshot.data[index].education ?? '',
                                      services:
                                          snapshot.data[index].services ?? '',
                                      specialization:
                                          snapshot.data[index].specialization ??
                                              '',
                                      experience:
                                          snapshot.data[index].experience ?? '',
                                      longDescription: snapshot
                                              .data[index].longDescription ??
                                          '',
                                      shortDescription: snapshot
                                              .data[index].shortDescription ??
                                          '',
                                      imageURL: APINetwork.BASE_URL +
                                          snapshot.data[index].imageURL,
                                      doctorId:
                                          snapshot.data[index].id.toString() ??
                                              '',
                                      clinicId: snapshot.data[index].clinic.id
                                              .toString() ??
                                          '',
                                      clinicName:
                                          _widgetProvider.languageIndex == 1
                                              ? snapshot
                                                  .data[index].clinic.arabicName
                                              : snapshot
                                                  .data[index].clinic.name,
                                      averageRatings: snapshot
                                              .data[index].averageRatings
                                              .toDouble() ??
                                          0.0,
                                    ),
                                  ),
                                );
                              },
                              child: DoctorCard(
                                style: 2,
                                imageURL: APINetwork.BASE_URL +
                                    snapshot.data[index].imageURL,
                                name: snapshot.data[index].name,
                                specialization:
                                    snapshot.data[index].specialization,
                                ratings: snapshot.data[index].averageRatings
                                    .toDouble(),
                              ),
                            );
                          } else {
                            return Container(
                              height: height * .2,
                              child: Center(
                                child: Text(
                                  getTranslated(
                                          context, 'doctorNotAvailable') ??
                                      '',
                                  style: labelTextStyle.copyWith(
                                    fontSize: width * .04,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center();
                  } else if (!snapshot.hasData) {
                    return Container(
                      height: height * .2,
                      child: Center(
                        child: Text(
                          getTranslated(context, 'doctorNotAvailable') ?? '',
                          style: labelTextStyle.copyWith(
                            fontSize: width * .04,
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.data.length == null) {
                    return Container(
                      height: height * .2,
                      child: Center(
                        child: Text(
                          getTranslated(context, 'doctorNotAvailable') ?? '',
                          style: labelTextStyle.copyWith(
                            fontSize: width * .04,
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.data.length == 0) {
                    return Container(
                      height: height * .2,
                      child: Center(
                        child: Text(
                          getTranslated(context, 'doctorNotAvailable') ?? '',
                          style: labelTextStyle.copyWith(
                            fontSize: width * .04,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: height * .2,
                      child: Center(
                        child: Text(
                          getTranslated(context, 'doctorNotAvailable') ?? '',
                          style: labelTextStyle.copyWith(
                            fontSize: width * .04,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              // Container(
              //   height: height * .06,
              //   width: width,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //   ),
              //   clipBehavior: Clip.antiAliasWithSaveLayer,
              //   child: Row(
              //     children: [
              //       Container(
              //         width: width * .96,
              //         child: FlatButton(
              //           color: greenColor,
              //           onPressed: () {

              //           },
              //           child: Center(
              //             child: Text(
              //               getTranslated(context, 'startDate'),
              //               style: labelTextStyle.copyWith(
              //                 fontSize: width * .04,
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
