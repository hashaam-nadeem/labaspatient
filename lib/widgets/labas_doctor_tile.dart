import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';

class LabasTile extends StatelessWidget {
  LabasTile({
    this.imageURL =
        'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop',
    this.index = 0,
  });
  final String imageURL;
  final int index;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => DoctorProfileScreen(),
        //   ),
        // );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Container(
          height: height * .25,
          width: width * .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * .4,
                height: height * .2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      20,
                    ),
                    topRight: Radius.circular(
                      20,
                    ),
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
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Text(
                  getTranslated(context, 'doctorName'),
                  style: labelTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Text(
                  getTranslated(context, 'specialization'),
                  style: hintTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
