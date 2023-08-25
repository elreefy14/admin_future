import 'package:admin_future/registeration/presenation/widget/component.dart';
import 'package:admin_future/registeration/presenation/widget/multi_select.dart';
import 'package:admin_future/registeration/presenation/widget/widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/presenation/widget/manage_attendence.dart';
import '../business_logic/auth_cubit/sign_up_cubit.dart';
import '../business_logic/auth_cubit/sign_up_state.dart';

class SignUpScreen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    void _showMultiSelect() async {
      final List<String> items = ['Flutter',
        'Node.js',
        'React Native',
        'Java',
        'Docker',
        'MySQL'
      ];



      final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelect(
            items: items,
          //  selectedItems: SignUpCubit.get(context).
         //    selectedItems??[],
         //   onSelectionChanged: (newSelectedItems) {
       //       SignUpCubit.get(context).updateSelectedItems(newSelectedItems);
                  // .updateSelectedItems(newSelectedItems);
      //      },
          );
        },
      );

      // Handle results if needed
      if (results != null) {
        // Do something with the selected items
      }
    }
  return Builder(
    builder: (context) {
      print('selectedItems ${SignUpCubit.get(context).selectedItems}');
      List<String>? selectedItems =
      SignUpCubit.get(context).selectedItems ;
      return BlocBuilder<SignUpCubit,SignUpState >(
      builder: (context, state) {
        return Scaffold(
        body: ListView(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(
                top: 42.0.h,
               // horizontal: 145.w,
              ),
              child: Center(
                child: Container(
                  width: 99.w,
                  height: 26.h,
                  alignment: Alignment.center,
                  child: Text(
                    'تسجيل',
                    style: TextStyle(
                      fontFamily: 'Montserrat-Arabic',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                      height: 26 / 32,
                      color: Color(0xFF333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // Text(
            //   'التسجيل',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 70.0.h),
            Form(
              key: SignUpCubit.get(context).formKey,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                      child: BuildTextFormField2('الاسم الاول',
                          SignUpCubit.get(context).firstNameController,
                          TextInputType.name, 'ادخل الاسم الاول', (value) {
          if (value!.isEmpty) {
            return ' الرجاء ادخال الاسم الاول';
          }
          return null;
        },Icons.person),
                    ),
                    SizedBox(height: 20.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                      child: BuildTextFormField2('الاسم الاخير',
                          SignUpCubit.get(context).lastNameController,
                          TextInputType.name,'ادخل الاسم الاخير', (value) {
          if (value!.isEmpty) {
            return 'الرجاء ادخال الاسم الاخير';
          }
          return null;
        },Icons.person),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                      child: BuildTextFormField2('رقم الهاتف',
                          SignUpCubit.get(context).phoneController,
                        TextInputType.phone,'ادخل رقم الهاتف', (value) {
          if (value!.isEmpty) {
            return 'الرجاء ادخال رقم الهاتف';
          }
          return null;
        },Icons.phone,),
                    ),
                    SizedBox(height: 20.0.h),
                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                         child: BuildTextFormField2('كلمة المرور',
                              SignUpCubit.get(context).passwordController
                             ,TextInputType.text, 'ادخل كلمة المرور', (value) {
          if (value!.isEmpty) {
            return 'الرجاء ادخال كلمة المرور';
          }
          else if (value.length < 6) {
        return 'يجب ادخال كلمة مرور اكثر من ٦ أحرف او ارقام';
        }
          return null;
        },Icons.lock, ),
                       ),

                    SizedBox(height: 10.0.h),
                    Text(
                      'مكان التدريب:',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                   //10.0.h
                    SizedBox(height: 10.0.h),
                  // if state is UpdateSelectedItemsState update this widget
                    BlocConsumer<SignUpCubit,SignUpState >(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: _showMultiSelect,
                          child: const Text('Select Your Favorite Topics'),
                        ),
                        const Divider(height: 30),
                        if (SignUpCubit.get(context).selectedItems != null &&
                            SignUpCubit.get(context).selectedItems!.isNotEmpty)
                        Wrap(
                          children: SignUpCubit.get(context).selectedItems!
                          .map((e) => Chip(
                            label: Text(e),
                          ))
                              .toList(),
                        ),
                      ],
                    );
  },
),



                    // BlocConsumer<OtpCubit,OtpState >(
                     BlocConsumer<SignUpCubit,SignUpState >(
              listener: (context, state) {
        // if (state is PhoneNumberSubmittedloaded) {
        // Navigator.pushNamed(
        //         context,
        //         AppRoutes.otpVerification,
        //         arguments: {
        //           'phone': phoneController.text,
        //           'lName': lastNameController.text,
        //           'fName': firstNameController.text,
        //           'password': passwordController.text,
        //         },
        //       );
         // }
               //show toast in case of error and success
                if (state is SignUpErrorState) {
                  showToast(
                    msg:state.error?? 'حدث خطأ ما',
                    state: ToastStates.ERROR,
                  );
                }else if (state is SignUpSuccessState) {
                  showToast(
                    msg: 'تم التسجيل بنجاح',
                    state: ToastStates.SUCCESS,
                  );
                }

      },
      builder: (context, state) {
        return ConditionalBuilder(
        condition: state is! SignUpLoadingState,
        builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
             left: 31.w,
             right: 31.w,
             top: 40.h
          ),
          child: ElevatedButton(
            onPressed: () {
              if (
                  SignUpCubit.get(context).formKey
                  .currentState!.validate()) {
                //signUp
                SignUpCubit.get(context).signUp(
                  fName: SignUpCubit.get(context).firstNameController.text,
                  lName: SignUpCubit.get(context).lastNameController.text,
                  phone: SignUpCubit.get(context).phoneController.text,
                  password: SignUpCubit.get(context).passwordController.text,
                );
               // OtpCubit.get(context).phoneNumberSubmitted(phoneController.text);
              }
            },
            child: Text(
              'تسجيل',
              style: TextStyle(
                fontFamily: 'Montserrat-Arabic',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 18,
                height: 26 / 18,
                color: Color(0xFFFFFFFF),
              ),
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF2196F3), // Background color
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: TextStyle(
                fontSize: 18, // Adjust the font size if needed
              ),
            ),
          ),

        );

        },
        fallback: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
        },
        );


      },
),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
      },
);
    }
  );
}}
