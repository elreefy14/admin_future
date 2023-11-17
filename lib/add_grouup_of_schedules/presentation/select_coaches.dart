import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../../core/constants/routes_manager.dart';
import '../../core/flutter_flow/flutter_flow_theme.dart';
import '../../home/business_logic/Home/manage_salary_cubit.dart';
import '../../registeration/data/userModel.dart';
import 'onboarding_screen.dart';
class ShowCoachesInDialog extends StatelessWidget {
  bool? isCoachInfoList;
  final List<UserModel> selectedUsers;
  final Function(List<UserModel>) onSelectedUsersChanged;
  final bool isCoach;

   ShowCoachesInDialog({
    Key? key,
     this.isCoachInfoList,
    required this.selectedUsers,
    required this.onSelectedUsersChanged,
    required this.isCoach,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AddGroupCubit, AddGroupState>(
      builder: (context, state) {
        final logger = Logger();

        final addGroupCubit = context.read<AddGroupCubit>();
        final query = addGroupCubit.usersQuery;
       bool isSearch = addGroupCubit.isSearch;


        return
          //if isCoachInfoList is true then dont show parent diakog 
          //instead show the child column of the dialog
          //else show the parent dialog

        isCoachInfoList ??false ?
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isCoachInfoList ?? false ?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w
                  ,bottom: 15.h),
                    decoration: ShapeDecoration(
                      color: Color(0xFFFAFAFA),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFB9B9B9)),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    height: 40.h,
                    width: 290.w,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child:TextField(
                      onTap: //_showClearButton = false; /
                          () {
                      //  addGroupCubit.isSearch = true;
                     //make it using update funvtion
                            addGroupCubit.updateIsSearch(true);
                      },
                      //arabic
                      textAlign: TextAlign.right,
                      controller: addGroupCubit.searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                      decoration: InputDecoration(
                        hintText: 'Search ',
                        //trensform to arabic
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                        ),
                        prefixIcon:
                       isSearch? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            addGroupCubit.searchController.clear();
                            //query ==null
                     //  addGroupCubit.usersQuery =null;
                            //make it using update funvtion
                            addGroupCubit.updateUsersQuery(null);
                            //update isSearch
                            addGroupCubit.updateIsSearch(false);
                          }
                        ):null,
                      ),
                    )
                ),
              ],
            ) :
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:TextField(
                controller: addGroupCubit.searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                decoration: InputDecoration(
                  hintText: 'Search by name or phone number',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                  ),
                ),
              ),
            ),
            isCoachInfoList??false?
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
            ) :Container(),

            Expanded(
              child: FirestoreListView(
                shrinkWrap: true,
                cacheExtent: 500,
                pageSize: 2,
                query: query ??FirebaseFirestore.instance.collection('users').where(
                    'role', isEqualTo: isCoachInfoList??false ? 'coach' : 'user'),
                itemBuilder: (context, document) {
                  final data = document.data() as Map<String, dynamic>;
                  final user = UserModel.fromJson(data);
                  return isCoachInfoList ??
                      false ?   Row(
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
                            //manageSalaryCubit.initControllers(ManageSalaryCubit.get(context).coaches[index]);
                            manageSalaryCubit.initControllers(user);
                            await Navigator.pushNamed(context,
                                AppRoutes.editProfile,
                                arguments: user
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
                                //      String? uid =ManageSalaryCubit.get(context).coaches[index].uId;
                                String? uid =user.uId;
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
                                //String? uid =ManageSalaryCubit.get(context).coaches[index].uId;
                                String? uid =user.uId;
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
                            //  ManageSalaryCubit.get(context).coaches[index].totalSalary.toString(),
                            user.totalSalary.toString(),



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
                              // ManageSalaryCubit.get(context).coaches[index].fname??''} ${(ManageSalaryCubit.get(context).coaches[index].lname??'')}',
                                  user.name??''} ${(user.lname??'')}',
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
                  ):
                  ListTile(
                    title: Text(user.name ?? ''),
                    subtitle: Text(user.phone ?? ''),



                    trailing: Checkbox(
                      value: isCoach
                          ? state.selectedCoaches.map((user) => user.uId).contains(user.uId)
                          : state.selectedUsers.map((user) => user.uId).contains(user.uId),
                      onChanged: (value) {
                        logger.d('value is $value');
                        if (value!) {
                          if (isCoach) {
                            addGroupCubit.selectCoach(user);
                          } else {
                            addGroupCubit.selectUser(user);
                          }
                        } else if (!value) {
                          if (isCoach) {
                            logger.d('user id is ${user.uId}');
                            context
                                .read<AddGroupCubit>()
                                .deselectCoach(user);
                          } else {
                            context
                                .read<AddGroupCubit>()
                                .deselectUser(user);
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     TextButton(
            //       onPressed: () => Navigator.of(context).pop(),
            //       child: Text('Cancel'),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         //    onSelectedUsersChanged(addGroupCubit.selectedUsers);
            //
            //         Navigator.of(context).pop();
            //       },
            //       child: Text('Save'),
            //     ),
            //   ],
            // ),
            isCoachInfoList ??false ?
            Container():
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    //    onSelectedUsersChanged(addGroupCubit.selectedUsers);

                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        )
            :
          Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                isCoachInfoList ?? false ?
                Container(
            decoration: ShapeDecoration(
              color: Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFB9B9B9)),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            height: 40.h,
            width: 290.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child:TextField(
              //arasbic
              textAlign: TextAlign.right,
              onTap: //_showClearButton = false; /
                  () {
                //  addGroupCubit.isSearch = true;
                //make it using update funvtion
                addGroupCubit.updateIsSearch(true);
              },
                                          controller: addGroupCubit.searchController,
                                          textInputAction: TextInputAction.search,
                                          onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                                          decoration: InputDecoration(
                                            hintText: 'Search',
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.search),
                                              onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                                            ),
                                            prefixIcon:
                                            isSearch? IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () {
                                                  addGroupCubit.searchController.clear();
                                                  //query ==null
                                                  //  addGroupCubit.usersQuery =null;
                                                  //make it using update funvtion
                                                  addGroupCubit.updateUsersQuery(null);
                                                  //update isSearch
                                                  addGroupCubit.updateIsSearch(false);
                                                }
                                            ):null,
                                          ),

                                        )
          )
                                        :
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:TextField(
                  onTap: () {
                    addGroupCubit.updateIsSearch(true);
                  },
                                          controller: addGroupCubit.searchController,
                                          textInputAction: TextInputAction.search,
                                          onSubmitted: (_) => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                                          decoration: InputDecoration(

                                            hintText: 'Search ',
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.search),
                                              onPressed: () => addGroupCubit.onSearchSubmitted(addGroupCubit.searchController.text.trim(),isCoach),
                                            ),
                                            prefixIcon:
                                              isSearch ? IconButton(
                                                  icon: Icon(Icons.close),
                                                  onPressed: () {
                                                    addGroupCubit.searchController.clear();
                                                    //query ==null
                                                    //  addGroupCubit.usersQuery =null;
                                                    //make it using update funvtion
                                                    addGroupCubit.updateUsersQuery(null);
                                                    //update isSearch
                                                    addGroupCubit.updateIsSearch(false);
                                                  }
                                              ):null,

                                          ),
                                        ),
              ),
              isCoachInfoList??false?
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
                                      )
              :Container(),
              
              Expanded(
                child: FirestoreListView(
                  shrinkWrap: true,
                  cacheExtent: 500,
                  pageSize: 5,
                  query: query ??FirebaseFirestore.instance.collection('users') ,
                  itemBuilder: (context, document) {
                    final data = document.data() as Map<String, dynamic>;
                    final user = UserModel.fromJson(data);
                    return isCoachInfoList ??
                        false ?   Row(
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
                              //manageSalaryCubit.initControllers(ManageSalaryCubit.get(context).coaches[index]);
                              manageSalaryCubit.initControllers(user);
                              await Navigator.pushNamed(context,
                                  AppRoutes.editProfile,
                                  arguments: user
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
                            //      String? uid =ManageSalaryCubit.get(context).coaches[index].uId;
                              String? uid =user.uId;
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
                                  //String? uid =ManageSalaryCubit.get(context).coaches[index].uId;
                                  String? uid =user.uId;
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
                            //  ManageSalaryCubit.get(context).coaches[index].totalSalary.toString(),
                              user.totalSalary.toString(),

                                       
                              
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
                                   // ManageSalaryCubit.get(context).coaches[index].fname??''} ${(ManageSalaryCubit.get(context).coaches[index].lname??'')}',
                                  user.name??''} ${(user.lname??'')}',
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
                    ):
                        ListTile(
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.phone ?? ''),



                      trailing: Checkbox(
                        value: isCoach
                            ? state.selectedCoaches.map((user) => user.uId).contains(user.uId)
                            : state.selectedUsers.map((user) => user.uId).contains(user.uId),
                        onChanged: (value) {
                          logger.d('value is $value');
                          if (value!) {
                            if (isCoach) {
                              addGroupCubit.selectCoach(user);
                            } else {
                              addGroupCubit.selectUser(user);
                            }
                          } else if (!value) {
                            if (isCoach) {
                              logger.d('user id is ${user.uId}');
                              context
                                  .read<AddGroupCubit>()
                                  .deselectCoach(user);
                            } else {
                              context
                                  .read<AddGroupCubit>()
                                  .deselectUser(user);
                            }
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     TextButton(
              //       onPressed: () => Navigator.of(context).pop(),
              //       child: Text('Cancel'),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //     //    onSelectedUsersChanged(addGroupCubit.selectedUsers);
              //
              //         Navigator.of(context).pop();
              //       },
              //       child: Text('Save'),
              //     ),
              //   ],
              // ),
              isCoachInfoList ??false ?
              Container():
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      //    onSelectedUsersChanged(addGroupCubit.selectedUsers);

                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../registeration/data/userModel.dart';
//
// class ShowCoachesInDialog extends StatefulWidget {
//   final List<UserModel> selectedUsers;
//   final Function(List<UserModel>) onSelectedUsersChanged;
//   final isCoach ;
//
//   const ShowCoachesInDialog({
//     Key? key,
//     required this.selectedUsers,
//     required this.onSelectedUsersChanged, required this.isCoach,
//   }) : super(key: key);
//
//   @override
//   _ShowCoachesInDialogState createState() => _ShowCoachesInDialogState();
// }
//
// class _ShowCoachesInDialogState extends State<ShowCoachesInDialog> {
//   late List<UserModel> _selectedUsers;
//   late List<String> _selectedUsersUids;
//   late TextEditingController _searchController;
//   late Query<Map<String, dynamic>> _query;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedUsers = widget.selectedUsers;
//     _selectedUsersUids = _selectedUsers.map((user) => user.uId!).toList();
//     _searchController = TextEditingController();
//     if(widget.isCoach) {
//       _query = FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'coach');
//     } else {
//       _query = FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'user');
//     }
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _onSearchSubmitted(String value) async {
//    late Query newQuery;
//     if(widget.isCoach)
//        newQuery = FirebaseFirestore.instance
//           .collection('users')
// .orderBy('name')
// .startAt([value])
// .endAt([value + '\uf8ff'])
//           .where('role', isEqualTo: 'coach')
//           .limit(100);
//     else
//      newQuery = FirebaseFirestore.instance
//        .collection('users')
// .orderBy('name')
// .startAt([value])
// .endAt([value + '\uf8ff'])
//          .where('role', isEqualTo: 'user')
//         .limit(100);
//
//     QuerySnapshot querySnapshot =
//         await newQuery.get(GetOptions(source: Source.serverAndCache));
//     var numberOfQuery = querySnapshot.docs.length;
//     print('number of query is $numberOfQuery');
//     print(numberOfQuery);
//
//     if (numberOfQuery == 0) {
//       if(widget.isCoach)
//         newQuery = FirebaseFirestore.instance
//             .collection('users')
//             .where('phone', isGreaterThanOrEqualTo: value)
//             .where('phone', isLessThan: value + 'z')
//             //order by name
//             .orderBy('phone', descending: false)
//             .where('role', isEqualTo: 'coach')
//             .limit(100);
//       else
//         newQuery = FirebaseFirestore.instance
//             .collection('users')
//             .where('phone', isGreaterThanOrEqualTo: value)
//             .where('phone', isLessThan: value + 'z')
//             //order by name
//             .orderBy('phone', descending: false)
//             .where('role', isEqualTo: 'user')
//             .limit(100);
//     }
//
//     setState(() {
//       _query = newQuery as Query<Map<String, dynamic>>;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               //i want when i click on search icon the keyboard will be closed
//               textInputAction: TextInputAction.search,
//               onSubmitted: (value) => _onSearchSubmitted(value.trim()),
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search by name or phone number',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () =>
//                       _onSearchSubmitted(_searchController.text.trim()),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: FirestoreListView(
//               shrinkWrap: true,
//               cacheExtent: 300,
//               pageSize: 5,
//               query: _query,
//               itemBuilder: (context, document) {
//                 final data = document.data() as Map<String, dynamic>;
//                 final user = UserModel.fromJson(data);
//                 return ListTile(
//                   title: Text(user.name ?? ''),
//                   subtitle: Text(user.phone ?? ''),
//                   trailing: Checkbox(
//                     value: _selectedUsersUids.contains(user.uId),
//                     onChanged: (value) {
//                       setState(() {
//                         if (value!) {
//                           _selectedUsersUids.add(user.uId!);
//                           _selectedUsers.add(user);
//                         } else {
//                           _selectedUsersUids.remove(user.uId!);
//                           _selectedUsers.remove(user);
//                         }
//                         widget.onSelectedUsersChanged(_selectedUsers);
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   widget.onSelectedUsersChanged(_selectedUsers);
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Save'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
