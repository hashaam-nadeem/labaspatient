import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';

class InformationTitleContainer extends StatelessWidget {
  final String title;

  InformationTitleContainer({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(
        width * .02,
      ),
      child: Text(
        title,
        style: labelTextStyle.copyWith(
          fontSize: width * .04,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
