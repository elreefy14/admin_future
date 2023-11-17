import 'package:admin_future/core/constants/routes_manager.dart';
import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/presenation/widget/widget/custom_app_bar.dart';
import 'package:admin_future/home/presenation/widget/widget/search_bar.dart';
import 'package:admin_future/registeration/data/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:flutterfire_ui/firestore.dart';

import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../business_logic/Home/manage_salary_cubit.dart';

class ManageCoaches extends StatelessWidget {
  const ManageCoaches({super.key});

  @override
  Widget build(BuildContext context) {
    //Undefined name '_model'.
    //TextEditingController _model = TextEditingController();
    return Builder(
      builder: (context) {
       // ManageSalaryCubit.get(context).getUsers();
        return BlocListener<ManageSalaryCubit, ManageSalaryState
        >(
  listener: (context, state) {
    if(state is PaySalarySuccessStateWithoutInternet ){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              ' سيتم دفع المرتب عند الاتصال بالانترنت '

            //   'wait for internet connection'
            //translate to arabic
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else if(state is PaySalarySuccessState ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم دفع المرتب بنجاح'
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  },
  child: Scaffold(
    appBar: CustomAppBar(text: 'ادارة المتدربين'),
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child:SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //30
                          SizedBox(
                            height: 30.h,
                          ),
                          CustomSearchBar(
                            isCoach: false,
                          ),
//20
    //                    SizedBox(height: 5.h),

                        ].divide(SizedBox(height: 20.h)),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                    //    height: MediaQuery.sizeOf(context).height * 1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0x00F4F4F4),
                            width: 0,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(
                              thickness: 2,
                              color: Color(0xFFF4F4F4),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                              //  Text('asad'),

                                BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
  builder: (context, state) {
    return ListView.builder(
                          //   query :FirebaseFirestore.instance.collection('users'),
                              //    cacheExtent: 100,
                                //  pageSize: 5,
                                //  physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                              itemCount: ManageSalaryCubit.get(context).users.length,
                                  itemBuilder: (context, index) =>
                                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color: Color(0xFFB4B4B4),
                                width: 1.w,
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                 final manageSalaryCubit = ManageSalaryCubit.get(context);
                                 manageSalaryCubit.initControllers(ManageSalaryCubit.get(context).users[index]);
                                 await Navigator.pushNamed(context,
                                 AppRoutes.editProfile,
                                 arguments: ManageSalaryCubit.get(context).users[index]
                                 as UserModel
                                 ) ;


                              },
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: InkWell(
                                  child: Text(
                                    '...المزيد ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF2196F3),
                                      fontSize: 10.sp,
                                      fontFamily: 'Montserrat-Arabic',
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                      height: 0.13.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
  builder: (context, state) {
    return Container(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color: Color(0xFFB4B4B4),
                                width: 1.w,
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                String? uid =ManageSalaryCubit.get(context).users[index].uId;
                                //show dialog
                                await showDialog(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                        ),
                                                                        child: Container(
                                                                          //height: 500,
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: [
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                        child: SvgPicture.asset(
                                                                                          'assets/images/frame23420.svg',
                                                                                          width: 50.w,
                                                                                          height: 50.h,
                                                                                          fit: BoxFit.none,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Text(
                                                                                    'دفع المرتب',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Readex Pro',
                                                                                      fontSize: 24.sp,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0, 0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(1, 0),
                                                                                            child: Container(
                                                                                              width: 100.w,
                                                                                              child: TextFormField(
                                                                                                controller: ManageSalaryCubit.get(context).salaryController,
                                                                                                autofocus: true,
                                                                                                obscureText: false,
                                                                                                decoration: InputDecoration(
                                                                                                  labelStyle: FlutterFlowTheme.of(context)
                                                                                                      .labelMedium
                                                                                                      .override(
                                                                                                    fontFamily: 'Readex Pro',
                                                                                                    fontSize: 10.sp,
                                                                                                  ),
                                                                                                  hintText: 'اكتب رقم',
                                                                                                  hintStyle: FlutterFlowTheme.of(context)
                                                                                                      .labelMedium
                                                                                                      .override(
                                                                                                    fontFamily: 'Readex Pro',
                                                                                                    fontSize: 10.sp,
                                                                                                  ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Color(0xFFF4F4F4),
                                                                                                      width: 2.w,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.blue,
                                                                                                      width: 2.w,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                                  ),
                                                                                                  errorBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                                      width: 2.w,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                                  ),
                                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                                      width: 2.w,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                                  ),
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context)
                                                                                                    .bodyMedium
                                                                                                    .override(
                                                                                                  fontFamily: 'Readex Pro',
                                                                                                  fontSize: 10.sp,
                                                                                                ),
                                                                                                textAlign: TextAlign.end,
                                                                                                keyboardType: TextInputType.number,
                                                                                                cursorColor: Color(0xFF333333),
                                                                                             //   validator: _model.textControllerValidator
                                                                                               //     .asValidator(context),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          ':الدفع الجزئي',
                                                                                          style:
                                                                                          FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Readex Pro',
                                                                                            fontSize: 12.sp,
                                                                                          ),
                                                                                        ),
                                                                                      ]
                                                                                          .divide(SizedBox(width: 10.w))
                                                                                          .addToEnd(SizedBox(width: 15.w)),
                                                                                    ),
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [

                                                                                      InkWell(
                                                                                        onTap: () async {
                                                                                          print('uiiiiiiiiid \n\n');
                                                                                          //     print(ManageSalaryCubit.get(context).users[index].uId);
                                                                                          await ManageSalaryCubit.get(context).payPartialSalary(
                                                                                            userId:
                                                                                            uid,salary: ManageSalaryCubit.get(context).salaryController.text,
                                                                                          ).then((value) => Navigator.pop(context));
                                                                                        },
                                                                                        child: Container(
                                                                                          width: 130.w,
                                                                                          height: 40.h,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Color(0xFFB9B9B9),
                                                                                            borderRadius: BorderRadius.circular(8),
                                                                                          ),
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(0, 0),
                                                                                            child: Text(
                                                                                              'دفع جزئي',
                                                                                              style: FlutterFlowTheme.of(context)
                                                                                                  .titleSmall
                                                                                                  .override(
                                                                                                fontFamily: 'Readex Pro',
                                                                                                color: Colors.white,
                                                                                                fontSize: 12.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                      InkWell(
                                                                                        onTap: () async {

                                                                                         print('uiiiiiiiiid \n\n');

                                                                                         //edit this to enable roll back salary by showing button to roll back salary
                                                                                  //edit
                                                                                    //   Future<void> paySalary({String? userId}) async {
                                                                                         //     try {
                                                                                         //       print('userId: $userId');
                                                                                         //       emit(PaySalaryLoadingState());
                                                                                         //
                                                                                         //       bool isConnected =
                                                                                         //           await checkInternetConnectivity(); // Custom function to check internet connectivity
                                                                                         //
                                                                                         //       if (!isConnected) {
                                                                                         //         DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
                                                                                         //             .collection('users')
                                                                                         //             .doc(userId)
                                                                                         //             .get(GetOptions(source: Source.serverAndCache));
                                                                                         //
                                                                                         //         Map<String, dynamic>? userData =
                                                                                         //             userSnapshot.data() as Map<String, dynamic>?;
                                                                                         //
                                                                                         //         if (userData != null) {
                                                                                         //           int newTotalSalary = 0;
                                                                                         //
                                                                                         //           // Store the updated salary locally until an internet connection is available
                                                                                         //           saveSalaryLocally(userId, newTotalSalary);
                                                                                         //
                                                                                         //           // Update the user in the users list
                                                                                         //           UserModel updatedUser = UserModel.fromJson(userData);
                                                                                         //           updatedUser.totalSalary = newTotalSalary;
                                                                                         //           int userIndex = coaches.indexWhere((user) => user.uId == userId);
                                                                                         //           if (userIndex != -1) {
                                                                                         //             coaches[userIndex] = updatedUser;
                                                                                         //           }
                                                                                         //           emit(PaySalarySuccessStateWithoutInternet());
                                                                                         //           return;
                                                                                         //         }
                                                                                         //       }
                                                                                         //
                                                                                         //       await FirebaseFirestore.instance
                                                                                         //           .collection('users')
                                                                                         //           .doc(userId)
                                                                                         //           .update({'totalSalary': 0});
                                                                                         //
                                                                                         //       DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
                                                                                         //           .collection('users')
                                                                                         //           .doc(userId)
                                                                                         //           .get(GetOptions(source: Source.server));
                                                                                         //
                                                                                         //       Map<String, dynamic>? userData =
                                                                                         //           userSnapshot.data() as Map<String, dynamic>?;
                                                                                         //
                                                                                         //       if (userData != null) {
                                                                                         //         int newTotalSalary = 0;
                                                                                         //
                                                                                         //         // Update the user in the users list
                                                                                         //         UserModel updatedUser = UserModel.fromJson(userData);
                                                                                         //         updatedUser.totalSalary = newTotalSalary;
                                                                                         //         int userIndex = coaches.indexWhere((user) => user.uId == userId);
                                                                                         //         if (userIndex != -1) {
                                                                                         //           coaches[userIndex] = updatedUser;
                                                                                         //         }
                                                                                         //
                                                                                         //         emit(PaySalarySuccessState());
                                                                                         //       } else {
                                                                                         //         throw 'User data not found';
                                                                                         //       }
                                                                                         //     } catch (error) {
                                                                                         //       print(error.toString());
                                                                                         //       emit(PaySalaryErrorState(error.toString()));
                                                                                         //     }
                                                                                         //   }
                                                                                  await ManageSalaryCubit.get(context).paySalary(
                                                                                         userId:
                                                                                         uid,
                                                                                       ).then((value) => Navigator.pop(context));
                                                                                        },
                                                                                        child: Container(
                                                                                          width: 130.w,
                                                                                          height: 40.h,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Colors.blue,
                                                                                            borderRadius: BorderRadius.circular(8),
                                                                                          ),
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(0, 0),
                                                                                            child: Text(
                                                                                              'دفع كل المرتب',
                                                                                              style: FlutterFlowTheme.of(context)
                                                                                                  .titleSmall
                                                                                                  .override(
                                                                                                fontFamily: 'Readex Pro',
                                                                                                color: Colors.white,
                                                                                                fontSize: 12.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ].divide(SizedBox(width: 10.w)),
                                                                                  ),

                                                                                ].divide(SizedBox(height: 35.h)).addToStart(SizedBox(height: 50.h)),
                                                                              ),
                                                                         SizedBox(
                                                                           height: 20.h,
                                                                         )
                                                                            ].divide(SizedBox(height: 0.h)),
                                                                          ),
                                                                        ),
                                                                      );
                                  },
                                );
                              },
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'دفع الراتب',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF2196F3),
                                    fontSize: 10,
                                    fontFamily: 'Montserrat-Arabic',
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                    height: 0.13,
                                  ),
                                ),
                              ),
                            ),
                          );
  },
),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: Border.all(
                                color: Color(0xFFB4B4B4),
                                width: 1.w,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                               //user name
                               ManageSalaryCubit.get(context).users[index].phone??'',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'Montserrat-Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0.13.h,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1, 0),
                            child: Container(
                              width:
                              MediaQuery.sizeOf(context).width * 0.3,
                              height: 35.h,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                border: Border.all(
                                  color: Color(0xFFB4B4B4),
                                  width: 1.w,
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                 ' ${
                                 ManageSalaryCubit.get(context).users[index].fname??''} ${(ManageSalaryCubit.get(context).users[index].lname??'')}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    fontFamily: 'Montserrat-Arabic',
                                    fontWeight: FontWeight.w400,
                                    height: 0.13.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                                );
  },
)
                    ],
                       //       .divide(SizedBox(height: 0)),
                            ),
                            Divider(
                              thickness: 2,
                              color: Color(0xFFF4F4F4),
                            ),
                             Visibility(
          visible: true,
          //_showRollbackButton,
         // ManageSalaryCubit.get(context).showRollbackButton,
          child: ElevatedButton(
            onPressed: () {
              // Handle rollback of salary
            },
            child: Text('Rollback Changes'),
          ),
        ),
                           InkWell(
                              onTap: () async {
                                await Navigator.pushNamed(context,
                                    AppRoutes.addCoach,
                                    arguments: {'isCoach': false}

                                );
                              },
                             child: Container(
                               height: 50.h,
                                width: 180.w,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Container(
                                    width: 180.w,
                                    height: 50.h,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF2196F3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'اضافة مدرب',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontFamily: 'Montserrat-Arabic',
                                              fontWeight: FontWeight.w400,
                                              height: 0.08.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                      )
                                      ),
                             ),
                           ),
                            SizedBox(height: 20.h),
                          ]
                              .divide(SizedBox(height: 0.h))
                              .addToStart(SizedBox(height: 0.h)),
                           //   .addToEnd(SizedBox(height: 10.h)),
                        ),
                      ),
                    ].divide(SizedBox(height: 0.h)),
                  ),
                ].addToStart(SizedBox(height: 10.h)),
              ),
            ),
          ),
        ),
);
      }
    );
  }
}
