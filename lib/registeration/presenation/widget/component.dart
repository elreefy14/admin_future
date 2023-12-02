import 'dart:convert';
import 'dart:math';

import 'package:admin_future/add_grouup_of_schedules/presentation/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/auth_cubit/sign_up_cubit.dart';

Widget BuildTextFormField2(
    String labelText,
    TextEditingController controller,
    TextInputType input,
    String hintText,
    String? Function(String?) validator,
    IconData? icon,
{BuildContext? context,}
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        labelText,
        style: TextStyle(
          color: Color(0xFF333333),
          fontSize: 14.sp,
          fontFamily: 'IBM Plex Sans Arabic',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
        textAlign: TextAlign.right,
      ),
      SizedBox(height: 8),
      TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        keyboardType: input,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFF333333),
            fontSize: 16.sp,
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          errorStyle: TextStyle(
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            height: 20.0 / 14.0,
            color: Color(0xFFD92D20),
          ),
          filled: true,
          fillColor: Color(0xFFF4F4F4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: Color(0xFF2196F3), width: 1.5.w),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
          // Add the random password button

          suffixIcon: labelText == 'كلمة المرور' ?
          ElevatedButton(
            onPressed: () {
              String randomPassword = generateRandomPassword(); // Replace with your random password generation logic
              Clipboard.setData(ClipboardData(text: randomPassword));
              //   addGroupCubit.searchController.text = randomPassword;\
              SignUpCubit
                  .get(context)
                  .passwordController.text = randomPassword;
              //context.read<AddGroupCubit>().searchController.text = randomPassword;
              ScaffoldMessenger.of(context!).showSnackBar(
                SnackBar(content: Text('Password copied to clipboard')),
              );
            },
            child: Text('Generate Password'),
          ): null,
          // IconButton(
          //   icon: Icon(Icons.vpn_key),
          //   onPressed: () {
          //     String randomPassword = generateRandomPassword(); // Replace with your random password generation logic
          //     Clipboard.setData(ClipboardData(text: randomPassword));
          //  //   addGroupCubit.searchController.text = randomPassword;\
          //     SignUpCubit
          //         .get(context)
          //         .passwordController.text = randomPassword;
          //     //context.read<AddGroupCubit>().searchController.text = randomPassword;
          //     ScaffoldMessenger.of(context!).showSnackBar(
          //       SnackBar(content: Text('Password copied to clipboard')),
          //     );
          //   },
          // ): null,
        ),
        validator: validator,
      ),
    ],
  );
}

String generateRandomPassword() {
  //random password with 6 characters
  var random = Random.secure();
  var values = List<int>.generate(6, (i) => random.nextInt(255));
  return base64Url.encode(values);
}



Widget BuildTextFormField(
   String labelText,
   TextEditingController controller,
   TextInputType input,
   String hintText,
   String? Function(String?) validator,
  String? prefixIconPath,
  String? suffixIconPath,
) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      Text(
      labelText,
           style: TextStyle(
  fontSize: 14.0,
  color: Color(0xFF333333),
  fontFamily: 'IBM Plex Sans Arabic',
  ),
  textAlign: TextAlign.right,
  ),
  SizedBox(height: 8),
  TextFormField(
  //  scrollPadding: //50 from bottom of screen
 //   EdgeInsets.only(bottom: 50.h),
  controller: controller,
  keyboardType: input,
  obscureText: labelText == 'كلمة المرور' ? true : false,
  decoration: InputDecoration(
  prefixIcon: prefixIconPath != null
  ? ImageIcon(
  AssetImage(prefixIconPath),
  color: Color(0xFF333333),
  )
      : null,
  suffixIcon: suffixIconPath != null
  ? ImageIcon(
  AssetImage(suffixIconPath),
  color: Color(0xFF333333),
  )
      : null,
  hintText: hintText,
  hintStyle: TextStyle(
  fontFamily: 'IBM Plex Sans Arabic',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
  height: 24.0 / 16.0,
  color: Color(0xFF666666),
  ),
  errorStyle: TextStyle(
  fontFamily: 'Inter',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 14.0,
  height: 20.0 / 14.0,
  color: Color(0xFFD92D20),
  ),
  filled: true,
  fillColor: Color(0xFFF4F4F4),
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(4.0),
  borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(4.0),
  borderSide: BorderSide(color: Color(0xFF2196F3), width: 1.5),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
  ),
  validator: validator,
  ),
  ],
  );
  }

