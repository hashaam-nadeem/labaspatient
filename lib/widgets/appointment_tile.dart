import 'dart:ui';

import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:url_launcher/url_launcher.dart';

import 'alert_dialog.dart';

class AppointmentTile extends StatefulWidget {
  final String doctorImageURL,
      doctorName,
      currentDate,
      startTime,
      endTime,
      clinicName,
      doctorSpecialization,
      doctorId,
      clinicId,
      appointmentId,
      doctorArabic,
      clinicArabic;
  final int rating, patientAvailability;
  final VoidCallback cancelAppointmentFunction, submitRatingsFunction;

  final double latitude, longitude;

  AppointmentTile({
    Key key,
    this.doctorImageURL,
    this.doctorName,
    this.currentDate,
    this.clinicArabic,
    this.doctorArabic,
    this.startTime,
    this.endTime,
    this.clinicName,
    this.doctorSpecialization,
    this.latitude,
    this.longitude,
    @required this.appointmentId,
    @required this.clinicId,
    @required this.doctorId,
    @required this.rating,
    @required this.patientAvailability,
    @required this.cancelAppointmentFunction,
    @required this.submitRatingsFunction,
  }) : super(key: key);

  @override
  _AppointmentTileState createState() => _AppointmentTileState();
}

class _AppointmentTileState extends State<AppointmentTile> {
  String address;

  clinicAddress() async {
    final coordiantes = Coordinates(widget.latitude, widget.longitude);
    final findAddress =
        await Geocoder.local.findAddressesFromCoordinates(coordiantes);
    setState(() {
      address = findAddress.first.addressLine;
    });
  }

  @override
  void initState() {
    super.initState();
    print('Rating: ${widget.rating} : name is:${widget.doctorName}');
    clinicAddress();
  }

  ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(widget.patientAvailability);
    return GestureDetector(
      onTap: () {
        bottomSheet(widget.appointmentId, widget.doctorName,
            widget.doctorSpecialization, widget.clinicName, widget.currentDate);
      },
      child: Card(
        elevation: 5,
        child: Container(
          // height: height * .2,
          width: width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                      child: Container(
                        width: width * .2,
                        height: width * .2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.doctorImageURL ??
                                  'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?size=338&ext=jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * .02,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var googleMap =
                                        "google.navigation:q=${widget.latitude},${widget.longitude}";
                                    await canLaunch(googleMap)
                                        ? launch(googleMap)
                                        : print(
                                            "open google Map app link or do a snackbar with notification that there is no google Map installed");
                                  },
                                  child: Icon(
                                    Icons.location_on,
                                    color: greenColor,
                                    size: height * .04,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${getTranslated(context, "appointment_no")}: ${widget.appointmentId}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: labelTextStyle.copyWith(
                                fontSize: width * .03,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${getTranslated(context, "date")}: ${widget.currentDate}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: labelTextStyle.copyWith(
                                  fontSize: width * .03,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              // "${getTranslated(context, "doctor")}: ${widget.doctorName}",
                              "Doctor: ${widget.doctorName}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: labelTextStyle.copyWith(
                                fontSize: width * .03,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${getTranslated(context, "specialization")}: ${widget.doctorSpecialization}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: labelTextStyle.copyWith(
                                fontSize: width * .03,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${getTranslated(context, "clinic")}: ${widget.clinicName}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: labelTextStyle.copyWith(
                                fontSize: width * .03,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.patientAvailability == 0
                                      ? "${getTranslated(context, "reserve",)}"
                                      : widget.patientAvailability == 1
                                          ? "${getTranslated(context, "checked")}"
                                          : widget.patientAvailability == 2
                                              ? "${getTranslated(context, "cancelled",)}"
                                              : widget.patientAvailability == 3
                                                  ? "${getTranslated(context, "doctor_cancel")}"
                                                  : "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: labelTextStyle.copyWith(
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.bold,
                                    color: greenColor,
                                    // color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            widget.rating == 1
                                ? Container()
                                : widget.patientAvailability == 1
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * .03,
                                          decoration: BoxDecoration(),
                                          child: FlatButton(
                                            color: Colors.blue[200],
                                            onPressed: () {
                                              widget.submitRatingsFunction();
                                            },
                                            child: Text(
                                              getTranslated(context, 'rateNow'),
                                              style: labelTextStyle.copyWith(
                                                fontSize: width * .03,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : widget.patientAvailability == 0
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: height * .03,
                                              child: FlatButton(
                                                color: Colors.red,
                                                onPressed: () {
                                                  widget
                                                      .cancelAppointmentFunction();
                                                },
                                                child: Text(
                                                  '${getTranslated(context, "cancel")}',
                                                  style:
                                                      labelTextStyle.copyWith(
                                                    fontSize: width * .03,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              // Padding(
              //   padding: EdgeInsets.all(
              //     width * .02,
              //   ),
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: width * .02,
              //       ),

              //       Spacer(),
              //       Icon(
              //         Icons.location_on,
              //         size: width * .05,
              //       ),
              //       SizedBox(
              //         width: width * .02,
              //       ),
              //       Container(
              //         width: width * .3,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: [
              //             Flexible(
              //               child: Text(
              //                 address ?? '',
              //                 maxLines: 1,
              //                 style: labelTextStyle.copyWith(
              //                   fontSize: width * .03,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(
              //   color: Colors.black54,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bottomSheet(appointmentNo, name, specilization, clinic, date) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            width * .06,
          ),
          topRight: Radius.circular(
            width * .06,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Container(
          height: height * .6,
          width: width,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * .08,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xffF7F7F7),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      SizedBox(
                        height: height * .001,
                      ),
                      Divider(
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .03,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(
                            context,
                            'appointment_no' ?? '',
                          ),
                          textAlign: TextAlign.start,
                          style: hintTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$appointmentNo",
                            textAlign: TextAlign.start,
                            style: hintTextStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          height: 1.0,
                          color: Colors.black54,
                        ),
                        // TitleContainer(
                        //     title: _dataProvider.patientName ?? 'Patient Name'),
                        SizedBox(
                          height: height * .02,
                        ),
                        Text(
                          getTranslated(
                            context,
                            'doctorNames' ?? '',
                          ),
                          textAlign: TextAlign.start,
                          style: hintTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$name",
                            textAlign: TextAlign.start,
                            style: hintTextStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          height: 1.0,
                          color: Colors.black54,
                        ),

                        ////////////Location
                        SizedBox(
                          height: height * .02,
                        ),
                        Text(
                          getTranslated(
                            context,
                            'clinic' ?? '',
                          ),
                          textAlign: TextAlign.start,
                          style: hintTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$clinic",
                            textAlign: TextAlign.start,
                            style: hintTextStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          height: 1.0,
                          color: Colors.black54,
                        ),

                        //////////Appointment Type

                        Container(
                          width: width,
                          height: 1.0,
                          color: Colors.black54,
                        ),

                        /////////Appointment slot
                        SizedBox(
                          height: height * .02,
                        ),
                        Text(
                          getTranslated(
                            context,
                            'appointmentSlot' ?? '',
                          ),
                          textAlign: TextAlign.start,
                          style: hintTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$date",
                            textAlign: TextAlign.start,
                            style: hintTextStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          height: 1.0,
                          color: Colors.black54,
                        ),
                      ],
                    )),
                SizedBox(
                  height: height * .02,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
