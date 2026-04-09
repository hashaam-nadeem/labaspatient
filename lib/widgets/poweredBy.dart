import 'package:Labas/utilis/assets.dart';
import 'package:flutter/material.dart';

Widget powered(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                brightMediaLogo,
                width: MediaQuery.of(context).size.width * .19,
                height: MediaQuery.of(context).size.height * .18,
              ),
            ],
          ),
        ],
      ),
    );
  }