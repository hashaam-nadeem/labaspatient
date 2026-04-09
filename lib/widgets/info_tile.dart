import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/globals.dart';
import 'package:Labas/utilis/styles.dart';

class LabasInfoTile extends StatelessWidget {
  final specialisation;
  final int index;

  LabasInfoTile({
    Key key,
    this.index,
    this.specialisation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width * .02,
      ),
      child: Container(
        height: height * .13,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: mainColor,
        ),
        child: Row(
          children: [
            Container(
              height: height * .15,
              width: width * .33,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    index == 0
                        ? 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg'
                        : index == 1
                            ? 'https://image.freepik.com/free-photo/front-view-doctor-with-medical-mask-posing-with-crossed-arms_23-2148445082.jpg'
                            : index == 2
                                ? 'https://image.freepik.com/free-photo/front-view-woman-wearing-protective-wear-hospital_23-2148722315.jpg'
                                : index == 3
                                    ? 'https://image.freepik.com/free-photo/portrait-doctor-with-surgical-mask-stethoscope_23-2148454273.jpg'
                                    : index == 4
                                        ? 'https://collegelearners.com/wp-content/uploads/2020/04/use.jpg'
                                        : index == 5
                                            ? 'https://image.freepik.com/free-photo/doctor-nurse-talking-hospital_23-2148757323.jpg'
                                            : index == 6
                                                ? 'https://image.freepik.com/free-photo/portrait-doctor-wearing-face-mask-surgical-gloves_23-2148747871.jpg'
                                                : index == 7
                                                    ? 'https://image.freepik.com/free-photo/front-view-medical-control-covid19-concept_23-2148777438.jpg'
                                                    : index == 8
                                                        ? 'https://image.freepik.com/free-photo/doctors-hazmat-suits-hospital_23-2148733952.jpg'
                                                        : index == 9
                                                            ? 'https://image.freepik.com/free-photo/close-up-doctor-holding-coronavirus-test_23-2148767273.jpg'
                                                            : index == 10
                                                                ? 'https://image.freepik.com/free-photo/doctors-wearing-face-mask_23-2148741061.jpg'
                                                                : imageURL,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: width * .03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  getTranslated(context, 'doctorName'),
                  style: labelTextStyle.copyWith(
                    fontSize: width * .035,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  specialisation == null
                      ? getTranslated(context, 'specialization')
                      : specialisation == 'All'
                          ? getTranslated(context, 'specialization')
                          : getTranslated(context, 'specialization'),
                  style: hintTextStyle.copyWith(
                    fontSize: width * .03,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '+1 - (1' +
                      index.toString() +
                      '1)' ' 2' +
                      (index + 1).toString() +
                      '2 33' +
                      (index + 2).toString(),
                  style: hintTextStyle.copyWith(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                Spacer(),
                SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  rating: 3.8,
                  size: 20.0,
                  isReadOnly: false,
                  color: Colors.yellow[700],
                  borderColor: Colors.yellow[700],
                  spacing: 0.0,
                ),
                SizedBox(
                  height: height * .01,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
