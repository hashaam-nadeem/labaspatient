import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ClinicCard extends StatefulWidget {
  final int style;
  final String imageURL;
  final String name;
  final LatLng clinicLocation;
  final double ratings;
  ClinicCard({
    Key key,
    @required this.style,
    @required this.imageURL,
    @required this.name,
    @required this.clinicLocation,
    @required this.ratings,
  }) : super(key: key);

  @override
  _ClinicCardState createState() => _ClinicCardState();
}

class _ClinicCardState extends State<ClinicCard> {
  String address = '';

  findClinicAddressFromLatLong() async {
    final coordinates = Coordinates(
      widget.clinicLocation.latitude,
      widget.clinicLocation.longitude,
    );
    var findAddress =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      address = findAddress.first.addressLine;
    });
    print(address);
  }

  @override
  void initState() {
    super.initState();
    findClinicAddressFromLatLong();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0, left: 8.0, right: 8.0, top: 8.0),
      child: Container(
        width: width * .4,
        height: width * .4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: widget.style == 1 ? width : width * .4,
          height: width * .34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                widget.imageURL,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Spacer(),
                SizedBox(
                  height: height * .02,
                ),
                
                Spacer(),
                Container(
                  height: height*0.07,
                  width: width,
                  
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Text(
                            widget.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: labelTextStyle.copyWith(
                                fontSize: width * .04,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                              ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Container(
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                address,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: labelTextStyle.copyWith(
                                  fontSize: width * .035,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: height*0.05,
                          width: 1,
                          color: Colors.white,),
                      ),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: SmoothStarRating(
                            size: width*0.05,
                            color: Colors.white,
                            borderColor: Colors.white,
                          rating: widget.ratings,
                          isReadOnly: true,
                      ),
                        ),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
      ),
    );
  }
}
