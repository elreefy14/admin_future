import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:admin_future/home/presenation/widget/widget/custom_app_bar.dart';
import 'package:admin_future/home/presenation/widget/widget/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/routes_manager.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../registeration/data/userModel.dart';
import '../../business_logic/Home/manage_salary_cubit.dart';

class ManageSalary extends StatelessWidget {
  const ManageSalary({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
            TextEditingController _model = TextEditingController();

       // ManageSalaryCubit.get(context).getUsers();
        return BlocListener<ManageSalaryCubit, ManageSalaryState>(
          listener: (context, state) {
            if(state is PayBonusSuccessStateWithoutInternet ){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      ' سيتم دفع المكافأة عند الاتصال بالانترنت '
                    //   'wait for internet connection'
                    //translate to arabic
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else if(state is PayBonusSuccessState ){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم دفع المكافأة بنجاح'
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }else if(state is PayBonusErrorState ){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('حدث خطأ ما'
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }else if(state is PaySalarySuccessStateWithoutInternet ){
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
          appBar: CustomAppBar(text: 'ادارة المدربين'),
          // key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                             //   mainAxisSize: MainAxisSize.max,
                                children: [
                               
                                  //60
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  CustomSearchBar(
                                    isCoach: true,
                                  ),
                                     // Row(
                                     //  mainAxisAlignment: MainAxisAlignment.end,
                                     //   children: [
                                     //     Padding(
                                     //       padding: const EdgeInsets.all(10.0),
                                     //       child: Container(
                                     //
                                     //     decoration:ShapeDecoration(
                                     //     color: Color(0xFFFAFAFA),
                                     //     shape: RoundedRectangleBorder(
                                     //     side: BorderSide(width: 1, color: Color(0xFFB9B9B9)),
                                     //     borderRadius: BorderRadius.circular(2),
                                     //     ),
                                     //     ),
                                     //
                                     //                                     height: 40.h,
                                     //                                     width: 290.w,
                                     //                                     padding: EdgeInsets.symmetric(horizontal: 20.w),
                                     //                                     child: TextField(
                                     //                                       controller: _model,
                                     //                                       decoration: InputDecoration(
                                     //                                         hintText: 'name or phone number',
                                     //                                         suffixIcon: IconButton(
                                     //        icon: Icon(Icons.search),
                                     //        onPressed: () {
                                     //          String query = _model.text;
                                     //          //delete spaces in the beginning and end of the query
                                     //          query = query.trim();
                                     //          FirebaseFirestore.instance
                                     //                .collection('users')
                                     //                .where('name', isGreaterThanOrEqualTo: query)
                                     //                .where('name', isLessThan: query + 'z')
                                     //                .where('role', isEqualTo: 'coach')
                                     //                .get()
                                     //              .then((snapshot) {
                                     //            if (snapshot.docs.isNotEmpty) {
                                     //              List users = snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
                                     //              ManageSalaryCubit.get(context).updateListOfUsers(
                                     //                  users
                                     //              );
                                     //            } else {
                                     //              // If no results found for name search, search by phone number
                                     //              FirebaseFirestore.instance
                                     //                .collection('users')
                                     //                .where('phone', isGreaterThanOrEqualTo: query)
                                     //                .where('phone', isLessThan: query + 'z')
                                     //                .where('role', isEqualTo: 'coach')
                                     //                .get()
                                     //                  .then((snapshot) {
                                     //                List users = snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
                                     //                ManageSalaryCubit.get(context).updateListOfUsers(
                                     //                    users
                                     //                );
                                     //              });
                                     //            }
                                     //          });
                                     //
                                     //        },
                                     //                                         ),
                                     //                                       ),
                                     //                                     ),
                                     //                                   ),
                                     //     ),
                                     //   ],
                                     // ),
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
                                              0.2,
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
                                        child: InkWell(
                                          onTap: () async {
                                            final manageSalaryCubit = ManageSalaryCubit.get(context);
                                            manageSalaryCubit.initControllers(ManageSalaryCubit.get(context).coaches[index]);
                                            await Navigator.pushNamed(context,
                                                AppRoutes.editProfile,
                                                arguments: ManageSalaryCubit.get(context).coaches[index]
                                                as UserModel
                                            ) ;


                                          },
                                          child: Align(
                                            alignment: AlignmentDirectional(0, 0),
                                            child: InkWell(
                                              child: Text(
                                                '...المزيد ',
                                                textAlign: TextAlign.end,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.blue,
                                                  fontSize: 10.sp,
                                                  decoration:
                                                  TextDecoration.underline,
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
                                                String? uid =ManageSalaryCubit.get(context).coaches[index].uId;
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
                                                                        ).then((value) => Navigator.pop(context));
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

  },
  builder: (context, state) {
    return Container(
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
                                        child: InkWell(
                                          onTap: () async {
                                            String? uid =ManageSalaryCubit.get(context).coaches[index].uId;
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
                                           ManageSalaryCubit.get(context).coaches[index].totalSalary.toString(),
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
                                              0.2,
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
                                                  ManageSalaryCubit.get(context).coaches[index].fname??''} ${(ManageSalaryCubit.get(context).coaches[index].lname??'')}',
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
                                  itemCount:ManageSalaryCubit.get(context).coaches?.length,

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
InkWell(
                                          onTap: () async {
                                            await Navigator.pushNamed(context,
                                                AppRoutes.addCoach,
                                               arguments: {
                                              'isCoach':true,
                                               }
                                               // arguments: ManageSalaryCubit.get(context).users
                                            ) ;
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
                                              child: Text(
                                                'اضافة مدرب',
                                                textAlign: TextAlign.center,
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
                                        const SizedBox(height: 5),
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



        ),
);
      }
    );
  }
}


