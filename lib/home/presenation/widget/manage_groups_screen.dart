//
//use flutter_screenutil to make above ManageGroupsScreen responsive
//instead of height: 160 ,use height: 160.h,
//instead of width: 155, use width: 155.w,
//instead of SizedBox(height: 20), use SizedBox(height: 20.h),
//instead of SizedBox(width: 20), use SizedBox(width: 20.w),
//instead of fontSize: 16, use fontSize: 16.sp,
//instead of fontSize: 18, use fontSize: 18.sp, and so on for all sizes in the app
import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../add_grouup_of_schedules/presentation/onboarding_screen.dart';
import '../../../core/constants/routes_manager.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../core/flutter_flow/flutter_flow_widgets.dart';
import '../../business_logic/Home/manage_salary_cubit.dart';
import '../../data/schedules.dart';
class ManageGroupsScreen extends StatelessWidget {
  const ManageGroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              width: 50.w,
              height: 50.h,
              fit: BoxFit.none,
            ),
          ),
        ),
      ),
      // key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                                ),


//52
SizedBox(height: 5.h),
               Text(
    'ادارة المجموعات',
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Color(0xFF333333),
        fontSize: 32.sp,
        fontFamily: 'Montserrat-Arabic',
        fontWeight: FontWeight.w400,
        height: 0.03.h,
    ),
),
//65
SizedBox(height: 0.h),
               // ScheduleDaysList(),
                BranchList(),
                Container(
                  height: 400.h,
                  child: SingleChildScrollView(
                    child: Column(
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


                                return FirestoreListView(query:
                                  FirebaseFirestore.instance
                                      .collection('branches').
                                  doc('المنيا')
                                      .collection('groups'),
                                  pageSize: 8,
                                  cacheExtent: 100,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, doc)
{
  final data = doc.data() as Map<String, dynamic>;
  final group = GroupModel.fromJson(data);
   //group.days;
  // group.days;
  var days = group.days.entries.toList();
  /
                                    return Container(
                                      width: 350.w,
                                      height: 100.h,
                                      color: Colors.purpleAccent,
                                      child: ListView.builder(
                                        itemCount: days.length,
                                        itemBuilder: (context, index) {
                                          String day = days[index].key;
                                          var start = days[index].value['start'];
                                      //    Timestamp timestamp = days[index].value;
                                        //  DateTime dateTime = timestamp.toDate();
                                          return ListTile(
                                            title: Text(day),
                                            subtitle: Text(//start.toString()),

                                          //convert start time which is timestamp to get hr like that
                                          //'${ManageAttendenceCubit.get(context).startTime != null ? (ManageAttendenceCubit.get(context).startTime!.toDate().hour > 12 ? ManageAttendenceCubit.get(context).startTime!.toDate().hour - 12 : ManageAttendenceCubit.get(context).startTime!.toDate().hour) : 11}:${ManageAttendenceCubit.get(context).startTime?.toDate().minute.toString().padLeft(2, '0')}${ManageAttendenceCubit.get(context).startTime != null ? (ManageAttendenceCubit.get(context).startTime!.toDate().hour >= 12 ? 'م' : 'ص') : 'ص'}',
                                      '${start!.toDate().hour > 12 ? start.toDate().hour - 12 : start.toDate().hour}:${start.toDate().minute.toString().padLeft(2, '0')}${start.toDate().hour >= 12 ? 'م' : 'ص'}',
                                          ),
                                          //    subtitle: Text(dateTime.toString()),
                                          );
                                        },
                                      ),
                                    );
                                    },
                                //  itemCount: ManageSalaryCubit
                                //      .get(context)
                                //      .schedules
                                //      ?.length ?? 0,
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
                  ),
                ),

                FFButtonWidget(
                  onPressed: () {
                  //  ManageAttendenceCubit.get(context).selectedCoaches = [];
                  //  ManageAttendenceCubit.get(context).selectedDays = [];
                  //  ManageAttendenceCubit.get(context).startTime = Timestamp.now();
                  //  ManageAttendenceCubit.get(context).endTime = Timestamp.now();
                    final addGroupCubit = context.read<AddGroupCubit>();
                    addGroupCubit.initState(context);
                    ManageAttendenceCubit.get(context).getAdminData();
                    Navigator.pushNamed(
                      context,
                      AppRoutes.onboarding,
                     // AppRoutes.addSchedule,
                      // arguments: {
                      //   'toggle': true,
                      //   'startTime': Timestamp.now(),
                      //   'endTime': Timestamp.now(),
                      // },
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
                //SizedBox(height: 20.h),
               ].divide(SizedBox(height: 30)),

             ),

           ],
         ),
       ),
     );
   }
}


class BranchList extends StatelessWidget {
  const BranchList({Key? key}) : super(key: key);

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
            return FirestoreListView(
              query: FirebaseFirestore.instance.collection('branches'),
              pageSize: 8,
              cacheExtent: 100,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, doc) {
                final data = doc.data() as Map<String, dynamic>;
                final branch = BranchModel.fromJson(data);
                return GestureDetector(
                  onTap: () {
                    print('branch id is ${branch.name}\n\n\n\n\n\n');
                    ManageSalaryCubit.get(context).changeSelectedBranchIndex(
                       branch.name?? ''
                    );
                  },
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: 75.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ManageSalaryCubit.get(context).selectedBranchIndex == 1
                            ? Colors.blue
                            : Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        branch.name ?? '',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: ManageSalaryCubit.get(context).selectedBranchIndex == 1
                              ? Color(0xFFF4F4F4)
                              : Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class BranchModel {
  String? name;


  BranchModel({
    this.name,
  });

  BranchModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name ?? '';
    return data;
  }
}

class GroupModel {
  final Map<String, Map<String, Timestamp>> days;
  final String groupId;
  final String maxUsers;
  final String name;
  final int numberOfCoaches;
  final int numberOfUsers;
  final String pid;

  GroupModel({
    required this.days,
    required this.groupId,
    required this.maxUsers,
    required this.name,
    required this.numberOfCoaches,
    required this.numberOfUsers,
    required this.pid,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    final daysJson = json['days'] as Map<String, dynamic>;
    final days = <String, Map<String, Timestamp>>{};

    daysJson.forEach((key, value) {
      days[key] = {
        'start': value['start'] ,
        'end': value['end'] ,
      };
    });

    return GroupModel(
      days: days,
      groupId: json['group_id'],
      maxUsers: json['max_users'],
      name: json['name'],
      numberOfCoaches: json['number_of_coaches'],
      numberOfUsers: json['number_of_users'],
      pid: json['pid'],
    );
  }

  Map<String, dynamic> toJson() {
    final daysJson = <String, dynamic>{};

    days.forEach((key, value) {
      daysJson[key] = {
        'start': value['start'],
        'end': value['end'],
      };
    });

    return {
      'days': daysJson,
      'group_id': groupId,
      'max_users': maxUsers,
      'name': name,
      'number_of_coaches': numberOfCoaches,
      'number_of_users': numberOfUsers,
      'pid': pid,
    };
  }
}