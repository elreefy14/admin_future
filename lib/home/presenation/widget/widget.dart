// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../business_logic/Home/home_cubit.dart';
// import '../../business_logic/Home/home_state.dart';
// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         var currentIndex = HomeCubit.get(context).currentIndex;
//         return Container(
//           height: 67.h,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(.15),
//                 blurRadius: 30,
//                 offset: Offset(0, 10),
//               ),
//             ],
//             //    borderRadius: BorderRadius.circular(50),
//           ),
//           child: ListView.builder(
//             itemCount: 4,
//             scrollDirection: Axis.horizontal,
//             padding: EdgeInsets.symmetric(horizontal: screenWidth * .06),
//             itemBuilder: (context, index) => InkWell(
//               onTap: () {
//                 setState(() {
//                   currentIndex = index;
//                   HapticFeedback.lightImpact();
//                 });
//                 HomeCubit.get(context).changeBottomNav(currentIndex);
//               },
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Stack(
//                     children: [
//                       SizedBox(
//                         width: screenWidth * .22,
//                         child: Center(
//                           child: AnimatedContainer(
//                             duration: Duration(seconds: 1),
//                             curve: Curves.fastLinearToSlowEaseIn,
//                             height: index == currentIndex
//                                 ? 32.h
//                                 : 0,
//                             width: index == currentIndex
//                                 ? screenWidth * .22
//                                 : 0,
//                             decoration: BoxDecoration(
//                               color: index == currentIndex
//                                   ? //#2196F3
//                               Color(0xff2196F3)
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: screenWidth * .22,
//                         alignment: Alignment.center,
//                         child: SvgPicture.asset(
//                           HomeCubit.get(context).listOfIcons[index],
//                           height: 24.h,
//                           width: 24.w,
//                           color: index == currentIndex
//                               ? //##FFFFFF
//                           Color(0xffFFFFFF)
//                               : Colors.black26,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 4),
//                   // Text(
//                   //   HomeCubit.get(context).listOfTitles[index],
//                   //   style: TextStyle(
//                   //     color: index == currentIndex
//                   //         ? Color(0xff2196F3)
//                   //         : Colors.black26,
//                   //     fontSize: 12.sp,
//                   //     fontWeight: FontWeight.bold,
//                   //   ),
//                   // ),
//                   //SizedBox(
//                   //     width: 64,
//                   //     height: 16,
//                   //     child: Text(
//                   //         'لوحة التحكم',
//                   //         textAlign: TextAlign.center,
//                   //         style: TextStyle(
//                   //             color: Color(0xFFB9B9B9),
//                   //             fontSize: 12,
//                   //             fontFamily: 'IBM Plex Sans Arabic',
//                   //             fontWeight: FontWeight.w400,
//                   //             height: 14.40,
//                   //             letterSpacing: 0.03,
//                   //         ),
//                   //     ),
//                   // )
//                   SizedBox(
//                     width: 64,
//                     height: 16,
//                     child: Text(
//                       HomeCubit.get(context).listOfTitles[index],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: index == currentIndex
//                             ?Colors.black26
//                             : Colors.black26,
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
