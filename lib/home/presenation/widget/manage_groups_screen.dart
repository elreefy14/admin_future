//
//use flutter_screenutil to make above ManageGroupsScreen responsive
//instead of height: 160 ,use height: 160.h,
//instead of width: 155, use width: 155.w,
//instead of SizedBox(height: 20), use SizedBox(height: 20.h),
//instead of SizedBox(width: 20), use SizedBox(width: 20.w),
//instead of fontSize: 16, use fontSize: 16.sp,
//instead of fontSize: 18, use fontSize: 18.sp, and so on for all sizes in the app
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../registeration/data/userModel.dart';
import '../../../manage_users_coaches/business_logic/manage_users_cubit.dart';

// class ManageGroupsScreen extends StatelessWidget {
//   const ManageGroupsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: ManageSalaryCubit.get(context).getBranches(),
//         builder: (context, snapshot) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               shadowColor: Colors.transparent,
//               leading: InkWell(
//                 onTap: () async {
//                   Navigator.pop(context);
//                 },
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.asset(
//                     'assets/images/back.png',
//                     width: 50.w,
//                     height: 50.h,
//                     fit: BoxFit.none,
//                   ),
//                 ),
//               ),
//             ),
//             // key: scaffoldKey,
//             backgroundColor: Colors.white,
//             body: SafeArea(
//               top: true,
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [],
//                       ),
// //52
//                       SizedBox(height: 5.h),
//                       Text(
//                         'ادارة المجموعات',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0xFF333333),
//                           fontSize: 32.sp,
//                           fontFamily: 'Montserrat-Arabic',
//                           fontWeight: FontWeight.w400,
//                           height: 0.03.h,
//                         ),
//                       ),
// //65
//                       SizedBox(height: 0.h),
//                       // ScheduleDaysList(),
//                       BranchList(),
//                       Container(
//                         height: 400.h,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Divider(
//                                 thickness: 2,
//                                 color: Color(0xFFF4F4F4),
//                               ),
//                               Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   BlocBuilder<ManageSalaryCubit,
//                                       ManageSalaryState>(
//                                     builder: (context, state) {
//                                       return //if branch is null return empty container
//                                           ManageSalaryCubit.get(context)
//                                                   .branches
//                                                   .isEmpty
//                                               ? Container()
//                                               : FirestoreListView(
//                                                   query: FirebaseFirestore
//                                                       .instance
//                                                       .collection('branches')
//                                                       .doc(ManageSalaryCubit
//                                                               .get(context)
//                                                           .branches[ManageSalaryCubit
//                                                                       .get(
//                                                                           context)
//                                                                   .selectedBranchIndex ??
//                                                               1]
//                                                           .name)
//                                                       .collection('groups'),
//                                                   pageSize: 8,
//                                                   cacheExtent: 500,
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   shrinkWrap: true,
//                                                   physics:
//                                                       NeverScrollableScrollPhysics(),
//                                                   itemBuilder: (context, doc) {
//                                                     final data = doc.data()
//                                                         as Map<String, dynamic>;
//                                                     final group =
//                                                         GroupModel.fromJson(
//                                                             data);
//                                                     var days = group
//                                                         .days.entries
//                                                         .toList();
//                                                     return Container(
//                                                       width: 350.w,
//                                                       //  height: 200.h,
//                                                       color:
//                                                           Colors.purpleAccent,
//                                                       child: ListView.separated(
//                                                         separatorBuilder:
//                                                             (context, index) {
//                                                           return Divider(
//                                                             thickness: 0,
//                                                             color: Color(
//                                                                 0xFFF4F4F4),
//                                                           );
//                                                         },
//                                                         physics:
//                                                             NeverScrollableScrollPhysics(),
//                                                         shrinkWrap: true,
//                                                         cacheExtent: 100,
//                                                         scrollDirection:
//                                                             Axis.vertical,
//                                                         itemCount: days.length,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           String day =
//                                                               days[index].key;
//                                                           var start =
//                                                               days[index].value[
//                                                                   'start'];
//                                                           //    Timestamp timestamp = days[index].value;
//                                                           //  DateTime dateTime = timestamp.toDate();
//                                                           return ListTile(
//                                                             leading: Row(
//                                                               mainAxisSize:
//                                                                   MainAxisSize
//                                                                       .min,
//                                                               children: [
//                                                                 FFButtonWidget(
//                                                                   onPressed:
//                                                                       () {
//                                                                     print(
//                                                                         'Delete button pressed ...');
//                                                                     // ManageSalaryCubit.get(context).deleteSchedule(
//                                                                     //   coachesIds: coachesIds?.cast<String>() ?? [],
//                                                                     //   usersIds: usersIds?.cast<String>() ?? [],
//                                                                     //   scheduleId: scheduleId,
//                                                                     //   day: day,
//                                                                     // );
//                                                                     ManageSalaryCubit.get(
//                                                                             context)
//                                                                         .deleteGroup(
//                                                                       groupId: group
//                                                                           .groupId,
//                                                                       branchId:
//                                                                           group
//                                                                               .name,
//                                                                       schedulesIds:
//                                                                           group
//                                                                               .schedulesIds,
//                                                                       schedulesDays:
//                                                                           group
//                                                                               .schedulesDays,
//                                                                     );
//                                                                   },
//                                                                   text: 'حذف',
//                                                                   options:
//                                                                       FFButtonOptions(
//                                                                     width: 50.w,
//                                                                     height:
//                                                                         40.h,
//                                                                     padding: EdgeInsetsDirectional
//                                                                         .fromSTEB(
//                                                                             5,
//                                                                             0,
//                                                                             5,
//                                                                             0),
//                                                                     iconPadding:
//                                                                         EdgeInsetsDirectional.fromSTEB(
//                                                                             0,
//                                                                             0,
//                                                                             0,
//                                                                             0),
//                                                                     color: Colors
//                                                                         .red,
//                                                                     textStyle: FlutterFlowTheme.of(
//                                                                             context)
//                                                                         .titleSmall
//                                                                         .override(
//                                                                           fontFamily:
//                                                                               'Readex Pro',
//                                                                           color:
//                                                                               Colors.white,
//                                                                           fontSize:
//                                                                               12.sp,
//                                                                         ),
//                                                                     elevation:
//                                                                         3,
//                                                                     borderSide:
//                                                                         BorderSide(
//                                                                       color: Colors
//                                                                           .transparent,
//                                                                       width: 1,
//                                                                     ),
//                                                                     borderRadius:
//                                                                         BorderRadius
//                                                                             .circular(8),
//                                                                   ),
//                                                                 ),
//                                                                 SizedBox(
//                                                                     width:
//                                                                         10.w),
//                                                                 FFButtonWidget(
//                                                                   onPressed:
//                                                                       () {
//                                                                     //
//                                                                     // ManageAttendenceCubit.get(context).selectedCoaches = usersList?.cast<String>() ?? [];
//                                                                     // ManageAttendenceCubit.get(context).selectedDays = [day];
//                                                                     // ManageAttendenceCubit.get(context).startTime = statrTime;
//                                                                     // ManageAttendenceCubit.get(context).endTime = endTime;
//                                                                     // //selectedBranch
//                                                                     // ManageAttendenceCubit.get(context).selectedBranch = schedule.branchId ?? '';
//                                                                     //selectedBranch
//                                                                     //print('${ManageSalaryCubit.get(context).schedules?[index].branchId}');
//                                                                     ManageAttendenceCubit.get(
//                                                                             context)
//                                                                         .getAdminData();
//                                                                     // updateSelectedUsersAndCoachesAndTimesAndBranchAndMaxUsers
//
//                                                                     Navigator
//                                                                         .pushNamed(
//                                                                       context,
//                                                                       AppRoutes
//                                                                           .onboarding,
//                                                                       arguments: {
//                                                                         'isAdd':
//                                                                             false,
//                                                                         'branchId':
//                                                                             group.name,
//                                                                         'maxUsers':
//                                                                             group.maxUsers,
//                                                                         'days':
//                                                                             group.days,
//                                                                         'usersList':
//                                                                             group.usersList,
//                                                                         'coachList':
//                                                                             group.coachList,
//                                                                         'coachIds':
//                                                                             group.coachIds,
//                                                                         'userIds':
//                                                                             group.userIds,
//                                                                         'scheduleId':
//                                                                             group.schedulesIds,
//                                                                         'schedule_days':
//                                                                             group.schedulesDays,
//                                                                         'groupId':
//                                                                             group.groupId,
//                                                                         'users':
//                                                                             group.users,
//
//                                                                         // 'coaches': group.coaches,
//                                                                       },
//                                                                     );
//                                                                   },
//                                                                   text: 'تعديل',
//                                                                   options:
//                                                                       FFButtonOptions(
//                                                                     width: 50.w,
//                                                                     height:
//                                                                         40.h,
//                                                                     padding: EdgeInsetsDirectional
//                                                                         .fromSTEB(
//                                                                             5,
//                                                                             0,
//                                                                             5,
//                                                                             0),
//                                                                     iconPadding:
//                                                                         EdgeInsetsDirectional.fromSTEB(
//                                                                             0,
//                                                                             0,
//                                                                             0,
//                                                                             0),
//                                                                     color: Colors
//                                                                         .blue,
//                                                                     textStyle: FlutterFlowTheme.of(
//                                                                             context)
//                                                                         .titleSmall
//                                                                         .override(
//                                                                           fontFamily:
//                                                                               'Readex Pro',
//                                                                           color:
//                                                                               Colors.white,
//                                                                           fontSize:
//                                                                               12.sp,
//                                                                         ),
//                                                                     elevation:
//                                                                         3,
//                                                                     borderSide:
//                                                                         BorderSide(
//                                                                       color: Colors
//                                                                           .transparent,
//                                                                       width: 1,
//                                                                     ),
//                                                                     borderRadius:
//                                                                         BorderRadius
//                                                                             .circular(8),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             title: Text(day),
//                                                             subtitle: Text(
//                                                               //start.toString()),
//
//                                                               //convert start time which is timestamp to get hr like that
//                                                               //'${ManageAttendenceCubit.get(context).startTime != null ? (ManageAttendenceCubit.get(context).startTime!.toDate().hour > 12 ? ManageAttendenceCubit.get(context).startTime!.toDate().hour - 12 : ManageAttendenceCubit.get(context).startTime!.toDate().hour) : 11}:${ManageAttendenceCubit.get(context).startTime?.toDate().minute.toString().padLeft(2, '0')}${ManageAttendenceCubit.get(context).startTime != null ? (ManageAttendenceCubit.get(context).startTime!.toDate().hour >= 12 ? 'م' : 'ص') : 'ص'}',
//                                                               '${start!.toDate().hour > 12 ? start.toDate().hour - 12 : start.toDate().hour}:${start.toDate().minute.toString().padLeft(2, '0')}${start.toDate().hour >= 12 ? 'م' : 'ص'}',
//                                                             ),
//                                                             //    subtitle: Text(dateTime.toString()),
//                                                           );
//                                                         },
//                                                       ),
//                                                     );
//                                                   },
//                                                   //  itemCount: ManageSalaryCubit
//                                                   //      .get(context)
//                                                   //      .schedules
//                                                   //      ?.length ?? 0,
//                                                 );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               Divider(
//                                 thickness: 2,
//                                 color: Color(0xFFF4F4F4),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       FFButtonWidget(
//                         onPressed: () {
//                           //  ManageAttendenceCubit.get(context).selectedCoaches = [];
//                           //  ManageAttendenceCubit.get(context).selectedDays = [];
//                           //  ManageAttendenceCubit.get(context).startTime = Timestamp.now();
//                           //  ManageAttendenceCubit.get(context).endTime = Timestamp.now();
//                           final addGroupCubit = context.read<AddGroupCubit>();
//                           addGroupCubit.initState(context);
//                           ManageAttendenceCubit.get(context).getAdminData();
//                           Navigator.pushNamed(
//                             context,
//                             AppRoutes.onboarding,
//                             arguments: {
//                               'isAdd': true,
//                               'branchId': ManageSalaryCubit.get(context)
//                                   .branches[ManageSalaryCubit.get(context)
//                                           .selectedBranchIndex ??
//                                       1]
//                                   .name,
//                               'maxUsers': '',
//                               // 'days': {},
//                               //   'usersList': [],
//                               //    'coachList': [],
//                               //    'coachIds': [],
//                               //   'userIds': [],
//                               //   'scheduleId': [],
//                               //    'schedule_days': [],
//                               'groupId': '',
//                             },
//                           );
//                         },
//                         text: 'اضافة موعد ',
//                         options: FFButtonOptions(
//                           height: 40.h,
//                           padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
//                           iconPadding:
//                               EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                           color: Color(0xFF198CE3),
//                           textStyle:
//                               FlutterFlowTheme.of(context).titleSmall.override(
//                                     fontFamily: 'Readex Pro',
//                                     color: Colors.white,
//                                     fontSize: 12.sp,
//                                   ),
//                           elevation: 3,
//                           borderSide: BorderSide(
//                             color: Colors.transparent,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       //SizedBox(height: 20.h),
//                     ].divide(SizedBox(height: 30)),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

class BranchList extends StatelessWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call the function to get branches
    final manageSalaryCubit = ManageUsersCubit.get(context);
    // manageSalaryCubit.getBranches();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65.h,
      decoration: BoxDecoration(
        color: Color.fromARGB(0, 195, 162, 162),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: BlocBuilder<ManageUsersCubit, ManageUsersState>(
        builder: (context, state) {
          // Check if branches are loaded
          if (manageSalaryCubit.branches.isEmpty) {
            return CircularProgressIndicator(); // Show a loading indicator while branches are being fetched
          } else {
            return ListView.builder(
              cacheExtent: 100,
              scrollDirection: Axis.horizontal,
              itemCount: manageSalaryCubit.branches.length,
              itemBuilder: (context, index) {
                final branch = manageSalaryCubit.branches[index];
                return GestureDetector(
                  onTap: () {
                    print('branch id is ${branch.name}\n\n\n\n\n\n');
                    manageSalaryCubit.changeSelectedBranchIndex(index);
                  },
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: 95.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: manageSalaryCubit.selectedBranchIndex == index
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
                              color:
                                  manageSalaryCubit.selectedBranchIndex == index
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
          }
        },
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

  //schedule_ids
  final List<String> schedulesIds;

//schedule_days
  final List<String> schedulesDays;

  // 'usersList': FieldValue.arrayUnion([user.name]),
  //                 'userIds': FieldValue.arrayUnion([user.uId]),
  //         'schedule_ids': FieldValue.arrayUnion([scheduleRef.id]),
  //               'schedule_days': FieldValue.arrayUnion([day]),
//  'coachList': FieldValue.arrayUnion([coach.name]),
//  'coachIds': FieldValue.arrayUnion([coach.uId]),
  final List<String> coachIds;
  final List<String> coachList;
  final List<String> userIds;
  final List<String> usersList;
  final List<UserModel> users;
  final List<UserModel> coaches;

  GroupModel({
    required this.days,
    required this.groupId,
    required this.maxUsers,
    required this.name,
    required this.numberOfCoaches,
    required this.numberOfUsers,
    required this.pid,
    required this.schedulesIds,
    required this.schedulesDays,
    required this.coachIds,
    required this.coachList,
    required this.userIds,
    required this.usersList,
    required this.users,
    required this.coaches,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    final daysJson = json['days'] as Map<String, dynamic>;
    final days = <String, Map<String, Timestamp>>{};

    daysJson.forEach((key, value) {
      days[key] = {
        'start': value['start'],
        'end': value['end'],
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
      schedulesIds: json['schedule_ids']?.cast<String>() ?? [],
      schedulesDays: json['schedule_days']?.cast<String>() ?? [],
      // 'usersList': FieldValue.arrayUnion([user.name]),
      //                 'userIds': FieldValue.arrayUnion([user.uId]),
      //         'schedule_ids': FieldValue.arrayUnion([scheduleRef.id]),
      //               'schedule_days': FieldValue.arrayUnion([day]),
//  'coachList': FieldValue.arrayUnion([coach.name]),
//  'coachIds': FieldValue.arrayUnion([coach.uId]),
      coachIds: json['coachIds']?.cast<String>() ?? [],
      coachList: json['coachList']?.cast<String>() ?? [],
      userIds: json['userIds']?.cast<String>() ?? [],
      usersList: json['usersList']?.cast<String>() ?? [],
      users: (json['users'] as List<dynamic>?)
              ?.map((json) => UserModel.fromJson(json))
              .toList() ??
          [],
      coaches: (json['coaches'] as List<dynamic>?)
              ?.map((json) => UserModel.fromJson(json))
              .toList() ??
          [],
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
      'schedule_ids': schedulesIds,
      'schedule_days': schedulesDays,
      'coachIds': coachIds,
      'coachList': coachList,
      'userIds': userIds,
      'usersList': usersList,
      'users': users,
      'coaches': coaches,
    };
  }
}
