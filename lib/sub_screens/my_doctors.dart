import 'package:Labas/helper/apiClient.dart';
import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/model/checkup.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:Labas/utilis/globals.dart';
import 'package:Labas/widgets/doctor_card.dart';
import 'package:flutter/material.dart';

class MyDoctorsTab extends StatelessWidget {
  ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<CheckUp>>(
      future: apiClient.checkUpList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!snapshot.hasData) {
          return Container(
            height: width * .6,
            child: Text(
              getTranslated(context, 'noDoctorFound'),
            ),
          );
        } else {
          return Center(
            child: Wrap(
              runSpacing: width * .03,
              spacing: width * .03,
              children: List.generate(
                snapshot.data.length,
                (index) {
                  if (snapshot.data.length != 0) {
                    return DoctorCard(
                      style: 2,
                      imageURL: APINetwork.BASE_URL +
                          imagePath +
                          snapshot.data[index].doctorImage,
                      name: snapshot.data[index].doctorName,
                      specialization: snapshot.data[index].departmentName,
                    );
                  } else {
                    return Container(
                      height: width * .6,
                      child: Text(
                        getTranslated(context, 'noDoctorFound'),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
}
