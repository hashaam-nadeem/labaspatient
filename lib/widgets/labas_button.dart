import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';

class LabasButton extends StatelessWidget {
  LabasButton({
    Key key,
    @required this.title,
    @required this.onPress,
  }) : super(key: key);
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RaisedButton(
      color: mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: width,
        height: height * .06,
        child: Center(
          child: Text(
            title.toUpperCase() ?? '',
            style: labelTextStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      onPressed: () {
        onPress();
      },
    );
  }
}
