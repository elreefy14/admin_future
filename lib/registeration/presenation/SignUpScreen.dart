// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:swimmer_app/core/constants/routes_manager.dart';
// import 'package:swimmer_app/registeration/business_logic/auth_cubit/otp_cubit.dart';
// import 'package:swimmer_app/registeration/business_logic/auth_cubit/sign_up_cubit.dart';
// import 'package:swimmer_app/registeration/business_logic/auth_cubit/sign_up_state.dart';
// import 'package:swimmer_app/registeration/presenation/otp.dart';
// import 'package:swimmer_app/registeration/presenation/widget/component.dart';
// import 'package:swimmer_app/registeration/presenation/widget/widget.dart';
//
// import '../../core/constants/font_manager.dart';
// import '../../core/constants/styles_manager.dart';
// import '../../home/presenation/widget/widget.dart';
//
// class SignUpScreen extends StatelessWidget {
//
//   final _formKey = GlobalKey<FormState>();
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//     body: ListView(
//      // mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding:  EdgeInsets.only(
//             top: 82.0.h,
//            // horizontal: 145.w,
//           ),
//           child: Center(
//             child: Container(
//               width: 99.w,
//               height: 26.h,
//               alignment: Alignment.center,
//               child: Text(
//                 'تسجيل',
//                 style: TextStyle(
//                   fontFamily: 'Montserrat-Arabic',
//                   fontStyle: FontStyle.normal,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 32,
//                   height: 26 / 32,
//                   color: Color(0xFF333333),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//         // Text(
//         //   'التسجيل',
//         //   textAlign: TextAlign.center,
//         //   style: TextStyle(
//         //     fontSize: 24.0,
//         //     fontWeight: FontWeight.bold,
//         //   ),
//         // ),
//         SizedBox(height: 70.0.h),
//         Form(
//           key: _formKey,
//           child: Directionality(
//             textDirection: TextDirection.rtl,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 35.0.w),
//                   child: BuildTextFormField('الاسم الاول', firstNameController,TextInputType.name, 'ادخل الاسم الاول', (value) {
//       if (value!.isEmpty) {
//         return ' الرجاء ادخال الاسم الاول';
//       }
//       return null;
//     },Icons.person),
//                 ),
//                 SizedBox(height: 20.0.h),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 35.0.w),
//                   child: BuildTextFormField('الاسم الاخير', lastNameController, TextInputType.name,'ادخل الاسم الاخير', (value) {
//       if (value!.isEmpty) {
//         return 'الرجاء ادخال الاسم الاخير';
//       }
//       return null;
//     },Icons.person),
//                 ),
//                 SizedBox(height: 20.0),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 35.0.w),
//                   child: BuildTextFormField('رقم الهاتف', phoneController, TextInputType.phone,'ادخل رقم الهاتف', (value) {
//       if (value!.isEmpty) {
//         return 'الرجاء ادخال رقم الهاتف';
//       }
//       return null;
//     },Icons.phone,),
//                 ),
//                 SizedBox(height: 20.0.h),
//                    Padding(
//                      padding: EdgeInsets.symmetric(horizontal: 35.0.w),
//                      child: BuildTextFormField('كلمة المرور', passwordController,TextInputType.text, 'ادخل كلمة المرور', (value) {
//       if (value!.isEmpty) {
//         return 'الرجاء ادخال كلمة المرور';
//       }
//       else if (value.length < 6) {
//     return 'يجب ادخال كلمة مرور اكثر من ٦ أحرف او ارقام';
//     }
//       return null;
//     },Icons.lock, ),
//                    ),
//             //    SizedBox(height: 20.0.h),
//                // BlocConsumer<OtpCubit,OtpState >(
//                  BlocConsumer<SignUpCubit,SignUpState >(
//           listener: (context, state) {
//     // if (state is PhoneNumberSubmittedloaded) {
//     // Navigator.pushNamed(
//     //         context,
//     //         AppRoutes.otpVerification,
//     //         arguments: {
//     //           'phone': phoneController.text,
//     //           'lName': lastNameController.text,
//     //           'fName': firstNameController.text,
//     //           'password': passwordController.text,
//     //         },
//     //       );
//      // }
//            //show toast in case of error and success
//             if (state is SignUpErrorState) {
//               showToast(
//                 msg:state.error?? 'حدث خطأ ما',
//                 state: ToastStates.ERROR,
//               );
//             }else if (state is SignUpSuccessState) {
//               showToast(
//                 msg: 'تم التسجيل بنجاح',
//                 state: ToastStates.SUCCESS,
//               );
//             }
//
//   },
//   builder: (context, state) {
//     return ConditionalBuilder(
//     condition: state is! SignUpLoadingState,
//     builder: (context) {
//     return Padding(
//       padding: EdgeInsets.only(
//          left: 31.w,
//          right: 31.w,
//          top: 40.h
//       ),
//       child: ElevatedButton(
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             //signUp
//             SignUpCubit.get(context).signUp(
//               fName:  firstNameController.text,
//               lName:  lastNameController.text,
//               phone: phoneController.text,
//               password: passwordController.text,
//             );
//            // OtpCubit.get(context).phoneNumberSubmitted(phoneController.text);
//           }
//         },
//         child: Text(
//           'تسجيل',
//           style: TextStyle(
//             fontFamily: 'Montserrat-Arabic',
//             fontStyle: FontStyle.normal,
//             fontWeight: FontWeight.w400,
//             fontSize: 18,
//             height: 26 / 18,
//             color: Color(0xFFFFFFFF),
//           ),
//           textAlign: TextAlign.center,
//         ),
//         style: ElevatedButton.styleFrom(
//           primary: Color(0xFF2196F3), // Background color
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: TextStyle(
//             fontSize: 18, // Adjust the font size if needed
//           ),
//         ),
//       ),
//
//     );
//
//     },
//     fallback: (context) {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//     },
//     );
//
//
//   },
// ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }}
