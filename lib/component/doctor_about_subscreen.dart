import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/screens/title_container.dart';
import 'package:Labas/widgets/information_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorAboutSubScreen extends StatelessWidget {
  final doctorName,
      mobileNumber,
      education,
      services,
      specialization,
      experience,
      longDescription,
      shortDescription,
      imageURL;

  const DoctorAboutSubScreen({
    Key key,
    @required this.doctorName,
    @required this.mobileNumber,
    @required this.education,
    @required this.services,
    @required this.specialization,
    @required this.experience,
    @required this.longDescription,
    @required this.shortDescription,
    @required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * .03,
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          
          crossAxisAlignment: _widgetProvider.languageIndex==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
          children: [
            InformationTitleContainer(
              title: getTranslated(context, 'summary') ?? 'Summary',
            ),
            InformationContainer(
              text: shortDescription,
            ),
            SizedBox(
              height: height * .02,
            ),
            InformationTitleContainer(
              title: getTranslated(context, 'education') ?? 'Education',
            ),
            InformationContainer(
              text: education,
            ),
            SizedBox(
              height: height * .02,
            ),
            InformationTitleContainer(
              title: getTranslated(context, 'specialization'),
            ),
            InformationContainer(
              text: specialization,
            ),
            SizedBox(
              height: height * .02,
            ),
            InformationTitleContainer(
              title: getTranslated(context, 'experience') ?? 'Experience',
            ),
            InformationContainer(
              text: experience,
            ),
            SizedBox(
              height: height * .02,
            ),
            InformationTitleContainer(
              title: getTranslated(context, 'services') ?? 'Services',
            ),
            InformationContainer(
              text: services,
            ),
          ],
        ),
      ),
    );
  }
}
