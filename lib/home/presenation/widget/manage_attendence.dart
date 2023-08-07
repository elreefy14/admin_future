import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
class ManageAttendence extends StatelessWidget {
  const ManageAttendence({super.key});

  @override
  Widget build(BuildContext context) {
    //return BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
    // builder: (context, state) {

    return FutureBuilder(
        future:  ManageAttendenceCubit.get(context).getSchedulesForAdmin(),

        builder: (context, snapshot) {
          return Scaffold(
            // key: scaffoldKey,
            backgroundColor: Colors.white,
            body: SafeArea(
              top: true,
              child:
              Column(

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
                  SizedBox(
                    height: 30.h,
                  ),
                  // Generated code for this Text Widget...
                  Text(
                    'ادارة الحضور',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Expanded(
                    child: BlocConsumer<ManageAttendenceCubit, ManageAttendenceState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return ListView.separated(

                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var schedule = ManageAttendenceCubit
                                .get(context)
                                .schedulesList![index];
                            var startTime =
                            DateFormat('hh a', 'ar').format(
                                schedule['start_time']?.toDate() ?? DateTime.now());
                            var date = DateFormat('yyyy/MM/dd ', 'ar').format(
                                schedule['start_time']?.toDate() ?? DateTime.now());
                            var day = DateFormat('EEEE', 'ar').format(
                                schedule['start_time']?.toDate() ?? DateTime.now());
                            var endTime = DateFormat('hh a', 'ar').format(
                                schedule['end_time']?.toDate() ?? DateTime.now());
                            var formattedSchedule = '$startTime $date';
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(1, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            date,
                                            style: FlutterFlowTheme
                                                .of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 11,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                startTime,
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme
                                                    .of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 11,
                                                ),
                                              ),
                                              Text(
                                                '<--',
                                                style: FlutterFlowTheme
                                                    .of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 11,
                                                ),
                                              ),
                                              Text(
                                                endTime,
                                                style: FlutterFlowTheme
                                                    .of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(width: 20)),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Text(
                                          schedule['branch_id'].toString(),
                                          style: FlutterFlowTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ].addToStart(SizedBox(width: 5)).addToEnd(SizedBox(width: 5)),
                                  ),
                                ),

                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: schedule['users'].map((Map<String, dynamic> user) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: MediaQuery
                                                  .sizeOf(context)
                                                  .width * 0.2,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme
                                                    .of(context)
                                                    .secondaryBackground,
                                                border: Border.all(
                                                  color: Color(0xFFB4B4B4),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(0, 0),
                                                child: Text(
                                                  'دفع الراتب',
                                                  textAlign: TextAlign.end,
                                                  style: FlutterFlowTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.blue,
                                                    fontSize: 10,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery
                                                  .sizeOf(context)
                                                  .width * 0.35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme
                                                    .of(context)
                                                    .secondaryBackground,
                                                border: Border.all(
                                                  color: Color(0xFFB4B4B4),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(0, 0),
                                                child: Text(
                                                  user['hourly_rate'].toString(),
                                                  textAlign: TextAlign.end,
                                                  style: FlutterFlowTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 10,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(1, 0),
                                              child: Container(
                                                width: MediaQuery
                                                    .sizeOf(context)
                                                    .width * 0.35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .secondaryBackground,
                                                  border: Border.all(
                                                    color: Color(0xFFB4B4B4),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment: AlignmentDirectional(0, 0),
                                                  child: Text(
                                                    user['name'].toString(),
                                                    textAlign: TextAlign.end,
                                                    style: FlutterFlowTheme
                                                        .of(context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery
                                                  .sizeOf(context)
                                                  .width * 0.1,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme
                                                    .of(context)
                                                    .secondaryBackground,
                                                border: Border.all(
                                                  color: Color(0xFFB4B4B4),
                                                  width: 1,
                                                ),
                                              ),
                                              child: BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
  builder: (context, state) {
    return Stack(
                                                alignment: AlignmentDirectional(0, 0),
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 49,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                      borderRadius: BorderRadius.circular(5),
                                                       border: Border.all(
                                                         color: Colors.blue,
                                                         width: 1,  ),
                                                    ),
                                                    child: Checkbox(
                                                      onChanged: (value) {
                                                        ManageAttendenceCubit.get(context).changeAttendance(
                                                            schedule['id'], user['id'], value);
                                                      },

                                                      hoverColor: Colors.blue,
                                                      overlayColor: MaterialStateProperty.all(Colors.blue),
                                                      checkColor: Colors.white,
                                                      activeColor: Colors.blue,
                                                      value: user['finished'] ?? false,
                                                    ),
                                                  ),
                                                ],
                                              );
  },
),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                    return
                                      StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('admins')
                                            .doc('JcElORFrvvpvtSsk4Iou')
                                            .collection('schedules')
                                            .doc(schedule['id'])
                                            .collection('users')
                                            .doc(user['id'])
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Container();
                                          }
                                          final userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};
                                          final bool finished = userData['finished'] ?? false;
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: MediaQuery
                                                        .sizeOf(context)
                                                        .width * 0.2,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .secondaryBackground,
                                                      border: Border.all(
                                                        color: Color(0xFFB4B4B4),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment: AlignmentDirectional(0, 0),
                                                      child: Text(
                                                        'دفع الراتب',
                                                        textAlign: TextAlign.end,
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily: 'Readex Pro',
                                                          color: Colors.blue,
                                                          fontSize: 10,
                                                          decoration: TextDecoration.underline,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery
                                                        .sizeOf(context)
                                                        .width * 0.35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .secondaryBackground,
                                                      border: Border.all(
                                                        color: Color(0xFFB4B4B4),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment: AlignmentDirectional(0, 0),
                                                      child: Text(
                                                        user['hourly_rate'].toString(),
                                                        textAlign: TextAlign.end,
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily: 'Readex Pro',
                                                          fontSize: 10,
                                                          decoration: TextDecoration.underline,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: AlignmentDirectional(1, 0),
                                                    child: Container(
                                                      width: MediaQuery
                                                          .sizeOf(context)
                                                          .width * 0.35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                        border: Border.all(
                                                          color: Color(0xFFB4B4B4),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Align(
                                                        alignment: AlignmentDirectional(0, 0),
                                                        child: Text(
                                                          user['name'].toString(),
                                                          textAlign: TextAlign.end,
                                                          style: FlutterFlowTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily: 'Readex Pro',
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery
                                                        .sizeOf(context)
                                                        .width * 0.1,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .secondaryBackground,
                                                      border: Border.all(
                                                        color: Color(0xFFB4B4B4),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      alignment: AlignmentDirectional(0, 0),
                                                      children: [
                                                        Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            color: Color(0x00FFFFFF),
                                                            borderRadius: BorderRadius.circular(5),
                                                            border: Border.all(
                                                              color: Colors.blue,
                                                              width: 2,
                                                            ),
                                                          ),
                                                          child: Checkbox(
                                                            onChanged: (value) {
                                                              ManageAttendenceCubit.get(context).changeAttendance(
                                                                  schedule['id'], user['id'], value);
                                                            },

                                                            hoverColor: Colors.blue,
                                                            overlayColor: MaterialStateProperty.all(Colors.blue),
                                                            checkColor: Colors.white,
                                                            activeColor: Colors.blue,
                                                            value: finished,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );


                                  }).toList().cast<Widget>(),
                                ),
                              ].divide(SizedBox(height: 20)),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                          itemCount: ManageAttendenceCubit
                              .get(context)
                              .schedulesList
                              .length,);
                      },
                    ),
                  ),
                ],
              ),


            ),
          );
        }
    );
  }
}

