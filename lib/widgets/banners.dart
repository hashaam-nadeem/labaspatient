import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabasBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    return 
    _widgetProvider.sliderImages.length==0? 
    Container():
    CarouselSlider(
      options: CarouselOptions(
        height: height * .18,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        enlargeCenterPage: true,
      ),
      items: _widgetProvider.sliderImages.map(
            (e) {
              return Container(
                width: width,
                height: height * .18,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      APINetwork.BASE_URL + e.imageURL,
                    ),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              );
            },
          )?.toList() ??
          [],
    );
  }
}
