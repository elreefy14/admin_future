import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
         // key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: Column(
                           //   mainAxisSize: MainAxisSize.max,
                              children: [
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
                                Expanded(
                                  child: BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
  builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
           // physics: BouncingScrollPhysics(),

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
                                            '2500',
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
                                              'عبدالرحمن سعيد',
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
                                )

                              ].divide(SizedBox(height: 0)),
                            ),


                        ),



        );
      }
    );
  }
}

