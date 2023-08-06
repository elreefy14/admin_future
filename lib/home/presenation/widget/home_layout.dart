import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/routes_manager.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../core/flutter_flow/flutter_flow_widgets.dart';
import '../../business_logic/Home/manage_salary_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0, -1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0x00FFFFFF),
                            border: Border.all(
                              color: const Color(0xFFB9B9B9),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 197,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/image112222222222222222222222222222222222.png',
                                    ).image,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'تحميل الرمز',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ]
                          .divide(const SizedBox(height: 10))
                          .addToStart(const SizedBox(height: 0)),
                    ),
                  ),
                  // FFButtonWidget(
                  //   onPressed: () {
                  //     print('Button pressed ...');
                  //   },
                  //   text: 'انشاء رمز QR',
                  //   options: FFButtonOptions(
                  //     width: 240,
                  //     height: 50,
                  //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  //     iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  //     color: Color(0xFF42A5F5),
                  //     textStyle:
                  //     FlutterFlowTheme.of(context).titleSmall.override(
                  //       fontFamily: 'Readex Pro',
                  //       color: Colors.white,
                  //     ),
                  //     elevation: 3,
                  //     borderSide: BorderSide(
                  //       color: Colors.transparent,
                  //       width: 1,
                  //     ),
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  // ),
                  //25
                  SizedBox(height: 25.h,),
                  Container(
                    width: 240,
                    height: 50,
                    child: ElevatedButton(
                    onPressed: (){}, child: const Text(
                      'انشاء رمز Qr',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Montserrat-Arabic',
                        fontWeight: FontWeight.w400,
                       // height: 1.44,
                      ),
                    ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await ManageSalaryCubit.get(context).getUsers();
                          ManageSalaryCubit.get(context).syncData();
                          Navigator.pushNamed(context, AppRoutes.manageCoaches);
                        },
                        child: Container(
                          width: 155.w,
                          height: 160.h,
                          decoration: BoxDecoration(
                            color: const Color(0x4064B5F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/group_add_people_svgrepo.com.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Text(
                                  'ادارة المدربين',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()  {
                   //push named to the page manage attendees
                          Navigator.pushNamed(context, AppRoutes.manageAttendence);
                        },
                        child: Container(
                          width: 155.w,
                          height: 160.h,
                          decoration: BoxDecoration(
                            color: const Color(0xF1C6F1F7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/frame23400.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Text(
                                  'ادارة الحضور',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: const Color(0xFF00D1FF),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 20)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 155.w,
                        height: 160.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9AFFB6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: const AlignmentDirectional(0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                                alignment: const AlignmentDirectional(0, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/group-add-people_svgrepo.com.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Text(
                                'ادارة المدربين',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0xFF00CE3A),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await ManageSalaryCubit.get(context).getUsers();
                         ManageSalaryCubit.get(context).syncData();
                      Navigator.pushNamed(context, AppRoutes.manageSalary);
                        },
                        child: Container(
                          width: 155.w,
                          height: 160.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE3E8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/dollar-sign-round_svgrepo.com.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Text(
                                  'ادارة المرتب',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: const Color(0xFFD92D20),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 20)),
                  ),
                ].divide(const SizedBox(height: 20)),
              ),
            ].divide(const SizedBox(height: 40)),
          ),
        ),
      ),
    );
  }
}
