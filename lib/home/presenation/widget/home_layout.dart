
import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/constants/routes_manager.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../core/flutter_flow/flutter_flow_widgets.dart';
import '../../business_logic/Home/manage_attendence_state.dart';
import '../../business_logic/Home/manage_salary_cubit.dart';

class HomeLayout extends StatelessWidget {
   HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(

      builder: (context) {
        //ManageAttendenceCubit.get(context).getSchedulesForAdmin(
        //).then((value) =>
        ManageAttendenceCubit.get(context).getNearestSchedule();
        //);
        return BlocConsumer<ManageAttendenceCubit, ManageAttendenceState>(
            listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
    //use flutter_screenutil to make above HomeLayout responsive
    //instead of height: 160 ,use height: 160.h,
    //instead of width: 155, use width: 155.w,
    //instead of SizedBox(height: 20), use SizedBox(height: 20.h),
    //instead of SizedBox(width: 20), use SizedBox(width: 20.w),
    //instead of fontSize: 16, use fontSize: 16.sp,
    //instead of fontSize: 18, use fontSize: 18.sp, and so on for all sizes in the app
    //key: scaffoldKey,
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
    alignment:  AlignmentDirectional(0, -1),
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Container(
    width: 200.w,
    height: 200.h,
    decoration: BoxDecoration(
    color:  Color(0x00FFFFFF),
    border: Border.all(
    color:  Color(0xFFB9B9B9),
    width: 1.5,
    ),
    ),
    child: BlocBuilder<ManageAttendenceCubit,
    ManageAttendenceState>(
    builder: (context, state) {
    return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    //         state is! GenerateQRCodeSuccessState
    //            ?
    ManageAttendenceCubit.get(context).nearestSchedule == null
    ?
    Container(
    width: 200.w,
    height: 197.h,
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
                                  )
                                      :
                                  QrImageView(
        data: ManageAttendenceCubit.get(context).nearestSchedule!['branch_id'].toString(),
    version: QrVersions.auto,
    size: 197.0,
    ),

    ],
    );
    },
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
    .divide( SizedBox(height: 10.h))
    .addToStart( SizedBox(height: 0.h)),
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
    SizedBox(height: 15.h,),
    InkWell(
    onTap: () async {
    ManageAttendenceCubit.get(context).getNearestSchedule();
    },
    child: Container(
    width: 240.w,
    height: 50.h,
    child: ElevatedButton(
    onPressed: (){}, child:  Text(
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
    color:  Color(0x4064B5F6),
    borderRadius: BorderRadius.circular(12),
    ),
    alignment:  AlignmentDirectional(0, 0),
    child: SingleChildScrollView(
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Container(
    width: 60.w,
    height: 60.h,
    decoration:  BoxDecoration(
    color: Color(0x00FFFFFF),
    ),
    alignment:  AlignmentDirectional(0, 0),
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
    fontSize: 16.sp,
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
    color:  Color(0xF1C6F1F7),
    borderRadius: BorderRadius.circular(12),
    ),
    alignment:  AlignmentDirectional(0, 0),
    child: SingleChildScrollView(
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Container(
    width: 60.w,
    height: 60.h,
    decoration:  BoxDecoration(
    color: Color(0x00FFFFFF),
    ),
    alignment:  AlignmentDirectional(0, 0),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.asset(
    'assets/images/frame23400.png',
    width: 50.w,
    height: 50.h,
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
    color:  Color(0xFF00D1FF),
    fontSize: 16.sp,
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    ].divide( SizedBox(width: 20.w)),
    ),
    Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    InkWell(
    onTap: () async {
    //pass today as a parameter
    ManageSalaryCubit.get(context).getDays()?.then((value) async =>
    await ManageSalaryCubit.get(context).getSchedules(day: ManageSalaryCubit.get(context).days?[0]??'الأربعاء'));
    await ManageSalaryCubit.get(context).getSchedules(day: ManageSalaryCubit.get(context).days?[0]??'الأربعاء');
    Navigator.pushNamed(context, AppRoutes.manageSchedules);
    },
    child: Container(
    width: 155.w,
    height: 160.h,
    decoration: BoxDecoration(
    color:  Color(0xFF9AFFB6),
    borderRadius: BorderRadius.circular(12),
    ),
    alignment:  AlignmentDirectional(0, 0),
    child: SingleChildScrollView(
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Container(
    width: 60.w,
    height: 60.h,
    decoration:  BoxDecoration(
    color: Color(0x00FFFFFF),
    ),
    alignment:  AlignmentDirectional(0, 0),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.asset(
    'assets/images/group-add-people_svgrepo.com.png',
    width: 50.w,
    height: 50.h,
    fit: BoxFit.fitWidth,
    ),
    ),
    ),
    Text(
    //manage appoinments
    'ادارة المواعيد',
    style: FlutterFlowTheme.of(context)
        .bodyMedium
        .override(
    fontFamily: 'Readex Pro',
    color:  Color(0xFF00CE3A),
    fontSize: 16.sp,
    ),
    ),
    ],
    ),
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
    color:  Color(0xFFFEE3E8),
    borderRadius: BorderRadius.circular(12),
    ),
    alignment:  AlignmentDirectional(0, 0),
    child: SingleChildScrollView(
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Container(
    width: 60.w,
    height: 60.h,
    decoration:  BoxDecoration(
    color: Color(0x00FFFFFF),
    ),
    alignment:  AlignmentDirectional(0, 0),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.asset(
    'assets/images/dollar-sign-round_svgrepo.com.png',
    width: 50.w,
    height: 50.h,
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
    color:  Color(0xFFD92D20),
    fontSize: 16.sp,
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    ].divide( SizedBox(width: 20.w)),
    ),
    ].divide( SizedBox(height: 20.h)),
    ),
    ].divide( SizedBox(height: 20.h)),
    ),
    ),
    ),
    );
  },
    );
      }
    );
  }
}



