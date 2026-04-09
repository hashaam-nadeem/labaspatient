import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';

class InformationContainer extends StatelessWidget {
  final String text;

  InformationContainer({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(
          width * .02,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          width * .02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text ?? 'Not Found',
              overflow: TextOverflow.clip,
              style: labelTextStyle.copyWith(
                fontSize: width * .03,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
