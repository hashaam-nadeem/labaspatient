// Positioned(
//   top: height * .18,
//   child: Container(
//     height: height * .8,
//     width: width,
//     clipBehavior: Clip.hardEdge,
//     decoration: BoxDecoration(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(
//           30,
//         ),
//         topRight: Radius.circular(
//           30,
//         ),
//       ),
//     ),
//     child: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: height * .26,
//             width: width,
//             // child: Center(
//             //   child: Text(
//             //     'Clinic Location On Map',
//             //     style: labelTextStyle.copyWith(
//             //       color: Colors.white,
//             //     ),
//             //   ),
//             // ),
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(
//               // color: Colors.black,
//               image: DecorationImage(
//                 image: AssetImage(
//                   map,
//                 ),
//                 fit: BoxFit.fill,
//               ),
//               borderRadius: BorderRadius.circular(
//                 30,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey,
//                   blurRadius: 14,
//                   spreadRadius: 8,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: height * .03,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: width * .04,
//             ),
//             child: Row(
//               children: [
//                 Text(
//                   getTranslated(context, 'departments'),
//                   style: labelTextStyle.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Spacer(),
//                 GestureDetector(
//                   onTap: () {
//                     if (style == 1) {
//                       setState(() {
//                         style = 2;
//                       });
//                     } else {
//                       setState(() {
//                         style = 1;
//                       });
//                     }
//                   },
//                   child: Icon(
//                     style == 1 ? Icons.grid_view : Icons.list,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: height * .03,
//           ),
//           Container(
//             height: height * .42,
//             child: GridView.builder(
//               gridDelegate:
//                   SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: style,
//                 mainAxisSpacing: 1,
//                 crossAxisSpacing: 2,
//                 childAspectRatio: style == 1 ? 2.213 : 1.1,
//               ),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => DepartmentScreen(
//                           departmentLogo:
//                               allDepartmentImages[index],
//                           departmentName:
//                               allDepartmentsName[index],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     width: style == 1 ? width : width * .4,
//                     height: width * .4,
//                     margin: EdgeInsets.all(
//                       10,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     clipBehavior: Clip.hardEdge,
//                     child: Column(
//                       children: [
//                         Container(
//                           width: style == 1 ? width : width * .4,
//                           height: width * .338,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 allDepartmentImages[index],
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20)),
//                           ),
//                           clipBehavior: Clip.hardEdge,
//                         ),
//                         Spacer(),
//                         Container(
//                           width: style == 1 ? width : width * .4,
//                           height: width * .06,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color(0xff66B7E2),
//                                 Color(0xff3291C3),
//                               ],
//                               begin: FractionalOffset.topLeft,
//                               end: FractionalOffset.bottomRight,
//                             ),
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(20),
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               allDepartmentsName[index],
//                               textAlign: TextAlign.center,
//                               style: labelTextStyle.copyWith(
//                                 color: Colors.white,
//                                 fontSize: width * .025,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               itemCount: allDepartmentImages.length,
//             ),
//           ),
//           SizedBox(
//             height: height * .08,
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
