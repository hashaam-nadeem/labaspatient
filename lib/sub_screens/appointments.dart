import 'package:Labas/widgets/labas_doctor_tile.dart';
import 'package:flutter/material.dart';

class AppointmentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Wrap(
        spacing: width * .08,
        runSpacing: 10,
        clipBehavior: Clip.hardEdge,
        children: List.generate(
          12,
          (index) {
            return LabasTile(
              imageURL:
                  'https://s3.amazonaws.com/loop-blog/loop-blog/wp-content/uploads/2017/04/11135531/Fotolia_102269461_S.jpg',
              index: index,
            );
          },
        ),
      ),
    );
  }
}
