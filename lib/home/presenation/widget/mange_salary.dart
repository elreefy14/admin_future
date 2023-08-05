import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../business_logic/Home/manage_salary_cubit.dart';

class ManageSalary extends StatelessWidget {
  const ManageSalary({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
       // ManageSalaryCubit.get(context).getUsers();
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

                                            'مكافأة',

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
                                      Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Container(
                                          width: MediaQuery.sizeOf(context).width *
                                              0.25,
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
                                      BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
                                        builder: (context, state) {
                                          return Container(
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
                                                                        width: 50,
                                                                        height: 50,
                                                                        fit: BoxFit.none,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  'دفع المرتب',
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
                                                                    children: [
                                                                      Expanded(
                                                                        child: Align(
                                                                          alignment: AlignmentDirectional(1, 0),
                                                                          child: Container(
                                                                            width: 100,
                                                                            child: TextFormField(
                                                                              controller: ManageSalaryCubit.get(context).salaryController,
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
                                                                                fontSize: 10,
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
                                                                          fontSize: 12,
                                                                        ),
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(width: 10))
                                                                        .addToEnd(SizedBox(width: 15)),
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
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        width: 130,
                                                                        height: 40,
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
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    InkWell(
                                                                      onTap: () async {
                                                                        print('uiiiiiiiiid \n\n');
                                                                        //     print(ManageSalaryCubit.get(context).users[index].uId);
                                                                        await ManageSalaryCubit.get(context).paySalary(
                                                                          userId:
                                                                          uid,
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        width: 130,
                                                                        height: 40,
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
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ].divide(SizedBox(width: 10)),
                                                                ),

                                                              ].divide(SizedBox(height: 35)).addToStart(SizedBox(height: 50)),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            )
                                                          ].divide(SizedBox(height: 0)),
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
                                          );
                                        },
                                      ),
                                      BlocConsumer<ManageSalaryCubit, ManageSalaryState>(
  listener: (context, state) {
    //PayBonusSuccessStateWithoutInternet
    if(state is PayBonusSuccessStateWithoutInternet){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(''
              'تم دفع المكافأة بنجاح'
           //   'wait for internet connection'
          //translate to arabic

          ),
          backgroundColor: Colors.green,
        ),
      );
      // Navigator.pop(context);
    }
    if(state is PayBonusSuccessState){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(''
              'تم دفع المكافأة بنجاح'
          ),
          backgroundColor: Colors.green,
        ),
      );
     // Navigator.pop(context);
    }
  },
  builder: (context, state) {
    return Container(
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
                                                                    width: 50,
                                                                    height: 50,
                                                                    fit: BoxFit.none,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              //'bonus'
                                                              'المكافأة',
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
                                                                children: [
                                                                  Expanded(
                                                                    child: Align(
                                                                      alignment: AlignmentDirectional(1, 0),
                                                                      child: Container(
                                                                        width: 100,
                                                                        child: TextFormField(
                                                                          controller: ManageSalaryCubit.get(context).salaryController,
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
                                                                            fontSize: 10,
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
                                                                    'المكافأة',
                                                                    style:
                                                                    FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      fontFamily: 'Readex Pro',
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(width: 10))
                                                                    .addToEnd(SizedBox(width: 15)),
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
                                                                    await ManageSalaryCubit.get(context).payBonus(
                                                                      uid,salary: ManageSalaryCubit.get(context).salaryController.text,context
                                                                    ).then((value) => Navigator.pop(context));
                                                                  },
                                                                  child: Container(
                                                                    width: 130,
                                                                    height: 40,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.blue,
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),
                                                                    child: Align(
                                                                      alignment: AlignmentDirectional(0, 0),
                                                                      child: Text(
                                                                     //pay bonus
                                                                        ' صرف مكافأة',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                          fontFamily: 'Readex Pro',
                                                                          color: Colors.white,
                                                                          fontSize: 12,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ].divide(SizedBox(width: 10)),
                                                            ),

                                                          ].divide(SizedBox(height: 35)).addToStart(SizedBox(height: 50)),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        )
                                                      ].divide(SizedBox(height: 0)),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Align(
                                            alignment: AlignmentDirectional(0, 0),
                                            child: Text(
                                             'مكافأة',
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
                                      );
  },
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
                                      Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Container(
                                          width: MediaQuery.sizeOf(context).width *
                                              0.25,
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

