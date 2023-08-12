import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/data/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../core/flutter_flow/flutter_flow_widgets.dart';

class EditUsers extends StatelessWidget {
  //const ({super.key});
final user;

  const EditUsers({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    //    //EditUsers
    //     //     await Navigator.pushNamed(context,
    //     //                                  AppRoutes.editProfile,
    //     //                                  arguments: ManageSalaryCubit.get(context).users[index]);
    //        case AppRoutes.editProfile:
    //          return MaterialPageRoute(builder: (_) => EditUsers(
    //             user: args,
    //          ));
    //     }

    final firstNameController = TextEditingController(
      text: user.fname
    );
    final lastNameController = TextEditingController(
      text: user.lname
    );
    final phoneController = TextEditingController(
      text: user.phone
    );
    final passwordController = TextEditingController(

    );
    //salary per hour make intial value = user.hourlyRate
    final salaryController = TextEditingController(
      text: user.hourlyRate.toString()
    );
    return Scaffold(
     // key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(

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
                                      controller: firstNameController,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
                                        ),
                                        hintText: 'اكتب رقم',
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
                                      keyboardType: TextInputType.number,
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
                                      controller: lastNameController,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
                                        ),
                                        hintText: 'اكتب رقم',
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
                                      keyboardType: TextInputType.number,
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
                                      controller: phoneController,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
                                        ),
                                        hintText: 'اكتب رقم',
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
                                      keyboardType: TextInputType.number,
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
                            'كلمة المرور',
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
                                      controller: passwordController,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
                                        ),
                                        hintText: 'اكتب رقم',
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
                                      keyboardType: TextInputType.number,
                                      cursorColor: Color(0xFF333333),


                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                            .divide(SizedBox(height: 5.h))
                            .addToEnd(SizedBox(height: 0.h  ) ),
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
                                      Container(
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
                                                controller:
                                               salaryController,
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
                                                  hintText: 'اكتب رقم',
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
                                                TextInputType.number,
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
                              // Container(
                              //   width: 150,
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //     color: FlutterFlowTheme.of(context)
                              //         .secondaryBackground,
                              //   ),
                              //   child:
                                // FFButtonWidget(
                                //   onPressed: () {
                                //     print('Button pressed ...');
                                //   },
                                //   text: 'حفظ التعديلات',
                                //   options: FFButtonOptions(
                                //     height: 50,
                                //     padding: EdgeInsetsDirectional.fromSTEB(
                                //         24, 0, 24, 0),
                                //     iconPadding: EdgeInsetsDirectional.fromSTEB(
                                //         0, 0, 0, 0),
                                //     color: Color(0xFF198CE3),
                                //     textStyle: FlutterFlowTheme.of(context)
                                //         .titleSmall
                                //         .override(
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
                              //),
                              Container(
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

    );
  }
}
