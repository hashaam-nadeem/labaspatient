import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';

class TitleContainer extends StatelessWidget {
  final String title;

  TitleContainer({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * .06,
      width: width * .74,
      decoration: BoxDecoration(
        color: Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(
          width * .04,
        ),
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: width * .02,
        ),
        child: Text(
          title ?? '',
          maxLines: 1,
          style: labelTextStyle.copyWith(
            fontSize: width * .045,
          ),
        ),
      ),
    );
  }
}
