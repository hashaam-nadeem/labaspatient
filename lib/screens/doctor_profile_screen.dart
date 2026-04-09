import 'package:Labas/component/doctor_about_subscreen.dart';
import 'package:Labas/component/doctor_appointment_subscreen.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/usersingalton.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/routes.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/navigation_bar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DoctorProfileScreen extends StatefulWidget {
  DateTime selectedDate;
  final String doctorName,
      mobileNumber,
      education,
      services,
      specialization,
      experience,
      longDescription,
      shortDescription,
      imageURL,
      doctorId,
      clinicId,
      departmentId,
      clinicName;
  final double averageRatings;
  DoctorProfileScreen({
    Key key,
    this.selectedDate,
    @required this.doctorName,
    @required this.departmentId,
    @required this.mobileNumber,
    @required this.education,
    @required this.services,
    @required this.specialization,
    @required this.experience,
    @required this.longDescription,
    @required this.shortDescription,
    @required this.imageURL,
    @required this.doctorId,
    @required this.clinicId,
    @required this.clinicName,
    @required this.averageRatings,
  }) : super(key: key);

  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen>
    with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ExpandableController _doctorInfoExpandableController = ExpandableController();

  @override
  void initState() {
    super.initState();
    print("doctor current rating: ${widget.averageRatings}");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(widget.doctorId);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      // bottomNavigationBar: SafeArea(
      //   child: CustomBottomNavBar(),
      // ),
      body: Stack(
        children: [
          Positioned(
            width: width,
            height: width * .44,
            top: width * .1,
            child: Container(
              color: Colors.transparent,
              height: height * .3,
              width: width * .6,
              child: Stack(
                children: [
                  Positioned(
                    top: height * .02,
                    width: width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: width,
                              height: height * .19,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ClipPath(
                                      clipper: OvalBottomBorderClipper(),
                                      child: Container(
                                        height: height * .19,
                                        width: width,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  greenColor,
                                                  mainColor
                                                ]),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    width * .13),
                                                bottomRight: Radius.circular(
                                                    width * .13))),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        width: width,
                                        height: height * .15,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(width * .8),
                                                bottomRight: Radius.circular(
                                                    width * .8))),
                                        child: Column(
                                          //  mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // SizedBox(
                                            //   height: height * 0.025,
                                            // ),
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
                                                // SizedBox(
                                                //   width: width * .03,
                                                // ),
                                                Expanded(
                                                  flex: 8,
                                                  child: GradientText(
                                                      "${getTranslated(context, "appointment")}",
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            mainColor,
                                                            greenColor,
                                                          ]),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                                Expanded(
                                                    flex: 1, child: Container())
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  padding: EdgeInsets.all(3),
                                                  width: width * .3,
                                                  height: height * .06,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
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
                                                          shape:
                                                              BoxShape.circle,
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
                      ],
                    ),

                    //  Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SizedBox(
                    //       width: width * .04,
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //       },
                    //       child: Icon(
                    //         Icons.arrow_back_ios,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     Spacer(),
                    //     Text(
                    //       getTranslated(context, 'account'),
                    //       style: labelTextStyle.copyWith(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     Spacer(),
                    //     SizedBox(
                    //       width: width * .04,
                    //     ),
                    //   ],
                    // ),
                  ),
                ],
              ),
            ),
          ),



          Positioned(
            width: width,
            top: height * .26,
            child: Container(
              width: width,
              height: height * .9,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                // color: Color(0xff234566),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height * .01,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * .28,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.doctorName ??
                                      getTranslated(context, 'doctorName'),
                                  maxLines: 1,
                                  style: labelTextStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: height * .005,
                                ),
                                Text(
                                  widget.specialization ??
                                      getTranslated(context, 'specialization'),
                                  maxLines: 1,
                                  style: labelTextStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: width * .03,
                                  ),
                                ),
                                SizedBox(
                                  height: height * .005,
                                ),
                                Text(
                                  widget.clinicName,
                                  maxLines: 1,
                                  style: labelTextStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: width * .03,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SmoothStarRating(
                                  rating: widget.averageRatings ?? 0.0,
                                  isReadOnly: true,
                                  size: width * .04,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ExpandableNotifier(
                            child: ExpandablePanel(
                              header: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * .04,
                                ),
                                child: Text(
                                  getTranslated(context, 'aboutDoctor'),
                                  style: labelTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04,
                                  ),
                                ),
                              ),
                              controller: _doctorInfoExpandableController,
                              expanded: DoctorAboutSubScreen(
                                doctorName: widget.doctorName,
                                education: widget.education,
                                experience: widget.experience,
                                mobileNumber: widget.mobileNumber,
                                longDescription: widget.longDescription,
                                services: widget.services,
                                shortDescription: widget.shortDescription,
                                specialization: widget.specialization,
                                imageURL: widget.imageURL,
                              ),
                            ),
                            controller: _doctorInfoExpandableController,
                          ),
                          DoctorAppointmentSubScreen(
                            selectedDate: widget.selectedDate,
                            doctorId: widget.doctorId,
                            departmentId: User.userData.departmentId.toString(),
                            clinicId: widget.clinicId,
                          ),
                          SizedBox(
                            height: height * .25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),




          Positioned(
            top: height * .255,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  width * .05,
                ),
              ),
              elevation: 8,
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: width * .25,
                height: width * .25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.imageURL,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                  // borderRadius: BorderRadius.circular(
                  //   width * .05,
                  // ),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
