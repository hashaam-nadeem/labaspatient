// import 'package:Labas/utilis/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// // import 'package:map_launcher/map_launcher.dart';

// mapLauncher(
//   BuildContext context,
//   double latitude,
//   double longitude,
// ) async {
//   double width = MediaQuery.of(context).size.width;
//   double height = MediaQuery.of(context).size.height;
//  // final availableMaps = await MapLauncher.installedMaps;
//   List<String> allMapIcons = [];
//   List<String> allMaps = [];
//   availableMaps.forEach((element) {
//     allMapIcons.add(element.icon);
//     allMaps.add(element.mapName);
//   });
//   if (availableMaps.length != 0) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       builder: (context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: width,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: height * .01,
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Spacer(),
//                       Container(
//                         width: width * .07,
//                         height: height * .005,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(
//                             20,
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                     ],
//                   ),
//                   SizedBox(
//                     height: height * .01,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                     ),
//                     child: Text(
//                       'Open With',
//                       style: labelTextStyle.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: height * .01,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                     ),
//                     child: Wrap(
//                       spacing: width * .18,
//                       children: List.generate(
//                         availableMaps.length,
//                         (index) {
//                           return InkWell(
//                             onTap: () {
//                               availableMaps[index].showMarker(
//                                 coords: Coords(latitude, longitude),
//                                 title: 'Pick Up Location',
//                               );
//                             },
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   height: height * .01,
//                                 ),
//                                 SizedBox(
//                                   width: 24,
//                                   height: 24,
//                                   child: SvgPicture.asset(
//                                     availableMaps[index].icon,
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: height * .01,
//                                 ),
//                                 Text(
//                                   allMaps[index],
//                                   style: labelTextStyle.copyWith(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: height * .03,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
