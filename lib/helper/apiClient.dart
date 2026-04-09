import 'dart:convert';
import 'dart:math';

import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/appointment_detail.dart';
import 'package:Labas/model/appointment_slots.dart';
import 'package:Labas/model/checkup.dart';
import 'package:Labas/model/clinic.dart';
import 'package:Labas/model/clinicnewmodel.dart';
import 'package:Labas/model/department.dart';
import 'package:Labas/model/doctor.dart';
import 'package:Labas/model/insurance.dart';
import 'package:Labas/model/patient.dart';
import 'package:Labas/model/quick_appointment.dart';
import 'package:Labas/model/slider.dart';
import 'package:Labas/model/slot.dart';
import 'package:Labas/model/usersingalton.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/location_provider.dart';
import 'package:Labas/provider/user_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/all_appointments_screen.dart';
import 'package:Labas/screens/change_password_screen.dart';
import 'package:Labas/utilis/routes.dart';
import 'package:Labas/widgets/successMeetingDialog.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:Labas/screens/login_screen.dart';
import 'package:Labas/screens/main_screen.dart';
import 'package:Labas/screens/otp_screen.dart';
import 'package:Labas/screens/set_new_password.dart';
import 'package:Labas/screens/success_screen.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:Labas/utilis/shared_preferences.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/loading_bottom_sheet.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiClient {
  static const int _COUNT = 10;
  //PATIENT LOGIN

  Future signIn(
      {@required String mobileNo,
      @required String password,
      @required BuildContext context,
      @required String token}) async {
    var _userProvider = Provider.of<UserProvider>(context, listen: false);
    // print({"mobile": "+$mobileNo", "password": password, "fcm_token": token});
    print(APINetwork.BASE_URL + APINetwork.LOGIN_URL);
    await http.post(
      APINetwork.BASE_URL + APINetwork.LOGIN_URL,
      body: {"mobile": "+$mobileNo", "password": password, "fcm_token": token},
    ).then((value) async {
      var response = json.decode(value.body);
      // print("sign in response: $response");
      if (!response['error']) {
        ArsProgressDialog progressDialog = ArsProgressDialog(context,
            blur: 2,
            backgroundColor: Color(0x33000000),
            animationDuration: Duration(milliseconds: 500));
        progressDialog.show();

        // showBottomLoading(
        //   context,
        //   title: getTranslated(context, 'loggingIn'),
        //   message: getTranslated(context, 'pleaseWaitText'),
        // );
        await Future.delayed(
          Duration(seconds: 1),
          () async {
            Patient patient = Patient.fromJson(response['user']);
            await _userProvider.changePatientData(patient);
            await _userProvider.changeBearerToken(response['access_token']);
            await setBearerToken(_userProvider.bearerToken);
            await getProfile(context);
            await getSliderImages(context: context);
            await getDepartments(context);
            await getInsurances(context);
            progressDialog.dismiss();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => MainScreen(),
              ),
              (route) => false,
            );
          },
        );
      } else {
        BotToast.showText(
          text: getTranslated(context, 'enterCorrectCredentials'),
          textStyle: labelTextStyle.copyWith(
            fontSize: 10,
            color: Colors.white,
          ),
          contentColor: Colors.red,
        );
      }
    });
  }

  Future registerMobileNumber({
    @required String mobileNumber,
    @required BuildContext context,
  }) async {
    var body = {
      "mobile": mobileNumber,
    };
    print(body);
    await http
        .post(APINetwork.BASE_URL + APINetwork.REGISTER_MOBILE, body: body)
        .then(
      (value) {
        var response = json.decode(value.body);
        print("sing up resposnsd: $response");
        if (!response['message'].toLowerCase().contains("already")) {
          ArsProgressDialog progressDialog = ArsProgressDialog(context,
              blur: 2,
              backgroundColor: Color(0x33000000),
              animationDuration: Duration(milliseconds: 500));
          progressDialog.show();
          // showBottomLoading(
          //   context,
          //   title: getTranslated(context, 'loading'),
          //   message: getTranslated(context, 'pleaseWait'),
          // );
          Future.delayed(
            Duration(seconds: 1),
            () {
              progressDialog.dismiss();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => OTPScreen(
                    mobileNumber: mobileNumber,
                  ),
                ),
                (route) => false,
              );
            },
          );
        } else {
          BotToast.showText(
            text: response['message'],
            textStyle: labelTextStyle.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
            contentColor: Colors.red,
          );
        }
      },
    );
  }

  Future verifyRegistrationOTP({
    @required String mobileNumber,
    @required String otpCode,
    @required BuildContext context,
  }) async {
    print("mobile and opt is: $mobileNumber + $otpCode");
    await http.post(
      APINetwork.BASE_URL + APINetwork.VERIFY_OTPCODE_REGISTERATION,
      body: {
        "mobile": mobileNumber,
        "otp": otpCode,
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (!response['message'].toLowerCase().contains("invalid")) {
        ArsProgressDialog progressDialog = ArsProgressDialog(context,
            blur: 2,
            backgroundColor: Color(0x33000000),
            animationDuration: Duration(milliseconds: 500));
        progressDialog.show();
        // showBottomLoading(context,
        //     title: getTranslated(context, 'loading'),
        //     message: getTranslated(context, 'pleaseWait'));
        Future.delayed(Duration(seconds: 1), () {
          progressDialog.dismiss();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => SetNewPasswordScreen(
                mobileNumber: mobileNumber,
                otp: otpCode,
              ),
            ),
            (route) => false,
          );
        });
      } else {
        BotToast.showText(
          text: 'Invalid OTP Code',
          textStyle: labelTextStyle.copyWith(
            fontSize: 10,
            color: Colors.white,
          ),
          contentColor: Colors.red,
        );
      }
    });
  }

  Future setNewPassword(
      {@required String mobileNumber,
      @required String otpCode,
      @required String password,
      @required BuildContext context}) async {
    print(mobileNumber + otpCode + password);
    var _userProvider = Provider.of<UserProvider>(context, listen: false);
    await http.post(
      APINetwork.BASE_URL + APINetwork.SET_PASSWORD_REGISTERATION,
      body: {
        "mobile": mobileNumber,
        "otp": otpCode,
        "password": password,
      },
    ).then((value) async {
      var response = json.decode(value.body);
      if (!response['message'].toLowerCase().contains("invalid")) {
        ArsProgressDialog progressDialog = ArsProgressDialog(context,
            blur: 2,
            backgroundColor: Color(0x33000000),
            animationDuration: Duration(milliseconds: 500));
        progressDialog.show();
        // showBottomLoading(context,
        //     title: getTranslated(context, 'pleaseWait'),
        //     message: getTranslated(context, 'updatingPassword'));
        await Future.delayed(
          Duration(seconds: 1),
          () async {
            Patient patient = Patient.fromJson(response['data']);
            await _userProvider.changePatientData(patient);
            await _userProvider.changeBearerToken(response['data']['token']);
            await setBearerToken(_userProvider.bearerToken);
            await getProfile(context);
            await getDepartments(context);
            progressDialog.dismiss();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => MainScreen(),
                ),
                (route) => false);
          },
        );
      } else {
        BotToast.showText(
          text: getTranslated(context, 'alreadyRegister'),
          textStyle: labelTextStyle.copyWith(
            fontSize: 10,
            color: Colors.white,
          ),
          contentColor: Colors.red,
        );
      }
    });
  }

  Future forgotPasswordMobileNumber({
    @required String mobileNumber,
    @required BuildContext context,
  }) async {
    print('Forget mobile number is: "{mobile: +$mobileNumber}"');
    await http.post(
      APINetwork.BASE_URL + APINetwork.RESET_PASSWORD_REQUEST_MOBILE_NO,
      body: {
        "mobile": "+" + mobileNumber,
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response["message"].toLowerCase().contains("sent")) {
        ArsProgressDialog progressDialog = ArsProgressDialog(context,
            blur: 2,
            backgroundColor: Color(0x33000000),
            animationDuration: Duration(milliseconds: 500));
        progressDialog.show();
        Future.delayed(
            Duration(
              seconds: 1,
            ), () {
          progressDialog.dismiss();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OTPScreen(
                mobileNumber: mobileNumber,
                isSetNewPasswordRoute: false,
              ),
            ),
          );
        });
      } else {
        BotToast.showText(
          text: getTranslated(context, "mobileNotRegistered"),
          textStyle: labelTextStyle.copyWith(
            fontSize: 10,
            color: Colors.white,
          ),
          contentColor: Colors.red,
        );
      }
    });
  }

  Future verifyOTPForgotPassword({
    @required String mobileNumber,
    @required String otpCode,
    @required BuildContext context,
  }) async {
    print("Verify OTP +$mobileNumber and otp is: $otpCode");
    await http.post(
      APINetwork.BASE_URL + APINetwork.VERIFY_OTPCODE_RESET_PASSWORD,
      body: {
        "mobile": "+" + mobileNumber,
        "otp": otpCode,
      },
    ).then((value) {
      var response = jsonDecode(value.body);
      if (!response['message'].toLowerCase().contains("incorrect")) {
        ArsProgressDialog progressDialog = ArsProgressDialog(context,
            blur: 2,
            backgroundColor: Color(0x33000000),
            animationDuration: Duration(milliseconds: 500));
        progressDialog.show();
        Future.delayed(
            Duration(
              seconds: 1,
            ), () {
          progressDialog.dismiss();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => ChangePasswordScreen(
                mobileNumber: mobileNumber,
                otp: otpCode,
              ),
            ),
            (route) => false,
          );
        });
      } else {
        BotToast.showText(
          text: getTranslated(context, 'incorrectPin'),
          textStyle: labelTextStyle.copyWith(
            fontSize: 10,
            color: Colors.white,
          ),
          contentColor: Colors.red,
        );
      }
    });
  }

  Future resetPassword({
    @required String mobileNumber,
    @required String otpCode,
    @required String password,
    @required BuildContext context,
  }) async {
    await http.post(
      APINetwork.BASE_URL + APINetwork.RESET_PASSWORD,
      body: {
        "mobile": mobileNumber,
        "otp": otpCode,
        "password": password,
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (!response['message'].toLowerCase().contains("incorrect")) {
        ArsProgressDialog progressDialog = ArsProgressDialog(context,
            blur: 2,
            backgroundColor: Color(0x33000000),
            animationDuration: Duration(milliseconds: 500));
        progressDialog.show();
        Future.delayed(
          Duration(milliseconds: 1000),
          () {
            progressDialog.dismiss();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginScreen(),
                ),
                (route) => false);
          },
        );
      }
    });
  }

  Future changePassword({
    @required String oldPassword,
    @required String newPassword,
    @required String confirmPassword,
    @required BuildContext context,
  }) async {
    String token = await getBearerToken();
    if (token != null) {
      ArsProgressDialog progressDialog = ArsProgressDialog(context,
          blur: 2,
          backgroundColor: Color(0x33000000),
          animationDuration: Duration(milliseconds: 500));
      progressDialog.show();
      await http.post(
        APINetwork.BASE_URL + APINetwork.CHANGE_PASSWORD,
        headers: {
          "Authorization": 'Bearer $token',
        },
        body: {
          "oldpassword": oldPassword,
          "newpassword": newPassword,
          "confirmpassword": confirmPassword,
        },
      ).then(
        (value) {
          var response = json.decode(value.body);
          print(response);
          progressDialog.dismiss();
          if (!response['error']) {
            Future.delayed(Duration(seconds: 1), () {
              BotToast.showText(
                text: getTranslated(context, 'passwordChanged'),
                textStyle: labelTextStyle.copyWith(
                  fontSize: 10,
                  color: Colors.white,
                ),
                contentColor: Colors.green,
              );
            });
          } else {
            BotToast.showText(
              text: getTranslated(context, 'enterCorrectPassword'),
              textStyle: labelTextStyle.copyWith(
                fontSize: 10,
                color: Colors.white,
              ),
              contentColor: Colors.red,
            );
          }
        },
      );
    }
  }

  Future updateProfile({
    @required String name,
    @required String age,
    @required String address,
    @required String gender,
    @required String panelId,
  }) async {
    String token = await getBearerToken();
    if (token != null) {
      Map body;
      if (panelId == null) {
        body = {
          "name": name,
          "age": age,
          "address": address,
          "gender": gender,
        };
      } else {
        body = {
          "name": name,
          "age": age,
          "address": address,
          "gender": gender,
          "panel_id": panelId,
        };
      }

      await http
          .post(
        APINetwork.BASE_URL + APINetwork.UPDATE_PROFILE,
        headers: {
          "Authorization": 'Bearer $token',
        },
        body: body,
      )
          .then((value) {
        var response = json.decode(value.body);
        if (!response['error']) {
          BotToast.showText(
            text: response['msg'],
          );
        } else {
          BotToast.showText(
            text: response['msg'],
            contentColor: Colors.red,
            textStyle: labelTextStyle.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
          );
        }
      });
    }
  }

  Future getProfile(BuildContext context) async {
    var _userProvider = Provider.of<UserProvider>(context, listen: false);
    var _dataProvider = Provider.of<DataProvider>(context, listen: false);
    String token = await getBearerToken();
    print(token);
    if (token != null) {
      print(APINetwork.BASE_URL + APINetwork.GET_PROFILE);
      await http.post(
        APINetwork.BASE_URL + APINetwork.GET_PROFILE,
        headers: {"Authorization": "Bearer $token"},
      ).then((value) {
        var response = json.decode(value.body);
        print(response);
        if (response['error'] == true) {
          User.userData.error = response['error'];
        } else {
          Patient patient = Patient.fromJson(response['data']);
          print("patient name is:${patient.result.name}");
          _userProvider.changeData(
            name: patient.result.name ?? '',
            age: patient.result.age ?? '',
            address: patient.result.address ?? '',
            gender: patient.result.gender ?? 0,
            number: patient.result.mobileNo,
          );
          if (response['data']['insurance'] != null) {
            User.userData.selectedInsurance =
                response['data']['insurance']['name'];
            print("selected insurance name:${User.userData.selectedInsurance}");
            print("patient nameeeeeeeeeeeeeeeeeeeee: ${patient.result.name}");
            _dataProvider.patientName = patient.result.name;
            print(patient);
          } else {
            User.userData.selectedInsurance = "";
          }
        }
      });
    }
  }

  Future getDepartments(BuildContext context) async {
    var _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _dataProvider.allDepartments = [];
    _dataProvider.filterList = [];
    await http
        .post(
      APINetwork.BASE_URL + APINetwork.GET_DEPARTMENTS,
    )
        .then((value) {
      var response = json.decode(value.body);
      if (!response['error']) {
        response['data'].forEach((dpt) {
          Department department = Department.fromMap(dpt);
          _dataProvider.allDepartments.add(department);
        });
        print(_dataProvider.allDepartments);
        Department department = Department();
        department.id = null;
        department.name = "All";
        department.arabicName = "الكل";

        _dataProvider.filterList.add(department);
        _dataProvider.filterList.addAll(_dataProvider.allDepartments);
        print(_dataProvider.filterList);
      }
    });
  }

  Future<List<Slot>> getAppointmentSlots({
    @required String doctorId,
    @required String date,
    @required BuildContext context,
  }) async {
    String token = await getBearerToken();
    var _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _dataProvider.slots = [];
    if (token != null) {
      BotToast.showCustomLoading(
        toastBuilder: (e) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      print(doctorId);
      await http.post(APINetwork.BASE_URL + APINetwork.GET_APPOINTMENT_SLOTS,
          headers: {
            "Authorization": 'Bearer $token',
          },
          body: {
            "doctor_id": doctorId,
            "appointment_date": date,
          }).then((value) {
        var response = json.decode(value.body);
        if (!response['error']) {
          // Map data = response['data'];
          if (response['morning'] != null) {
            Map morningSlots = response['morning'];
            morningSlots.values.forEach((element) {
              _dataProvider.slots.add(Slot.fromMap(element));
            });
            _dataProvider.slots.add(null);
            print(_dataProvider.slots);
          }
          if (response['evening'] != null) {
            Map eveningSlots = response['evening'];
            eveningSlots.values.forEach((element) {
              _dataProvider.slots.add(Slot.fromMap(element));
            });
          }
          BotToast.closeAllLoading();
        }
        BotToast.closeAllLoading();
      });
      BotToast.closeAllLoading();
    }
    return _dataProvider.slots;
  }

  Future bookAppointment({
    @required String clinicId,
    @required String doctorId,
    @required String appointmentDate,
    @required String startTime,
    @required String endTime,
    @required String departmentId,
    @required String appointmentTime,
    @required BuildContext context,
  }) async {
    String token = await getBearerToken();
    print('Token is: $token');
    Map body = {
      "clinic_id": clinicId,
      "doctor_id": doctorId,
      "appointment_time": "$appointmentTime",
      "department_id": "$departmentId",
      "appointment_date": appointmentDate,
      "start_time": startTime,
      "end_time": endTime,
    };
    print(body);
    if (token != null) {
      print(APINetwork.BASE_URL + APINetwork.BOOK_APPOINTMENT);
      await http
          .post(
        APINetwork.BASE_URL + APINetwork.BOOK_APPOINTMENT,
        headers: {"Authorization": "Bearer $token"},
        body: body,
      )
          .then((value) {
        print('Value is : ${json.decode(value.body)}');
        var response = json.decode(value.body);
        if (!response['error']) {
          Navigator.pop(context);
          Navigator.pop(
            context,
          );
          showSuccessMeetingCustomAlertDialog(context);

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => SucessScreen(),
          //   ),
          // );
        } else {
          Navigator.pop(context);
          BotToast.showText(
            text: response['message'],
          );
        }
      });
    }
  }

  Future<List<Appointment>> quickAppointment(
    BuildContext context,
    String departmentId,
    String date,
    String startTime,
    String endTime,
  ) async {
    print('Requested time for doctors: $startTime');
    var _locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String token = await getBearerToken();

    Map body;
    if (departmentId == null) {
      body = {
        "latitude": _locationProvider.locationData.latitude.toString(),
        "longitude": _locationProvider.locationData.longitude.toString(),
        "date": date,
        "time": startTime
      };
    } else {
      body = {
        "department_id": departmentId,
        "latitude": _locationProvider.locationData.latitude.toString(),
        "longitude": _locationProvider.locationData.longitude.toString(),
        "date": date,
        "time": startTime
      };
    }
    //print(body);
    BotToast.showCustomLoading(toastBuilder: (c) {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
    _locationProvider.quickAppointmentDoctor = [];

    await http
        .post(APINetwork.BASE_URL + APINetwork.QUICK_APPOINTMENT, body: body)
        .catchError((err) => print('$err'))
        .then((value) {
      var response = json.decode(value.body);
      print(response);
      response['data'].forEach((eachDoctor) {
        _locationProvider.quickAppointmentDoctor
            .add(Appointment.fromMap(eachDoctor));
        print(eachDoctor);
      });
      print(_locationProvider.quickAppointmentDoctor);

      BotToast.closeAllLoading();
    });
    BotToast.closeAllLoading();
    return _locationProvider.quickAppointmentDoctor;
  }

  Future<List<AppointmentDetail>> appointmentHistory(
      BuildContext context) async {
    String token = await getBearerToken();

    var _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _dataProvider.allAppointments = [];
    if (token != null) {
      await http.post(
        APINetwork.BASE_URL + APINetwork.APPOINTMENT_HISTORY,
        headers: {'Authorization': 'Bearer $token'},
      ).then((value) {
        var response = json.decode(value.body);
        print("all appontment respiosse: $response");
        if (!response['error']) {
          response['data']['data'].forEach((e) {
            _dataProvider.allAppointments.add(AppointmentDetail.fromMap(e));
          });
        }
      });
    }
    return _dataProvider.allAppointments;
  }

  Future<bool> giveRatings({
    @required BuildContext context,
    @required String appointmentId,
    @required String clinicId,
    @required String doctorId,
    @required String doctorRatings,
    @required String clinicRatings,
  }) async {
    var response;
    String token = await getBearerToken();
    if (token != null) {
      print(
        {
          "clinic_id": clinicId,
          "doctor_id": doctorId,
          "appointment_id": appointmentId,
          "doctor_raiting": doctorRatings,
          "clinic_raiting": clinicRatings,
        },
      );
      await http.post(
        APINetwork.BASE_URL + APINetwork.APPOINTMENT_RATINGS,
        headers: {"Authorization": 'Bearer $token'},
        body: {
          "clinic_id": clinicId,
          "doctor_id": doctorId,
          "appointment_id": appointmentId,
          "doctor_raiting": doctorRatings,
          "clinic_raiting": clinicRatings,
        },
      ).then((value) {
        response = json.decode(value.body);
        print('message is: ${response['message']}');
        if (response['message'] == " Thank you for visiting") {
          print('message is inside: ${response['message']}');
          Navigator.pop(context, "Rated Successfully");
        }
        print(response);
      });
    }
    return response['error'];
  }

  Future<List<Clinic>> searchClinic(
      {@required String keyword,
      @required String departmentId,
      @required BuildContext context,
      @required int pageNo}) async {
    String token = await getBearerToken();
    List<Clinic> searchClinics = [];
    List<Clinic> maintainedsearchClinics = [];
    var body = {
      "department_id": "",
      "search": keyword ?? '',
    };
    print("my body:$body");
    List<Insurance> insurances = [];
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
          "${APINetwork.BASE_URL}${APINetwork.SEARCH}?page=$pageNo",
          headers: {
            "Authorization": 'Bearer $token',
          },
          body: body);
      if (re.statusCode == 200) {
        var response = json.decode(re.body);
        //  var res = json.decode(response);
        print("$response");
        User.userData.totalpages = response['last_page'];

        print("total no of pages: ${User.userData.totalpages}");
        var r = response['data'];
        // ClinicNewModel clinicNewModel = ClinicNewModel();
        // clinicNewModel = ClinicNewModel.fromJson(res);
        // print(clinicNewModel.result);
        BotToast.closeAllLoading();
        r.forEach((eachClinic) {
          //  print('Clinics: $eachClinic');
          searchClinics.add(Clinic.fromMap(eachClinic['clinic']));
        });
        //maintainedsearchClinics = maintainedsearchClinics + searchClinics;

        maintainedsearchClinics.forEach((element) {
          print('');
        });
        // maintainedsearchClinics
        //     .addAll(maintainedsearchClinics.addAll(searchClinics));
        // maintainedsearchClinics.addAll();

        //print('Clinics: $searchClinics');
        Provider.of<DataProvider>(context, listen: false)
            .settotalPage(User.userData.totalpages);
        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    }
    print(searchClinics);
    //searchClinics.addAll(maintainedsearchClinics);
    BotToast.closeAllLoading();
    if (User.userData.searchClinics.contains(searchClinics)) {
    } else {
      User.userData.searchClinics.addAll(searchClinics);
    }
    // User.userData.searchClinics.addAll(searchClinics);
    return searchClinics;
  }

  Future<List<CheckUp>> checkUpList() async {
    String token = await getBearerToken();
    List<CheckUp> checkUpDoctors = [];
    if (token != null) {
      await http.post(APINetwork.BASE_URL + APINetwork.CHECKUP_LIST,
          headers: {"Authorization": "Bearer $token"}).then((value) {
        var response = json.decode(value.body);
        if (!response['error']) {
          response['data'].forEach((eachCheckUp) {
            checkUpDoctors.add(CheckUp.fromMap(eachCheckUp));
          });
        } else {
          checkUpDoctors = [];
        }
      });
    }
    return checkUpDoctors;
  }

  Future getSliderImages({
    @required BuildContext context,
  }) async {
    String token = await getBearerToken();
    var _widgetProvider = Provider.of<WidgetProvider>(context, listen: false);
    _widgetProvider.sliderImages = [];
    if (token != null) {
      await http.post(
        APINetwork.BASE_URL + APINetwork.IMAGE_SLIDER,
        headers: {
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        var response = json.decode(value.body);
        if (!response['error']) {
          response['data'].forEach((eachSlider) {
            _widgetProvider.sliderImages.add(
              SliderModel.fromMap(eachSlider),
            );
          });
        }
      });
    }
  }

  Future cancelAppointment(String appointmentId) async {
    String token = await getBearerToken();
    print(appointmentId);
    if (token != null) {
      await http.post(
        APINetwork.BASE_URL + APINetwork.CANCEL_APPOINTMENT,
        headers: {
          "Authorization": 'Bearer $token',
        },
        body: {
          "appointment_id": appointmentId,
        },
      ).then((value) {
        var response = json.decode(value.body);
        print(response);
      });
    }
  }

  Future<List<Insurance>> getInsurances(BuildContext context) async {
    var _dataProvider = Provider.of<DataProvider>(context, listen: false);
    String token = await getBearerToken();
    List<Insurance> insuranceList = [];
    if (token != null) {
      await http.post(
        APINetwork.BASE_URL + APINetwork.GET_INSURANCES,
        headers: {
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value);
        var response = json.decode(value.body);
        response['data'].forEach((insuranceElement) {
          insuranceList.add(
            Insurance.fromMap(insuranceElement),
          );
        });
        insuranceList.insert(0, Insurance(name: ''));
        _dataProvider.changeInsuranceData(insuranceList);
      });
    }
    return insuranceList ?? [];
  }
}
