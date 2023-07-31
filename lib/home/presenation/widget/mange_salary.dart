import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../business_logic/Home/manage_salary_cubit.dart';

class ManageSalary extends StatelessWidget {
  const ManageSalary({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ManageSalaryCubit.get(context).getUsers();
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   shadowColor: Colors.transparent,
          // ),
         // key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                             //   mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'assets/images/back.png',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'ادارة المرتب',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 32,
                                      fontFamily: 'Montserrat-Arabic',
                                      fontWeight: FontWeight.w400,
                                      height: 0.81,
                                    ),
                                  ),
                                  //60
                                  SizedBox(
                                    height: 60.h,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.2,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          border: Border.all(
                                            color: Color(0xFFB4B4B4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            'دفع',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          border: Border.all(
                                            color: Color(0xFFB4B4B4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            'مجموع المرتب',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          border: Border.all(
                                            color: Color(0xFFB4B4B4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            'المرتب المدفوع',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Container(
                                          width: MediaQuery.sizeOf(context).width *
                                              0.3,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            border: Border.all(
                                              color: Color(0xFFB4B4B4),
                                              width: 1,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: AlignmentDirectional(0, 0),
                                            child: Text(
                                              'الاسم',
                                              textAlign: TextAlign.end,
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
  builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

          itemBuilder: (context, index) => Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.2,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          border: Border.all(
                                            color: Color(0xFFB4B4B4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            'دفع المرتب',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.blue,
                                              fontSize: 10,
                                              decoration:
                                              TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          border: Border.all(
                                            color: Color(0xFFB4B4B4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                           ManageSalaryCubit.get(context).users[index].totalSalary.toString(),
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          border: Border.all(
                                            color: Color(0xFFB4B4B4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            '0',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Container(
                                          width: MediaQuery.sizeOf(context).width *
                                              0.3,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            border: Border.all(
                                              color: Color(0xFFB4B4B4),
                                              width: 1,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: AlignmentDirectional(0, 0),
                                            child: Text(
                                              ' ${
                                                  ManageSalaryCubit.get(context).users[index].fname??''} ${(ManageSalaryCubit.get(context).users[index].lname??'')}',
                                              textAlign: TextAlign.end,
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  itemCount:ManageSalaryCubit.get(context).users?.length,

                                  );
  },
),
                                  //20
                                SizedBox(height: 20.h,),
                                  Container(
                                  //  width: 169,
                                   // height: 49,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'مجموع مرتب كل المدربين',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF333333),
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat-Arabic',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.62,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: 48,
                                          child: BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
  builder: (context, state) {
    return Text(
                                            ManageSalaryCubit.get(context).globalTotalSalary.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF2196F3),
                                              fontSize: 14,
                                              fontFamily: 'Montserrat-Arabic',
                                              fontWeight: FontWeight.w400,
                                              height: 1.30,
                                            ),
                                          );
  },
),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //20
                                  SizedBox(height: 50.h,),

                                ].divide(SizedBox(height: 0)),
                              ),
            ),


                        ),



        );
      }
    );
  }
}

