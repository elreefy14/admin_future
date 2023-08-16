import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_salary_cubit.dart';
import 'package:admin_future/home/data/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../core/flutter_flow/flutter_flow_widgets.dart';

class EditUsers extends StatelessWidget {
  //const ({super.key});
  final user;

  const EditUsers({super.key, required this.user});
  @override
  Widget build(BuildContext context) {



    return Builder(
      builder: (context) {
        // final manageSalaryCubit = ManageSalaryCubit.get(context);
        // manageSalaryCubit.initControllers(user);
        return Scaffold(
          // key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(

              child: Form(
                key: ManageSalaryCubit.get(context).formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            user.image??'https://picsum.photos/seed/1/600',
                            width: 130.h,
                            height: 130.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'اسم الاول',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(),
                                      child: Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Container(
                                          width:
                                          MediaQuery.sizeOf(context).width * 0.8,
                                          child: TextFormField(
                                            // initialValue: user.fname??'a',
                                            controller: ManageSalaryCubit.get(context)
                                                .firstNameController,
                                            autofocus: true,
                                            obscureText: false,

                                            decoration: InputDecoration(
                                              labelStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                          //    hintText: user.fname??'a',
                                              hintStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFF4F4F4),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.end,
                                            keyboardType: TextInputType.name,
                                            cursorColor: Color(0xFF333333),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                                  .divide(SizedBox(height: 5))
                                  .addToEnd(SizedBox(height: 10)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'اسم الاخير',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(),
                                      child: Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Container(
                                          width:
                                          MediaQuery.sizeOf(context).width * 0.8,
                                          child: TextFormField(
                                            controller: ManageSalaryCubit.get(context)
                                                .lastNameController,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                         //     hintText: user.lname,
                                              hintStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFF4F4F4),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.end,
                                            keyboardType: TextInputType.name,
                                            cursorColor: Color(0xFF333333),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                                  .divide(SizedBox(height: 5.h))
                                  .addToEnd(SizedBox(height: 10.h)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'رقم الهاتف',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(),
                                      child: Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Container(
                                          width:
                                          MediaQuery.sizeOf(context).width * 0.8,
                                          child: TextFormField(
                                            controller: ManageSalaryCubit.get(context)
                                                .phoneController,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                    //          hintText: user.phone,
                                              hintStyle: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFF4F4F4),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.end,
                                            keyboardType: TextInputType.emailAddress,
                                            cursorColor: Color(0xFF333333),


                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                                  .divide(SizedBox(height: 5.h))
                                  .addToEnd(SizedBox(height: 10.h)),
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 1),
                                      child: Container(
                                        width:
                                        MediaQuery.sizeOf(context).width * 0.35,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        alignment: AlignmentDirectional(0, 1),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // FFButtonWidget(
                                            //   onPressed: () {
                                            //     print('Button pressed ...');
                                            //   },
                                            //   text: 'ارسال اشعار',
                                            //   options: FFButtonOptions(
                                            //     width: 150,
                                            //     height: 50,
                                            //     padding:
                                            //     EdgeInsetsDirectional.fromSTEB(
                                            //         0, 0, 0, 0),
                                            //     iconPadding:
                                            //     EdgeInsetsDirectional.fromSTEB(
                                            //         0, 0, 0, 0),
                                            //     color: Color(0xFF198CE3),
                                            //     textStyle:
                                            //     FlutterFlowTheme.of(context)
                                            //         .titleSmall
                                            //         .override(
                                            //       fontFamily: 'Readex Pro',
                                            //       color: Colors.white,
                                            //       fontSize: 1,
                                            //     ),
                                            //     elevation: 3,
                                            //     borderSide: BorderSide(
                                            //       color: Colors.transparent,
                                            //       width: 1,
                                            //     ),
                                            //     borderRadius:
                                            //     BorderRadius.circular(8),
                                            //   ),
                                            // ),
                                            InkWell(
                                            onTap: () async {
                                      String? uid =user.uId;
                                     // show dialog
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
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.none,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'ارسال رسالة',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 24,
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 225,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme.of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Align(
                                                        alignment: AlignmentDirectional(1, 0),
                                                        child: Container(
                                                          width: 225,
                                                          child: TextFormField(
                                                            controller: ManageSalaryCubit.get(context).messageController,
                                                            autofocus: true,
                                                            obscureText: false,
                                                            decoration: InputDecoration(
                                                              labelStyle: FlutterFlowTheme.of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                fontSize: 14,
                                                              ),
                                                              hintText: 'اكتب رقم',
                                                              hintStyle: FlutterFlowTheme.of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                fontFamily: 'Readex Pro',
                                                                fontSize: 12,
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: Color(0xFFF4F4F4),
                                                                  width: 2,
                                                                ),
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: Colors.blue,
                                                                  width: 2,
                                                                ),
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                              errorBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  width: 2,
                                                                ),
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                              focusedErrorBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  width: 2,
                                                                ),
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily: 'Readex Pro',
                                                              fontSize: 14,
                                                            ),
                                                            textAlign: TextAlign.end,
                                                            maxLines: 9,
                                                            keyboardType: TextInputType.multiline,
                                                            cursorColor: Color(0xFF333333),
                                                          //  validator: _model.textControllerValidator
                                                         //       .asValidator(context),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Text(
                                                    //   ':الدفع الجزئي',
                                                    //   style:
                                                    //   FlutterFlowTheme.of(context).bodyMedium.override(
                                                    //     fontFamily: 'Readex Pro',
                                                    //     fontSize: 12,
                                                    //   ),
                                                    // ),
                                                  ]
                                                      .divide(SizedBox(width: 10))
                                                      .addToEnd(SizedBox(width: 15)),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  // FFButtonWidget(
                                                  //   onPressed: () {
                                                  //     print('Button pressed ...');
                                                  //   },
                                                  //   text: 'ارسال الرسالة',
                                                  //   options: FFButtonOptions(
                                                  //   //  width: 150,
                                                  //  //   height: 50,
                                                  //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                  //     iconPadding:
                                                  //     EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                  //     color: Colors.blue,
                                                  //     textStyle:
                                                  //     FlutterFlowTheme.of(context).titleSmall.override(
                                                  //       fontFamily: 'Readex Pro',
                                                  //       color: Colors.white,
                                                  //       fontSize: 12,
                                                  //     ),
                                                  //     elevation: 3,
                                                  //     borderSide: BorderSide(
                                                  //       color: Colors.transparent,
                                                  //       width: 1,
                                                  //     ),
                                                  //     borderRadius: BorderRadius.circular(8),
                                                  //   ),
                                                  // ),
                                                  BlocBuilder<ManageSalaryCubit,ManageSalaryState>(
  builder: (context, state) {
    return InkWell(
      onTap: () {

        ManageSalaryCubit.get(context).sendMessage(
          //uid
            uid: uid,
          context: context,
          message: ManageSalaryCubit.get(context).messageController.text,
        );
      },
      child: Container(
                                                      height: 50,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: Align(
                                                        alignment: AlignmentDirectional(0, 0),
                                                        child: Text(
                                                          'ارسال',
                                                          textAlign: TextAlign.center,
                                                          style: FlutterFlowTheme.of(context)
                                                              .titleSmall
                                                              .override(
                                                            fontFamily: 'Readex Pro',
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
    );
  },
),
                                                  //15.h

                                                ].divide(SizedBox(width: 10)),
                                              ),
                                              //SizedBox(height: 45),
                                            ].divide(SizedBox(height: 20)).addToStart(SizedBox(height: 50)),
                                          ),
                                        ].divide(SizedBox(height: 0)),
                                      ),
                                      ),
                                      );
                                      },
                                      );
                                      },
                                              child: Container(
                                                height: 50,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Align(
                                                  alignment: AlignmentDirectional(0, 0),
                                                  child: Text(
                                                    'ارسال اشعار',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 0.4,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Color(0x00FFFFFF),
                                      ),
                                      alignment: AlignmentDirectional(0, 1),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'المرتب/الساعة',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 12,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width:
                                                MediaQuery.sizeOf(context).width *
                                                    0.4,
                                                height: 50,
                                                decoration: BoxDecoration(),
                                                child: Align(
                                                  alignment:
                                                  AlignmentDirectional(1, 0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(context)
                                                        .width *
                                                        0.8,
                                                    child: TextFormField(
                                                      controller: ManageSalaryCubit
                                                          .get(context)
                                                          .salaryPerHourController,
                                                      autofocus: true,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        labelStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          fontSize: 10,
                                                        ),
                                                  //      hintText: user.hourlyRate.toString()??'',
                                                        hintStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          fontSize: 10,
                                                        ),
                                                        enabledBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Color(0xFFF4F4F4),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.blue,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        errorBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .error,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        focusedErrorBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .error,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                      ),
                                                      style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        fontSize: 10,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                      keyboardType:
                                                      TextInputType.emailAddress,
                                                      cursorColor: Color(0xFF333333),

                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]
                                            .divide(SizedBox(height: 5.h))
                                            .addToEnd(SizedBox(height: 0)),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 25)),
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

                                    BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
                                      builder: (context, state) {
                                        return InkWell(
                                          onTap: () async {
                                            await ManageSalaryCubit.get(context)
                                                .updateUserInfo(
                                              uid: user.uId,
                                              fname: ManageSalaryCubit.get(context)
                                                  .firstNameController
                                                  .text.toString(),
                                              lname: ManageSalaryCubit.get(context)
                                                  .lastNameController
                                                  .text.toString(),
                                              phone: ManageSalaryCubit.get(context)
                                                  .phoneController
                                                  .text.toString(),
                                              hourlyRate: ManageSalaryCubit.get(context)
                                                  .salaryPerHourController
                                                  .text.toString(),
                                            //  password: ManageSalaryCubit.get(context)
                                             //     .passwordController
                                             //     .text.toString(),
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(0, 0),
                                              child: Text(
                                                'حفظ التعديلات',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                  ],
                                ),
                                Text(
                                  'حذف الحساب',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFFD92D20),
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ].divide(SizedBox(height: 5)),
                            ),
                          ]
                              .divide(SizedBox(height: 10.h))
                              .addToStart(SizedBox(height: 10.h)),
                        ),
                      ].addToStart(SizedBox(height: 20.h)),
                    ),
                  ].addToStart(SizedBox(height: 40.h)),
                ),
              ),
            ),
          ),

        );
      }
    );
  }
}



