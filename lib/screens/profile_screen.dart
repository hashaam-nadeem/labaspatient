import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/user_provider.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/sub_screens/appointments.dart';
import 'package:Labas/sub_screens/my_doctors.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileScreen({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    var _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: labelTextStyle.copyWith(
              fontSize: width * .05, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * .8,
              width: width,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: darkGreyColor,
                    ),
                    clipBehavior: Clip.hardEdge,
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width * .3,
                          height: width * .3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                // bottomLeft: Radius.circular(30),
                                // bottomRight: Radius.circular(30),
                                ),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://images.megapixl.com/4684/46846328.jpg',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * .01,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * .02,
                              ),
                              Text(
                                _userProvider.nameTextEditingController.text ??
                                    getTranslated(context, 'userName'),
                                style: labelTextStyle.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: height * .001,
                              ),
                              Text(
                                _userProvider.mobileNumber ?? 'info@labas.com',
                                style: hintTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(
                                height: height * .01,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 18,
                                    color: Colors.white70,
                                  ),
                                  Flexible(
                                    child: Text(
                                      _userProvider.patientAddress ??
                                          getTranslated(context, 'address') ??
                                          '',
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: labelTextStyle.copyWith(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * .01,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                _widgetProvider.changeProfileTabIndex(1);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Text(
                                    getTranslated(context, 'doctor') ?? '',
                                    style: labelTextStyle.copyWith(
                                        fontSize: 12,
                                        color:
                                            _widgetProvider.profileTabIndex == 1
                                                ? Colors.black
                                                : Colors.grey,
                                        fontWeight:
                                            _widgetProvider.profileTabIndex == 1
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * .03,
                            ),
                            MyDoctorsTab(),
                            SizedBox(
                              height: height * .03,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
