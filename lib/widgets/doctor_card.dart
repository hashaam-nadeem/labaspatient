import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/data_provider.dart';
import 'package:Labas/utilis/assets.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorCard extends StatefulWidget {
  final int style;
  final String imageURL;
  final String name;
  final String specialization;
  final double ratings;

  const DoctorCard({
    Key key,
    @required this.style,
    @required this.imageURL,
    @required this.name,
    @required this.specialization,
    this.ratings,
  }) : super(key: key);

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  void initState() {
    print("${widget.ratings}");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _dataProvider = Provider.of<DataProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blue[200], width: 2.0),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: widget.style == 1
          ? Container(
              height: height * .20,
              width: width,
              child: Row(
                children: [
                  Container(
                    width: width * 0.4,
                    //color: Colors.black,
                    child: Container(
                      width: widget.style == 1 ? width : width * .45,
                      height: height,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: SizedBox(
                        width: widget.style == 1 ? width : width * .45,
                        height: height * .2,
                        child: FadeInImage.assetNetwork(
                          placeholder: appLogo,
                          image: widget.imageURL,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Expanded(
                    child: Container(
                      width: width * .3,
                      //  height: height * .08,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              widget.style == 1
                                  ? Flexible(
                                      child: Text(
                                        widget.name ??
                                            getTranslated(
                                                context, 'doctorName'),
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: labelTextStyle.copyWith(
                                          fontSize: width * .035,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Flexible(
                                      child: Text(
                                        widget.name ??
                                            getTranslated(
                                                context, 'doctorName'),
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        style: labelTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.specialization ?? "",
                                  maxLines: 3,
                                  style: hintTextStyle.copyWith(
                                    fontSize: width * .03,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              // RatingBar.builder(
                              //   initialRating: ratings ?? 0.0,
                              //   minRating: 0,
                              //   direction: Axis.horizontal,
                              //   allowHalfRating: true,
                              //   itemCount: 5,
                              //   itemPadding:
                              //       EdgeInsets.symmetric(horizontal: 4.0),
                              //   itemBuilder: (context, _) => Icon(
                              //     Icons.star,
                              //     size: width * .02,
                              //     color: Colors.amber,
                              //   ),
                              //   // onRatingUpdate: (rating) {
                              //   //   print(rating);
                              //   // },
                              // )
                              SmoothStarRating(
                                rating: widget.ratings ?? 0.0,
                                size: width * .04,
                                isReadOnly: true,
                              ),
                            ],
                          )

                          // Text(
                          //   specialization ??
                          //                         getTranslated(context, 'specialization'),
                          //                     maxLines: 2,
                          //                     style: hintTextStyle.copyWith(
                          //                       fontSize: width * .03,
                          //                     ),
                          //                     overflow: TextOverflow.ellipsis,
                          //                   ),
                          // style == 1
                          //     ? Center(
                          //         child:
                          //       )
                          //     : Text(
                          //         specialization ??
                          //             getTranslated(context, 'specialization'),
                          //         maxLines: 1,
                          //         style: hintTextStyle.copyWith(
                          //           fontSize: width * .03,
                          //         ),
                          //       ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )

          //If Style ==2
          : Container(
              height: height * .27,
              width: width * .4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width,
                    height: height * .16,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          20,
                        ),
                        topRight: Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: width,
                      height: height * .2,
                      child: FadeInImage.assetNetwork(
                        placeholder: appLogo,
                        image: widget.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: width * .02,
                        right: width * .02,
                      ),
                      child: Center(
                        child: Text(
                          widget.name ?? getTranslated(context, 'doctorName'),
                          maxLines: 1,
                          style: labelTextStyle.copyWith(
                            fontSize: width * .035,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                        left: width * .02,
                        right: width * .02,
                      ),
                      child: Center(
                        child: Text(
                          widget.specialization ??
                              getTranslated(context, 'specialization'),
                          maxLines: 1,
                          style: hintTextStyle.copyWith(
                            fontSize: width * .03,
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                        left: width * .02,
                        right: width * .02,
                      ),
                      child: Center(
                        child: SmoothStarRating(
                          rating: widget.ratings ?? 0.0,
                          size: width * .04,
                          isReadOnly: true,
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}
