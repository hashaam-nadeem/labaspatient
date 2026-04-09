import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/usersingalton.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/user_provider.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/labas_button.dart';
import 'package:Labas/widgets/title_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bottomSheet(
  String slot,
  BuildContext context,
  String clinicId,
  String doctorId,
  String departmentId,
  String currentDate,
  String startTime,
  String endTime,
  String correctDateFormat,
) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  var _userProvider = Provider.of<UserProvider>(context, listen: false);
  var _dataProvider = Provider.of<DataProvider>(context, listen: false);
  ApiClient apiClient = ApiClient();
  print("patient name is: ${_userProvider.nameTextEditingController.text}");
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
        height: height * .77,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(context, 'bookAppointment'),
                        style: labelTextStyle.copyWith(
                          fontSize: width * .04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
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
                          'patientName' ?? '',
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
                          _userProvider.nameTextEditingController.text ??
                              'Patient Name',
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
                          _dataProvider.doctorName ?? 'Doctor Name',
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
                          _dataProvider.clinicName ?? 'Clinic Name',
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
                      SizedBox(
                        height: height * .02,
                      ),
                      Text(
                        getTranslated(
                          context,
                          'specilization' ?? '',
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
                      //TODO: bottom_sheet changes
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${User.userData.departmentName}',
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
                          startTime + " / " + correctDateFormat,
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
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .03,
                    vertical: 5.0,
                  ),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () async {
                        print('Slot type is: $slot');
                        await apiClient.bookAppointment(
                          clinicId: clinicId,
                          departmentId: departmentId,
                          appointmentTime: slot == "morning" ? "0" : "1",
                          doctorId: doctorId,
                          appointmentDate: currentDate,
                          startTime: startTime,
                          endTime: endTime,
                          context: context,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            getTranslated(context, 'makeAppointment'),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
