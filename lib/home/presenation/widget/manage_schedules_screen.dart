import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../core/flutter_flow/flutter_flow_widgets.dart';
import '../../business_logic/Home/manage_salary_cubit.dart';

class ManageSchedulesScreen extends StatelessWidget {
  const ManageSchedulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
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
                    'ادارة المواعيد',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      fontSize: 24,
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Color(0x00FFFFFF),
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ),
                    child: Expanded (
                      child: BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
  builder: (context, state) {
    return ListView.separated(
                        separatorBuilder: (context, index) =>SizedBox(width: 10,),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: 85,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            ManageSalaryCubit.get(context).days?[index]??'',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFF4F4F4),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                        physics:BouncingScrollPhysics()
                        , shrinkWrap: true, itemCount: ManageSalaryCubit.get(context).days?.length??0,);
  },
),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        thickness: 2,
                        color: Color(0xFFF4F4F4),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.2,
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
                                    'انتهاء التدريب',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.2,
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
                                    'بدأ التدريب',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.25,
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
                                    'مكان التدريب',
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
                                  width:
                                  MediaQuery.sizeOf(context).width * 0.35,
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
                                      'اسم المدرب',
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
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),

                              itemBuilder: (context, index) => Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.2,
                                height: 50,
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
                                    ManageSalaryCubit.get(context).schedules?[index].endTime?.toDate().toString().substring(11,16)??'',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
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
                                width: MediaQuery.sizeOf(context).width * 0.2,
                                height: 50,
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
                                    ManageSalaryCubit.get(context).schedules?[index].startTime?.toDate().toString().substring(11,16)??'',
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.blue,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.25,
                                height: 50,
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
                                    ManageSalaryCubit.get(context).schedules?[index].branchId??"",
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
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    border: Border.all(
                                      color: Color(0xFFB4B4B4),
                                      width: 1,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: ManageSalaryCubit.get(context).schedules?[index].usersNames?.length ?? 0,
                                      itemBuilder: (BuildContext context, int innerIndex) {
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                                            child: AutoSizeText(
                                              '/${ManageSalaryCubit.get(context).schedules?[index].usersNames?[innerIndex] ?? ''}\n',
                                              minFontSize: 9,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                              itemCount: ManageSalaryCubit.get(context).schedules?.length??0);
  },
),

                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Color(0xFFF4F4F4),
                      ),
                    ].divide(SizedBox(height: 15)),
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'اضافة موعد ',
                    options: FFButtonOptions(
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Color(0xFF198CE3),
                      textStyle:
                      FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ].divide(SizedBox(height: 30)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

