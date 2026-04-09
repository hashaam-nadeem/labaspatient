import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/appointment_slots.dart';
import 'package:Labas/model/slot.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/modal_bottom_sheet.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentSubScreen extends StatefulWidget {
  DateTime                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    selectedDate;
  final String doctorId;
  final String clinicId;
  final String departmentId;

  DoctorAppointmentSubScreen({
    Key key,
    this.selectedDate,
    @required this.doctorId,
    @required this.departmentId,
    @required this.clinicId,
  }) : super(key: key);

  @override
  _DoctorAppointmentSubScreenState createState() =>
      _DoctorAppointmentSubScreenState();
}

class _DoctorAppointmentSubScreenState
    extends State<DoctorAppointmentSubScreen> {
  DateTime currentDateTime = DateTime.now();

  DateTime currentDate;
  String correctDateFormat;
  @override
  void initState() {
    super.initState();
    print('Selected Date: ${widget.selectedDate}');
    if (widget.selectedDate != null) {
      setState(() {
        currentDate = widget.selectedDate;
      });
    } else {
      setState(() {
        currentDate = DateTime.now();
      });
    }

    correctDateFormat = DateFormat('dd-MM-yyyy').format(currentDateTime);
  }

  ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(width * .03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * .03,
          ),
          Text(
            getTranslated(context, 'pickAppointment'),
            style: labelTextStyle.copyWith(
              fontSize: width * .04,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          DatePicker(
            DateTime.now(),
            initialSelectedDate: widget.selectedDate == null
                ? currentDateTime
                : widget.selectedDate,
            selectionColor: mainColor,
            onDateChange: (date) {
              setState(() {
                currentDate = date;
                correctDateFormat = DateFormat('dd-MM-yyyy').format(date);
              });
            },
            daysCount: 14,
          ),
          SizedBox(
            height: height * .03,
          ),
          FutureBuilder<List<Slot>>(
            future: apiClient.getAppointmentSlots(
              doctorId: widget.doctorId,
              date: DateFormat('yyyy-MM-dd').format(currentDate),
              context: context,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center();
              } else if (!snapshot.hasData) {
                return Container(
                  height: height * .2,
                  child: Center(
                    child: Text(
                      getTranslated(context, 'doctorNotAvailable'),
                      style: labelTextStyle.copyWith(
                        fontSize: width * .04,
                      ),
                    ),
                  ),
                );
              } else {
                print(snapshot.data);
                List<Slot> morningSlot = [];
                List<Slot> eveningSlots = [];
                if (snapshot.data.contains(null)) {
                  int i = snapshot.data.indexOf(null);
                  morningSlot.addAll(snapshot.data.sublist(0, i));
                  eveningSlots.addAll(snapshot.data.sublist(i + 1));
                } else {
                  eveningSlots.addAll(snapshot.data);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    morningSlot.length == 0
                        ? Container(
                            height: height * .2,
                            child: Center(
                              child: Text(
                                getTranslated(context, 'doctorNotAvailable'),
                                style: labelTextStyle.copyWith(
                                  fontSize: width * .04,
                                ),
                              ),
                            ),
                          )
                        : Text(
                            'Morning Timings',
                            style: labelTextStyle.copyWith(
                              fontSize: width * .04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    morningSlot.length == 0
                        ? SizedBox()
                        : SizedBox(
                            height: height * .03,
                          ),
                    morningSlot.length == 0
                        ? SizedBox()
                        : Center(
                            child: Wrap(
                              spacing: width * .03,
                              runSpacing: width * .03,
                              children: List.generate(
                                morningSlot.length,
                                (index) {
                                  int available = morningSlot[index].status;
                                  return GestureDetector(
                                    onTap: () {
                                      if (available == 0) {
                                        bottomSheet(
                                          "morning",
                                          context,
                                          widget.clinicId,
                                          widget.doctorId,
                                          widget.departmentId,
                                          DateFormat('yyyy-MM-dd')
                                              .format(currentDate),
                                          morningSlot[index].start,
                                          morningSlot[index].end,
                                          correctDateFormat,
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(width * .01),
                                      child: Container(
                                        width: width * .16,
                                        height: width * .16,
                                        decoration: BoxDecoration(
                                          color: available == 0
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            width * .03,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${morningSlot[index].start}',
                                            textAlign: TextAlign.center,
                                            style: labelTextStyle.copyWith(
                                              fontSize: width * .036,
                                              color: Colors.white,
                                            ),
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
                      height: height * .02,
                    ),
                    eveningSlots.length == 0
                        ? Container(
                            height: height * .2,
                            child: Center(
                              child: Text(
                                getTranslated(context, 'doctorNotAvailable'),
                                style: labelTextStyle.copyWith(
                                  fontSize: width * .04,
                                ),
                              ),
                            ),
                          )
                        : Text(
                            'Evening Timings',
                            style: labelTextStyle.copyWith(
                              fontSize: width * .04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    eveningSlots.length == 0
                        ? SizedBox()
                        : SizedBox(
                            height: height * .03,
                          ),
                    eveningSlots.length == 0
                        ? SizedBox()
                        : Center(
                            child: Wrap(
                              spacing: width * .03,
                              runSpacing: width * .03,
                              children: List.generate(
                                eveningSlots.length,
                                (index) {
                                  int available = eveningSlots[index].status;
                                  return GestureDetector(
                                    onTap: () {
                                      if (available == 0) {
                                        bottomSheet(
                                          "evening",
                                          context,
                                          widget.clinicId,
                                          widget.doctorId,
                                          widget.departmentId,
                                          DateFormat('yyyy-MM-dd')
                                              .format(currentDate),
                                          eveningSlots[index].start,
                                          eveningSlots[index].end,
                                          correctDateFormat,
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(width * .01),
                                      child: Container(
                                        width: width * .16,
                                        height: width * .16,
                                        decoration: BoxDecoration(
                                          color: available == 0
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            width * .03,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${eveningSlots[index].start}',
                                            textAlign: TextAlign.center,
                                            style: labelTextStyle.copyWith(
                                              fontSize: width * .036,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
