import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/insurance.dart';
import 'package:Labas/model/usersingalton.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/provider/location_provider.dart';
import 'package:Labas/provider/user_provider.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/routes.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:Labas/widgets/labas_button.dart';
import 'package:Labas/widgets/navigation_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final VoidCallback callback;

  EditProfileScreen({Key key, this.callback}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ApiClient apiClient = ApiClient();
  Insurance selectedInsurance = Insurance();
  List<String> values = [];
  String value = '';
  int id;
  Insurance insu = Insurance();

  @override
  void initState() {
    super.initState();
    id = 0;
    var _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _dataProvider.insuranceData.forEach((element) {
      if (values.length <= _dataProvider.insuranceData.length) {
        values.add(element.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _userProvider = Provider.of<UserProvider>(context);
    var _dataProvider = Provider.of<DataProvider>(context);
    var _locationProvider = Provider.of<LocationProvider>(context);
    print('User name is: ${_userProvider.nameTextEditingController.text}');
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     getTranslated(context, 'editProfile'),
      //     style: labelTextStyle.copyWith(
      //       fontSize: width * .05,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      // bottomNavigationBar: SafeArea(
      //   child: CustomBottomNavBar(),
      // ),
      body: SafeArea(
        child: Column(
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
                                    bottomLeft: Radius.circular(width * .13),
                                    bottomRight: Radius.circular(width * .13))),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: width,
                            height: height * .18,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(width * .9),
                                    bottomRight: Radius.circular(width * .9))),
                            child: Column(
                              //  mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height * 0.03,
                                ),
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
                                          "${getTranslated(context, "setting")}",
                                          gradient: LinearGradient(colors: [
                                            mainColor,
                                            greenColor,
                                          ]),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center),
                                    ),
                                    Expanded(flex: 1, child: Container())
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
                                            Icons.settings,
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .03,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: ListTile(
                          leading: Text(
                            getTranslated(context, 'editProfile'),
                            style: labelTextStyle.copyWith(
                              fontSize: width * .04,
                            ),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_down,
                            color: greenColor,
                            size: width * .08,
                          ),
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      // Center(
                      //   child: ClipOval(
                      //     child: Image.asset(
                      //       profile,
                      //       height: height * 0.13,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * .0,
                        ),
                        child: Text(
                          getTranslated(context, 'name'),
                          style: labelTextStyle.copyWith(
                            fontSize: width * .038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            width * .02,
                          ),
                          color: Color(0xffF7F7F7),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _userProvider.nameTextEditingController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(width * .03),
                              hintText: '',
                              hintStyle: labelTextStyle.copyWith(
                                fontSize: width * .04,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              alignLabelWithHint: true,
                            ),
                            style: labelTextStyle.copyWith(
                              fontSize: width * .04,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * .0,
                        ),
                        child: Text(
                          getTranslated(context, 'age'),
                          style: labelTextStyle.copyWith(
                            fontSize: width * .038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            width * .02,
                          ),
                          color: Color(0xffF7F7F7),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _userProvider.ageTextEditingController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(width * .03),
                              hintText: '',
                              hintStyle: labelTextStyle.copyWith(
                                fontSize: width * .04,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              alignLabelWithHint: true,
                            ),
                            keyboardType: TextInputType.phone,
                            style: labelTextStyle.copyWith(
                              fontSize: width * .04,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * .0,
                        ),
                        child: Text(
                          getTranslated(context, 'gender'),
                          style: labelTextStyle.copyWith(
                            fontSize: width * .038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _userProvider.index = 0;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _userProvider.index == 0
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  size: width * .05,
                                ),
                                SizedBox(
                                  width: width * .03,
                                ),
                                Text(
                                  getTranslated(context, 'male'),
                                  style: labelTextStyle.copyWith(
                                    fontSize: width * .04,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _userProvider.index = 1;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _userProvider.index == 1
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  size: width * .05,
                                ),
                                SizedBox(
                                  width: width * .03,
                                ),
                                Text(
                                  getTranslated(context, 'female'),
                                  style: labelTextStyle.copyWith(
                                    fontSize: width * .04,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * .0,
                        ),
                        child: Text(
                          'Insurance',
                          style: labelTextStyle.copyWith(
                            fontSize: width * .038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          hint: Text(
                            'Your Insurance',
                            style: labelTextStyle.copyWith(
                                fontSize: width * .04, color: Colors.black),
                          ),
                          isExpanded: true,
                          items: _dataProvider.insuranceData
                              .map<DropdownMenuItem<String>>((Insurance e) {
                            String firstCapitalLetter;
                            if (e.name != null) {
                              firstCapitalLetter = e.name.toString();
                            }

                            print(firstCapitalLetter);
                            return DropdownMenuItem<String>(
                              value: e.name ?? 'Your Insurance',
                              child: Text(
                                firstCapitalLetter.isNotEmpty
                                    ? firstCapitalLetter.toUpperCase() + e.name
                                    : "${User.userData.selectedInsurance}",
                                style: labelTextStyle.copyWith(
                                    fontSize: width * .035,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          value: value ?? 'Your Insurance',
                          onChanged: (a) {
                            setState(() {
                              value = a ?? '';
                              _dataProvider.insuranceData.forEach((element) {
                                if (element.name == a) {
                                  id = element.id;
                                }
                              });
                            });
                            print('id sis : $id');
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * .0,
                        ),
                        child: Text(
                          getTranslated(context, 'address'),
                          style: labelTextStyle.copyWith(
                            fontSize: width * .038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Container(
                        width: width,
                        height: height * .06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            width * .02,
                          ),
                          color: Color(0xffF7F7F7),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * .02,
                              ),
                              child: Container(
                                width: width * .82,
                                child: Text(
                                  _userProvider.patientAddress,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: labelTextStyle.copyWith(
                                    fontSize: width * .04,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Location location = Location();
                                LocationData locationData =
                                    await location.getLocation();

                                var coordinates = Coordinates(
                                  locationData.latitude,
                                  locationData.longitude,
                                );

                                var findAddress = await Geocoder.local
                                    .findAddressesFromCoordinates(coordinates);
                                var address = findAddress.first.addressLine;
                                setState(() {
                                  _userProvider.patientAddress = address;
                                });

                                await _locationProvider.getPatientLocation();
                                // BotToast.closeAllLoading();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PlacePicker(
                                      apiKey:
                                          'AIzaSyBTG6MlmkHSmhWwKdAd3pZYMOz6Nz2sNqk',
                                      initialPosition:
                                          _locationProvider.locationData == null
                                              ? LatLng(
                                                  25.2854,
                                                  51.5310,
                                                )
                                              : LatLng(
                                                  _locationProvider
                                                      .locationData.latitude,
                                                  _locationProvider
                                                      .locationData.longitude,
                                                ),
                                      useCurrentLocation: true,
                                      onPlacePicked: (value) async {
                                        final coordinates = Coordinates(
                                          value.geometry.location.lat,
                                          value.geometry.location.lng,
                                        );
                                        final findAddresses = await Geocoder
                                            .local
                                            .findAddressesFromCoordinates(
                                          coordinates,
                                        );
                                        _userProvider.patientAddress =
                                            findAddresses.first.addressLine;
                                        _locationProvider.changeAddress(
                                            findAddresses.first.addressLine);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.my_location,
                                size: width * .06,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                      Center(
                        child: Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () async {
                              if (_userProvider
                                          .nameTextEditingController.text !=
                                      null &&
                                  _userProvider.ageTextEditingController.text !=
                                      null &&
                                  _userProvider.patientAddress != null &&
                                  _userProvider.index != null) {
                                if (_userProvider.nameTextEditingController.text
                                        .isNotEmpty &&
                                    _userProvider.ageTextEditingController.text
                                        .isNotEmpty &&
                                    _userProvider.patientAddress.isNotEmpty) {
                                  apiClient.updateProfile(
                                    name: _userProvider
                                        .nameTextEditingController.text,
                                    age: _userProvider
                                        .ageTextEditingController.text,
                                    address: _userProvider.patientAddress,
                                    gender: _userProvider.index.toString(),
                                    panelId: id.toString(),
                                  );
                                  await Future.delayed(Duration(seconds: 1),
                                      () async {
                                    await apiClient.getProfile(context);
                                  });
                                } else {
                                  BotToast.showText(
                                    text: getTranslated(context, 'fillFields'),
                                    textStyle: labelTextStyle.copyWith(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                    contentColor: Colors.red,
                                  );
                                }
                              } else {
                                BotToast.showText(
                                  text: getTranslated(context, 'fillFields'),
                                  textStyle: labelTextStyle.copyWith(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                  contentColor: Colors.red,
                                );
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff374ABE),
                                      Color(0xff64B6FF)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 300.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  getTranslated(context, 'submit'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
