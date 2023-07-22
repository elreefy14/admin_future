import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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

