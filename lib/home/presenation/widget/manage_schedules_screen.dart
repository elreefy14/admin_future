// 
//
//use flutter_screenutil to make above ManageSchedulesScreen responsive
//instead of height: 160 ,use height: 160.h,
//instead of width: 155, use width: 155.w,
//instead of SizedBox(height: 20), use SizedBox(height: 20.h),
//instead of SizedBox(width: 20), use SizedBox(width: 20.w),
//instead of fontSize: 16, use fontSize: 16.sp,
//instead of fontSize: 18, use fontSize: 18.sp, and so on for all sizes in the app
import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:admin_future/home/presenation/widget/widget/custom_app_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import '../../../core/constants/routes_manager.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../core/flutter_flow/flutter_flow_widgets.dart';
import '../../business_logic/Home/manage_salary_cubit.dart';
class ManageSchedulesScreen extends StatefulWidget {
  @override
  _ManageSchedulesScreenState createState() => _ManageSchedulesScreenState();
}

class _ManageSchedulesScreenState extends State<ManageSchedulesScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    //ManageSalaryCubit.get(context).isCoach = false;
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/back.png',
              width: 50,
              height: 50,
              fit: BoxFit.none,
            ),
          ),
        ),
        actions: [
          BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
  builder: (context, state) {
    return SizedBox(
      //height: 50.h,
      width: 200.w,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: () {
              ManageSalaryCubit.get(context).changeIsCoach(true);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:ManageSalaryCubit.get(context).isCoach 
                     ? Colors.blue : Colors.grey,
                    width: ManageSalaryCubit.get(context).isCoach  ? 2.0 : 0.0,
                  ),
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.only( 
                   top: 39.0.h,
            right: 12.w,),
                child: Text(
                  'المدربين',
                  style: TextStyle(
                    color: ManageSalaryCubit.get(context).isCoach  ? Colors.blue : Colors.grey,
                    fontSize: 18,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 0.07,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ManageSalaryCubit.get(context).changeIsCoach(false);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ManageSalaryCubit.get(context).isCoach  ? Colors.grey : Colors.blue,
                    width: ManageSalaryCubit.get(context).isCoach  ? 0.0 : 2.0,
                  ),
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.only( 
                   top: 39.0.h,
           // right: 12.w,
            ),
                child: Text(
                  'المتدربين',
                  style: TextStyle(
                    color:ManageSalaryCubit.get(context).isCoach ? Colors.grey : Colors.blue,
                    fontSize: 18,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 0.07,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  },
),
        ],
      ),
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

                      //make 2 tabs for users and coaches and use cubit to change the selected tab index and change the color of the selected tab to blue and the other tab to grey and use the selected tab index to show the list of users or coaches in the listview builder below
//                      Container(
//   padding: const EdgeInsets.all(8.0),
//   color: Colors.blue,
//   width: 200,
//   height: 300,
//   child: ContainedTabBarView(
//     tabs: [
//       Text('First'),
//       Text('Second'),
//     ],
//     views: [
//       Container(color: Colors.red),
//       Container(color: Colors.green)
//     ],
//     onChange: (index) { print(index);
//       //change isCoach attribute in cubit to false  if index =0
//     //  ManageSalaryCubit.get(context).changeIsCoach(false);
//     },
//   ),
// ),
                                    ],
                                  ),


//52
SizedBox(height: 5.h),
                 Text(
    'ادارة المواعيد',
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Color(0xFF333333),
        fontSize: 32,
        fontFamily: 'Montserrat-Arabic',
        fontWeight: FontWeight.w400,
        height: 0.03,
    ),
),
//65
SizedBox(height: 0.h),
                  ScheduleDaysList(),
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
                          BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
                            builder: (context, state) {


                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index)
{
  List<String?>? usersList = ManageSalaryCubit.get(context).schedules?[index].usersList ?? [];
    List<String?>? usersIds = ManageSalaryCubit.get(context).schedules?[index].userIds ?? [];

  String scheduleId = ManageSalaryCubit.get(context).schedules?[index].scheduleId ?? '';
  String day = ManageSalaryCubit.get(context).schedules?[index].date ?? '';
  Timestamp? statrTime = (ManageSalaryCubit.get(context).schedules?[index].startTime ?? '') as Timestamp?;
  Timestamp? endTime = (ManageSalaryCubit.get(context).schedules?[index].endTime ?? '') as Timestamp?;

                                  return  Column(
                                      children: [
                                      GestureDetector( // updated
                                                                                                                          // onLongPress: () {
                                                                                                                          //   // setState(() {
                                                                                                                          //   //   isGrey = true;
                                                                                                                          //   // });
                                                                                                                          //   //use cubit
                                                                                                                          //   ManageSalaryCubit.get(context).changeIsGrey(true);
                                                                                                                          // },
                                                                                                                          // onTap: () {
                                                                                                                          //   // setState(() {
                                                                                                                          //   //   isGrey = false;
                                                                                                                          //   // });
                                                                                                                          //   //use cubit
                                                                                                                          //   ManageSalaryCubit.get(context).changeIsGrey(false);
                                                                                                                          //
                                                                                                                          // },
                                                                                                                          child: Container( // updated
                                                                                                                    //        decoration: BoxDecoration(
                                                                                                                            //   color: ManageSalaryCubit.get(context).isGrey == true
                                                                                                                            //       ? Colors.white : Colors.white, // updated
                                                                                                                            //   borderRadius: BorderRadius.circular(10),
                                                                                                                            //   boxShadow: [
                                                                                                                            //     // BoxShadow(
                                                                                                                            //     //   color: Colors.grey.withOpacity(0.5),
                                                                                                                            //     //   spreadRadius: 2,
                                                                                                                            //     //   blurRadius: 5,
                                                                                                                            //     //   offset: Offset(0, 3),
                                                                                                                            //     // ),
                                                                                                                            //   ],
                                                                                                                            // ),

                                            child: ExpansionTile(

                                              leading: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  FFButtonWidget(
                                                    onPressed: () {
                                                      print('Delete button pressed ...');
                                                     ManageSalaryCubit.get(context).deleteSchedule(
                                          usersIds: usersIds?.cast<String>() ?? [],
                                          scheduleId: scheduleId,
                                          day: day,
                                          );

                                                    },
                                                    text: 'حذف',
                                                    options: FFButtonOptions(
                                                      width: 50.w,
                                                      height: 40.h,
                                                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                      color: Colors.red,
                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Readex Pro',
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                      elevation: 3,
                                                      borderSide: BorderSide(
                                                        color: Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  FFButtonWidget(
                                                    onPressed: () {

                                                      ManageAttendenceCubit.get(context).selectedCoaches = usersList?.cast<String>() ?? [];
                                                      ManageAttendenceCubit.get(context).selectedDays = [day];
                                                      ManageAttendenceCubit.get(context).startTime = statrTime;
                                                      ManageAttendenceCubit.get(context).endTime = endTime;
                                                      //selectedBranch
                                                      ManageAttendenceCubit.get(context).selectedBranch = ManageSalaryCubit.get(context).schedules?[index].branchId ?? '';
                                                      //selectedBranch
                                                      //print('${ManageSalaryCubit.get(context).schedules?[index].branchId}');
                                                      ManageAttendenceCubit.get(context).getAdminData();
                                                      Navigator.pushNamed(
                                                context,
                                                AppRoutes.addSchedule,
                                                arguments: {
                                                  'toggle': false,
                                                  'startTime': statrTime,
                                                  'endTime': endTime,
                                                  'date': day,
                                                  'usersList': usersList,
                                                  'scheduleId': scheduleId,
                                                  'usersIds': usersIds,
                                                },
                                              );




                                                    },
                                                    text: 'تعديل',
                                                    options: FFButtonOptions(
                                                      width: 50.w,
                                                      height: 40.h,
                                                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                      color: Colors.blue,
                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Readex Pro',
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                      elevation: 3,
                                                      borderSide: BorderSide(
                                                        color: Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),


                                                ],
                                              ),
                                              title: BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
  builder: (context, state) {
    return Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: 200,
                                                      child: AutoSizeText(
                                                        '${DateFormat('hh:mm a').format(ManageSalaryCubit.get(context).schedules![index].endTime!.toDate())} '
                                                        '<---'
                                                        '${DateFormat('hh:mm a').format(ManageSalaryCubit.get(context).schedules![index].startTime!.toDate())} '
                                                        '-'
                                                        '${ManageSalaryCubit.get(context).schedules?[index].branchId}',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Readex Pro',
                                                         // fontSize: ,
                                                        ),
                                                        minFontSize: 6,
                                                        maxFontSize: 19,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 5)),
                                              );
  },
),
                                              children: [

                                             if(ManageSalaryCubit.get(context).isCoach ==true)

                                        FirestoreListView<Map<String, dynamic>>(
                                            pageSize: 5,
                                            shrinkWrap: true,
                                            loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
                                            cacheExtent: 100,
                                            query:FirebaseFirestore.instance
                                                .collection('admins')
                                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                                 .collection('schedules')
                                                .doc(ManageSalaryCubit.get(context).days?[
                                                  //selectedDayIndex
                                                  ManageSalaryCubit.get(context).selectedDayIndex
                                                ].name ?? '')
                                                .collection('schedules')
                                                .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                .collection('users')
                                                .where('role', isEqualTo: 'coach')

                                          ,
                                            itemBuilder: (context, snapshot) {
                                                 DateTime nearestDay = ManageSalaryCubit.get(context).schedules?[index].nearestDay?.toDate() ?? DateTime.now();
                                                                              // Calculate the difference between the nearest day and today's date
                                                                              int differenceInDays =nearestDay.difference( DateTime.now()).inDays;
                                                                               bool? isTimeExceed;  
                                                         // Duration difference = DateTime.now().difference(nearestDay);
                                                   Map<String, dynamic> user = snapshot.data();
                                                       if (differenceInDays > 5) {
                                                              FirebaseFirestore.instance
                                                                  .collection('admins')
                                                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                  .collection('schedules')
                                                                  .doc(ManageSalaryCubit.get(context).days?[
                                                                      ManageSalaryCubit.get(context).selectedDayIndex
                                                                  ].name ?? '')
                                                                  .collection('schedules')
                                                                  .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                                  .collection('users')
                                                                  .where('finished', isEqualTo: true)
                                                                  .where('role', isEqualTo: 'coach')
                                                                  .get()
                                                                  .then((querySnapshot) {

                                                                    print('querySnapshot.docs.length ${querySnapshot.docs.length}');
                                                                    querySnapshot.docs.forEach((doc) {
                                                                      doc.reference.update({'finished': false});
                                                                    });
                                                                  });
                                                                  isTimeExceed = false;
                                                           }
                                              user = snapshot.data();
                                              return //Text('Schedule id is ${user['name']}');
                                              Column(
                                                    children: [
                                                    //  for (int i = 0; i < user.length; i++)
                                                        CheckboxListTile(
                                                          title: Text(user['name']),
                                                          value: user['finished'],
                                                          onChanged: (value) async {
                                                             FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                            // DocumentSnapshot scheduleSnapshot = await firestore
                                                            //     .collection('admins')
                                                            //     .doc(FirebaseAuth.instance.currentUser?.uid)
                                                            //     .collection('schedules')
                                                            //     .doc(ManageSalaryCubit.get(context).days?[index].name ?? '')
                                                            //     .collection('schedules')
                                                            //     .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                            //     .get();
                                                            int startTime = ManageSalaryCubit.get(context).schedules?[index].startTime?.toDate().hour ?? 0;
                                                            int endTime = ManageSalaryCubit.get(context).schedules?[index].endTime?.toDate().hour ?? 0;
                                                            int totalHours = endTime - startTime;
                                                            totalHours += Duration(minutes: 2).inHours;

                                                            if (value == true) {
                                                              firestore
                                                                  .collection('admins')
                                                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                  .collection('schedules')
                                                                  .doc(ManageSalaryCubit.get(context).days?[
                                                                    //selectedDayIndex
                                                                    ManageSalaryCubit.get(context).selectedDayIndex
                                                                  ].name ?? '')
                                                                  .collection('schedules')
                                                                  .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                                  .collection('users')
                                                                  .doc(user['uid'])
                                                                  .update({'finished': value,});
                                                                  firestore.collection('users').doc(user['uid']).update({'totalHours': FieldValue.increment(totalHours)});
                                                           //send notification to users model contain 2 fields message and timestamp
                                                           firestore.collection('users').doc(user['uid']).collection('notifications').add({
                                                             'message': 'تم اضافة ${totalHours} ساعات لحسابك',
                                                             'timestamp': Timestamp.now(),
                                                            });
                                                            } else {
                                                              firestore
                                                                  .collection('admins')
                                                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                  .collection('schedules')
                                                                  .doc(ManageSalaryCubit.get(context).days?[
                                                                    //selectedDayIndex
                                                                    ManageSalaryCubit.get(context).selectedDayIndex
                                                                  ].name ?? '')
                                                                  .collection('schedules')
                                                                  .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                                  .collection('users')
                                                                  .doc(user['uid'])
                                                                  .update({'finished': value,});
                                                                  firestore.collection('users').doc(user['uid']).update({'totalHours': FieldValue.increment(-totalHours)});
                                                            //send notification to users model contain 2 fields message and timestamp
                                                            firestore.collection('users').doc(user['uid']).collection('notifications').add({
                                                             'message': 'تم خصم ${totalHours} ساعات من حسابك',
                                                             'timestamp': Timestamp.now(),
                                                            });
                                                            }
                                                          },
                                                        ),
                                                    ],
                                                  );
                                            },
                                          )else

                                               FirestoreListView<Map<String, dynamic>>(
                                                 pageSize: 5,
                                                 shrinkWrap: true,
                                                 loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
                                                 cacheExtent: 100,
                                                 query:FirebaseFirestore.instance
                                                     .collection('admins')
                                                     .doc(FirebaseAuth.instance.currentUser?.uid)
                                                     .collection('schedules')
                                                     .doc(ManageSalaryCubit.get(context).days?[
                                                 //selectedDayIndex
                                                 ManageSalaryCubit.get(context).selectedDayIndex
                                                 ].name ?? '')
                                                     .collection('schedules')
                                                     .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                     .collection('users')
                                                     .where('role', isEqualTo: 'user')

                                                 ,
                                                 itemBuilder: (context, snapshot) {

                                                                           //nearestDay 2023-10-11 15:35:13.858087
                                                                           //differenceInDays 0
                                                                           //DateTime.now()  DateTime.now() 2023-10-11 15:36:59.950
                                                                           print('DateTime.now() ${DateTime.now()}');
                                                                              DateTime nearestDay = ManageSalaryCubit.get(context).schedules?[index].nearestDay?.toDate() ?? DateTime.now();
                                                                              print('nearestDay $nearestDay');
                                                                              // Calculate the difference between the nearest day and today's date
                                                                              int differenceInDays =nearestDay.difference( DateTime.now()).inDays;
                                                                              print('differenceInDays $differenceInDays');
                                                                               bool? isTimeExceed;  
                                                         // Duration difference = DateTime.now().difference(nearestDay);
                                                   Map<String, dynamic> user = snapshot.data();
                                                       if (differenceInDays > 5) {
                                                              FirebaseFirestore.instance
                                                                  .collection('admins')
                                                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                  .collection('schedules')
                                                                  .doc(ManageSalaryCubit.get(context).days?[
                                                                      ManageSalaryCubit.get(context).selectedDayIndex
                                                                  ].name ?? '')
                                                                  .collection('schedules')
                                                                  .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                                  .collection('users')
                                                                  .where('finished', isEqualTo: true)
                                                                  .where('role', isEqualTo: 'user')
                                                                  .get()
                                                                  .then((querySnapshot) {

                                                                    print('querySnapshot.docs.length ${querySnapshot.docs.length}');
                                                                    querySnapshot.docs.forEach((doc) {
                                                                      doc.reference.update({'finished': false});
                                                                    });
                                                                  });
                                                                  isTimeExceed = false;
                                                           }
                                                   return //Text('Schedule id is ${user['name']}');
                                                     Column(
                                                       children: [
                                                    
                                                         CheckboxListTile(
                                                           title: Text(user['name']),
                                                           value: isTimeExceed?? user['finished'],
                                                           onChanged: (value) async {
                                                             FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                             // DocumentSnapshot scheduleSnapshot = await firestore
                                                             //     .collection('admins')
                                                             //     .doc(FirebaseAuth.instance.currentUser?.uid)
                                                             //     .collection('schedules')
                                                             //     .doc(ManageSalaryCubit.get(context).days?[index].name ?? '')
                                                             //     .collection('schedules')
                                                             //     .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                             //     .get();
                                                             int startTime = ManageSalaryCubit.get(context).schedules?[index].startTime?.toDate().hour ?? 0;
                                                             int endTime = ManageSalaryCubit.get(context).schedules?[index].endTime?.toDate().hour ?? 0;
                                                             int totalHours = endTime - startTime;
                                                             totalHours += Duration(minutes: 2).inHours;

                                                             if (value == true) {
                                                               firestore
                                                                   .collection('admins')
                                                                   .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                   .collection('schedules')
                                                                   .doc(ManageSalaryCubit.get(context).days?[
                                                               //selectedDayIndex
                                                               ManageSalaryCubit.get(context).selectedDayIndex
                                                               ].name ?? '')
                                                                   .collection('schedules')
                                                                   .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                                   .collection('users')
                                                                   .doc(user['uid'])
                                                                   .update({'finished': value,});
                                                               firestore.collection('users').doc(user['uid']).update({'totalHours': FieldValue.increment(totalHours)});
                                                               //send notification to users model contain 2 fields message and timestamp
                                                               firestore.collection('users').doc(user['uid']).collection('notifications').add({
                                                                 'message': 'تم اضافة ${totalHours} ساعات لحسابك',
                                                                 'timestamp': Timestamp.now(),
                                                               });
                                                             } else {
                                                               firestore
                                                                   .collection('admins')
                                                                   .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                   .collection('schedules')
                                                                   .doc(ManageSalaryCubit.get(context).days?[
                                                               //selectedDayIndex
                                                               ManageSalaryCubit.get(context).selectedDayIndex
                                                               ].name ?? '')
                                                                   .collection('schedules')
                                                                   .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                                   .collection('users')
                                                                   .doc(user['uid'])
                                                                   .update({'finished': value,});
                                                               firestore.collection('users').doc(user['uid']).update({'totalHours': FieldValue.increment(-totalHours)});
                                                               //send notification to users model contain 2 fields message and timestamp
                                                               firestore.collection('users').doc(user['uid']).collection('notifications').add({
                                                                 'message': 'تم خصم ${totalHours} ساعات من حسابك',
                                                                 'timestamp': Timestamp.now(),
                                                               });
                                                             }
                                                           },
                                                         ),
                                                       ],
                                                     );
                                                 },
                                               )

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ) ;},
                                itemCount: ManageSalaryCubit
                                    .get(context)
                                    .schedules
                                    ?.length ?? 0,
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Color(0xFFF4F4F4),
                      ),
                    ],
                  ),

                  FFButtonWidget(
                    onPressed: () {
                      ManageAttendenceCubit.get(context).selectedCoaches = [];
                      ManageAttendenceCubit.get(context).selectedDays = [];
                      ManageAttendenceCubit.get(context).startTime = Timestamp.now();
                      ManageAttendenceCubit.get(context).endTime = Timestamp.now();
                      ManageAttendenceCubit.get(context).getAdminData();
                     //AddSchedule
                      Navigator.pushNamed(
                        context,
                        AppRoutes.addSchedule,
                        arguments: {
                          'toggle': true,
                          'startTime': Timestamp.now(),
                          'endTime': Timestamp.now(),
                        },
                      );
                    },
                    text: 'اضافة موعد ',
                    options: FFButtonOptions(
                      height: 40.h,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Color(0xFF198CE3),
                      textStyle:
                      FlutterFlowTheme
                          .of(context)
                          .titleSmall
                          .override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 12.sp,
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

                  class ScheduleDaysList extends StatelessWidget {
                    const ScheduleDaysList({Key? key}) : super(key: key);

                    @override
                    Widget build(BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 65.h,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(0, 195, 162, 162),
                          border: Border.all(
                            color: Colors.blue,
                          ),
                        ),
                        child: Expanded(
                          child: BlocBuilder<ManageSalaryCubit, ManageSalaryState>(
                            builder: (context, state) {
                              return ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 10.w,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    ManageSalaryCubit.get(context).getSchedulesForDay(
                                      ManageSalaryCubit.get(context).days?[index].name ?? '',
                                    );
                                    ManageSalaryCubit.get(context).changeSelectedDayIndex(index);
                                  },
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Container(
                                      width: 75.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: ManageSalaryCubit.get(context).selectedDayIndex == index
                                            ? Colors.blue
                                            : Color(0xFFF3F3F3),
                                        borderRadius: BorderRadius.circular(8),
                                        shape: BoxShape.rectangle,
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        ManageSalaryCubit.get(context).days?[index].name ?? '',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          color: ManageSalaryCubit.get(context).selectedDayIndex == index
                                              ? Color(0xFFF4F4F4)
                                              : Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ManageSalaryCubit.get(context).days?.length ?? 0,
                              );
                            },
                          ),
                        ),
                      );
                    }
                  }