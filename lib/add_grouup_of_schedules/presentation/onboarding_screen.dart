import 'package:admin_future/add_grouup_of_schedules/presentation/select_coaches.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:admin_future/registeration/data/userModel.dart';

import 'package:admin_future/home/presenation/widget/widget/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../home/business_logic/Home/manage_attendence_state.dart';
import '../../home/business_logic/Home/manage_salary_cubit.dart';
import '../../home/data/schedules.dart';
import '../../home/presenation/widget/add_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BEGIN: ed8c6549bwf9 (already existing code)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_future/add_grouup_of_schedules/presentation/select_coaches.dart';

class AddGroupCubit extends Cubit<AddGroupState> {
  var _searchController;

  AddGroupCubit()
      : super(
      AddGroupState(screens: [
          SelectCoachesScreen(
            isCoach: true,
          ),
          SelectCoachesScreen(
            isCoach: false,
          ),
          Screen2(),
          SelectBranchScreen(),
          InfoScreen()
        ]));

  final TextEditingController searchController = TextEditingController();
  Query? usersQuery ;
  Query? _query2;
  String? onSubmitted;
  List<String> selectedUsersUids = [];
  String? maxUsers;
  //final TextEditingController _searchController = TextEditingController();
  // Query? _query;
  int? numberOfQuery;
  List<String> selectedCoachesUids = [];
  //List<String> _selectedUsersUids = [];
   List<UserModel> selectedCoaches = [];
   List<UserModel> selectedUsers = [];
  static final Map<String, Map<dynamic, dynamic>> _times = {
    'السبت': {'start': null, 'end': null},
    'الأحد': {'start': null, 'end': null},
    'الاثنين': {'start': null, 'end': null},
    'الثلاثاء': {'start': null, 'end': null},
    'الأربعاء': {'start': null, 'end': null},
    'الخميس': {'start': null, 'end': null},
    'الجمعة': {'start': null, 'end': null},
  };

  Map<String, Map<dynamic, dynamic>> get times => _times;



  @override
  void initState() {
    // super.initState();
    usersQuery = FirebaseFirestore.instance.collection('users');
  }

  Future<void> onSearchSubmitted(String value, bool isCoach) async {
    late Query newQuery;
    if (isCoach)
      newQuery = FirebaseFirestore.instance
          .collection('users')
          .orderBy('name')
          .startAt([value])
          .endAt([value + '\uf8ff'])
          .where('role', isEqualTo: 'coach')
          .limit(100);
    else
      newQuery = FirebaseFirestore.instance
          .collection('users')
          .orderBy('name')
          .startAt([value])
          .endAt([value + '\uf8ff'])
          .where('role', isEqualTo: 'user')
          .limit(100);

    QuerySnapshot querySnapshot =
        await newQuery.get(GetOptions(source: Source.serverAndCache));
    var numberOfQuery = querySnapshot.docs.length;
    print('number of query is $numberOfQuery');
    print(numberOfQuery);

    if (numberOfQuery == 0) {
      if (isCoach)
        newQuery = FirebaseFirestore.instance
            .collection('users')
            .where('phone', isGreaterThanOrEqualTo: value)
            .where('phone', isLessThan: value + 'z')
            //order by name
            .orderBy('phone', descending: false)
            .where('role', isEqualTo: 'coach')
            .limit(100);
      else
        newQuery = FirebaseFirestore.instance
            .collection('users')
            .where('phone', isGreaterThanOrEqualTo: value)
            .where('phone', isLessThan: value + 'z')
            //order by name
            .orderBy('phone', descending: false)
            .where('role', isEqualTo: 'user')
            .limit(100);
    }
    //update query
    updateQuery(newQuery);
  }
  // List<UserModel> _selectedCoaches = [];
  // List<UserModel> _selectedUsers = [];
  void selectUser(UserModel user) {
    //add user to selected users
    selectedUsers.add(user);
    emit(state.copyWith(selectedUsers: [...state.selectedUsers, user]));
  }

  void deselectUser(UserModel user) {
    //remove user from selected users
   // selectedUsers.removeWhere((u) => u.uId == user.uId);
    emit(state.copyWith(
        selectedUsers: state.selectedUsers.where((u) => u.uId != user.uId).toList()));
  }

  void selectCoach(UserModel coach) {
    selectedCoaches.add(coach);
    emit(state.copyWith(selectedCoaches: [...state.selectedCoaches, coach]));
  }

  void deselectCoach(UserModel coach) {
    print('deselectCoach');
    print(selectedCoaches.length);
    //selectedCoaches.remove(coach);
    //remove where uId != coach.uId
  //  selectedCoaches.removeWhere((c) => c.uId == coach.uId);
    emit(state.copyWith(
        selectedCoaches:
          //  state.selectedCoaches.where((c) => c != coach).toList()));
        state.selectedCoaches.where((c) => c.uId != coach.uId).toList()));
    print(selectedCoaches.length);

  }

  void selectTime(String time) {
    emit(state.copyWith(selectedTimes: [...state.selectedTimes, time]));
  }

  void deselectTime(String time) {
    emit(state.copyWith(
        selectedTimes: state.selectedTimes.where((t) => t != time).toList()));
  }

  void selectBranch(String branch) {
    emit(state.copyWith(selectedBranch: branch));
  }

  void selectOption(String option) {
    emit(state.copyWith(selectedOption: option));
  }

  void updateSelectedBranch(String branch) {
    emit(state.copyWith(selectedBranch: branch));
  }

  void updateSelectedCoaches(List<UserModel> coaches) {
    emit(state.copyWith(selectedCoaches: coaches));
  }

  void updateSelectedTimes(List<String> times) {
    emit(state.copyWith(selectedTimes: times));
  }

  void nextScreen() {
    int currentIndex = state.currentIndex;
    if (currentIndex < state.screens.length - 1) {
      emit(state.copyWith(currentIndex: currentIndex + 1));
    }
  }

  void previousScreen() {
    int currentIndex = state.currentIndex;
    if (currentIndex > 0) {
      emit(state.copyWith(currentIndex: currentIndex - 1));
    }
  }

  void setCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void searchUsers(String query) {
    _query2 = usersQuery!
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff');
    emit(state.copyWith(searchQuery: query));
  }

  void clearSearch() {
    _query2 = null;
    _searchController.clear();
    emit(state.copyWith(searchQuery: null));
  }

  Stream<QuerySnapshot> getUsersStream() {
    if (_query2 != null) {
      return _query2!.snapshots();
    } else {
      return usersQuery!.snapshots();
    }
  }

  void selectUserUid(UserModel user) {
    selectedUsersUids.add(user.uId??'');
    emit(state.copyWith(selectedUsersUids: selectedUsersUids));
  }

  void deselectUserUid(UserModel user) {
    selectedUsersUids.remove(user);
    emit(state.copyWith(selectedUsersUids: selectedUsersUids));
  }

  void updateTime(String day, TimeOfDay endTime) {
    _times[day]?['end'] = endTime;
    _times[day]?['start'] = endTime.replacing(hour: endTime.hour - 1);
    emit(state.copyWith(times: _times));
  }
//handle selected users like selected coaches
  late Map<String, Map<dynamic, dynamic>> nonNullableDays = {};
  Future<void> addGroup(
      bool isEmit,
      BuildContext context, {
        required List<UserModel> selectedUsers,
        required List<UserModel> selectedCoaches,
        required Timestamp startTrainingTime,
        required Timestamp endTrainingTime,
        required String branch,
        Map<String, Map<dynamic, dynamic>>? times,
        String? maxUsers,
      }) async {
    emit(state.copyWith(loading: true));
    // late Map<String, Map<dynamic, dynamic>> nonNullableDays = {};

    // Convert times to nonNullableDays
    for (var day in times!.keys) {
      if (times[day]!['start'] != null && times[day]!['end'] != null) {
        DateTime nearestDay = getNearestDayOfWeek(day);
        Timestamp nearestDayTimestamp = Timestamp.fromDate(nearestDay);
        nonNullableDays[day] = {
          'start': Timestamp.fromDate(DateTime(
              nearestDay.year,
              nearestDay.month,
              nearestDay.day,
              times[day]!['start'].hour,
              times[day]!['start'].minute)),
          'end': Timestamp.fromDate(DateTime(
              nearestDay.year,
              nearestDay.month,
              nearestDay.day,
              times[day]!['end'].hour,
              times[day]!['end'].minute)),
          'nearest_day': nearestDayTimestamp,
        };
      }
    }

    // Get all non-null days
    List<String> days = nonNullableDays.keys.toList();

    // Create a batched write
    WriteBatch batch = FirebaseFirestore.instance.batch();

    try {


      // Add schedules to batch
      for (var day in days) {
        if (nonNullableDays.containsKey(day)) {
          Timestamp nearestDayTimestamp = nonNullableDays[day]!['nearest_day'];

          DocumentReference scheduleRef = FirebaseFirestore.instance
              .collection('admins')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('schedules')
              .doc(day)
              .collection('schedules')
              .doc();

          batch.set(scheduleRef, {
            'start_time': nonNullableDays[day]!['start'],
            'end_time': nonNullableDays[day]!['end'],
            'date': day,
            'nearest_day': nearestDayTimestamp,
            'branch_id': branch,
            'usersList': [],
            'userIds': [],
            'max_users': maxUsers,
          });

          // Add coaches to batch
          if (selectedCoaches != null && selectedCoaches.isNotEmpty) {
            for (var coach in selectedCoaches) {
              DocumentReference coachRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(coach.uId)
                  .collection('schedules')
                  .doc(scheduleRef.id);

              batch.set(coachRef, {
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'max_users': maxUsers,
              });

              DocumentReference adminRef = FirebaseFirestore.instance
                  .collection('admins')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('schedules')
                  .doc(day)
                  .collection('schedules')
                  .doc(scheduleRef.id)
                  .collection('users')
                  .doc(coach.uId);

              batch.set(adminRef, {
                'name': coach.name,
                'uid': coach.uId,
                'finished': false,
                'role': 'coach',
              });

              batch.update(scheduleRef, {
                'coachList': FieldValue.arrayUnion([coach.name]),
                'coachIds': FieldValue.arrayUnion([coach.uId]),
              });

              DocumentReference coachScheduleRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(coach.uId)
                  .collection('schedules')
                  .doc(scheduleRef.id);

              batch.set(coachScheduleRef, {
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'scheduleId': scheduleRef.id,
                'max_users': maxUsers,
              });
            }
          }

          // Add users to batch
          if (selectedUsers != null && selectedUsers.isNotEmpty) {
            for (var user in selectedUsers) {
              DocumentReference userRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uId)
                  .collection('schedules')
                  .doc(scheduleRef.id);

              batch.set(userRef, {
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'max_users': maxUsers,
              });

              DocumentReference adminRef = FirebaseFirestore.instance
                  .collection('admins')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('schedules')
                  .doc(day)
                  .collection('schedules')
                  .doc(scheduleRef.id)
                  .collection('users')
                  .doc(user.uId);

              batch.set(adminRef, {
                'name': user.name,
                'uid': user.uId,
                'finished': false,
                'role': 'user',
              });

              batch.update(scheduleRef, {
                'usersList': FieldValue.arrayUnion([user.name]),
                'userIds': FieldValue.arrayUnion([user.uId]),
              });

              DocumentReference userScheduleRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uId)
                  .collection('schedules')
                  .doc(scheduleRef.id);

              batch.set(userScheduleRef, {
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'scheduleId': scheduleRef.id,
                'max_users': maxUsers,
              });
            }
          }
        }
      }
      //todo :fix branch is null
      DocumentReference branchRef = FirebaseFirestore.instance
          .collection('branches')
          .doc(branch)
          .collection('groups')
          .doc();

      batch.set(branchRef, {
        'name': branch,
        'max_users': maxUsers,
        'number_of_users': selectedUsers.length,
        'number_of_coaches': selectedCoaches.length,
        'pid': FirebaseAuth.instance.currentUser!.uid,
        'group_id': branchRef.id,
        //non nullable days as map
        'days': nonNullableDays,
      });

      // Commit the batched write
      await batch.commit();

      emit(state.copyWith(loading: false));

      Fluttertoast.showToast(
          msg: 'تم إضافة المواعيد بنجاح',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      emit(state.copyWith(loading: false));

      Fluttertoast.showToast(
          msg: 'حدث خطأ أثناء إضافة المواعيد\n${e.toString()}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  //
  // Future<void> addGroup(
  //   bool isEmit,
  //   BuildContext context, {
  //   required List<UserModel> selectedCoaches,
  //   required Timestamp startTrainingTime,
  //   required Timestamp endTrainingTime,
  //   required String branch,
  //   Map<String, Map<dynamic, dynamic>>? times,
  //   String? maxUsers,
  // }) async {
  //   // void addSchedule(
  //   //     bool isEmit  ,
  //   //   BuildContext context, {
  //   //  // List<String>? selectedDays,
  //   //   String? startTrainingTime,
  //   //   String? endTrainingTime,
  //   //   String? branch,
  //   //   Map<String, Map<dynamic, dynamic>>? times,
  //   // }) async {
  //   //todo change use thsi map
  //
  //   for (var day in times!.keys) {
  //     if (times[day]!['start'] != null && times[day]!['end'] != null) {
  //       DateTime nearestDay = getNearestDayOfWeek(day);
  //       Timestamp nearestDayTimestamp = Timestamp.fromDate(nearestDay);
  //       nonNullableDays[day] = {
  //         'start': Timestamp.fromDate(DateTime(
  //             nearestDay.year,
  //             nearestDay.month,
  //             nearestDay.day,
  //             times[day]!['start'].hour,
  //             times[day]!['start'].minute)),
  //         'end': Timestamp.fromDate(DateTime(
  //             nearestDay.year,
  //             nearestDay.month,
  //             nearestDay.day,
  //             times[day]!['end'].hour,
  //             times[day]!['end'].minute)),
  //         'nearest_day': nearestDayTimestamp,
  //       };
  //     }
  //   }
  //   print('nonNullableDays: ${nonNullableDays.toString()}}');
  //
  //   List<String> days = //get all non null days
  //       nonNullableDays.keys.toList();
  //   //get all non null days start and end time as timestamp . note start and end time is timeofday
  //
  //   SchedulesModel? schedule;
  //   try {
  //     //  if (isEmit)
  //     // emit(AddScheduleLoadingState());
  //     emit(state.copyWith(loading: true));
  //     for (var day in days) {
  //       if (nonNullableDays.containsKey(day)) {
  //         //DateTime nearestDay = nonNullableDays[day]!['nearest_day'].toDate();
  //         Timestamp nearestDayTimestamp = nonNullableDays[day]!['nearest_day'];
  //
  //         await FirebaseFirestore.instance
  //             .collection('admins')
  //             .doc(FirebaseAuth.instance.currentUser!.uid)
  //             .collection('schedules')
  //             .doc(day)
  //             .collection('schedules')
  //             .add({
  //           'start_time': nonNullableDays[day]!['start'],
  //           'end_time': nonNullableDays[day]!['end'],
  //           'date': day,
  //           'nearest_day': nearestDayTimestamp,
  //           'branch_id': branch,
  //           'usersList': [],
  //           'userIds': [],
  //           'max_users': maxUsers,
  //         }).then((scheduleDoc) async {
  //           if (selectedCoaches != null && selectedCoaches.isNotEmpty) {
  //             for (var coach in selectedCoaches) {
  //               await FirebaseFirestore.instance
  //                   .collection('users')
  //                   .doc(coach.uId)
  //                   .collection('schedules')
  //                   .doc(scheduleDoc.id)
  //                   .set({
  //                 'start_time': nonNullableDays[day]!['start'],
  //                 'end_time': nonNullableDays[day]!['end'],
  //                 'date': day,
  //                 'nearest_day': nearestDayTimestamp,
  //                 'branch_id': branch,
  //                 'pId': FirebaseAuth.instance.currentUser!.uid,
  //                 'max_users': maxUsers,
  //               });
  //               await FirebaseFirestore.instance
  //                   .collection('admins')
  //                   .doc(FirebaseAuth.instance.currentUser!.uid)
  //                   .collection('schedules')
  //                   .doc(day)
  //                   .collection('schedules')
  //                   .doc(scheduleDoc.id)
  //                   .collection('users')
  //                   .doc(coach.uId)
  //                   .set({
  //                 'name': coach.name,
  //                 'uid': coach.uId,
  //                 'finished': false,
  //               });
  //
  //               await scheduleDoc.update({
  //                 'usersList': FieldValue.arrayUnion([coach.name]),
  //                 'userIds': FieldValue.arrayUnion([coach.uId]),
  //               });
  //
  //               await FirebaseFirestore.instance
  //                   .collection('users')
  //                   .doc(coach.uId)
  //                   .collection('schedules')
  //                   .doc(scheduleDoc.id)
  //                   .set({
  //                 'start_time': nonNullableDays[day]!['start'],
  //                 'end_time': nonNullableDays[day]!['end'],
  //                 'date': day,
  //                 'nearest_day': nearestDayTimestamp,
  //                 'branch_id': branch,
  //                 'pId': FirebaseAuth.instance.currentUser!.uid,
  //                 'scheduleId': scheduleDoc.id,
  //                 'max_users': maxUsers,
  //               });
  //             }
  //           }
  //
  //           await scheduleDoc.update({
  //             'schedule_id': scheduleDoc.id,
  //           });
  //
  //           schedule = SchedulesModel(
  //             startTime: nonNullableDays[day]!['start'],
  //             endTime: nonNullableDays[day]!['end'],
  //             date: day,
  //             nearestDay: nearestDayTimestamp,
  //             branchId: branch,
  //             users: selectedCoaches,
  //             usersList:
  //                 selectedCoaches?.map((coach) => coach.name).toList() ?? [],
  //             userIds:
  //                 selectedCoaches?.map((coach) => coach.uId).toList() ?? [],
  //             scheduleId: scheduleDoc.id,
  //             finished: false,
  //             pId: FirebaseAuth.instance.currentUser!.uid,
  //             maxUsers: maxUsers,
  //           );
  //         });
  //       }
  //     }
  //     ManageSalaryCubit.get(context).updateSchedules(schedule!);
  //     // if (isEmit) {
  //     // emit(AddScheduleSuccessState());
  //     emit(state.copyWith(loading: false));
  //     Fluttertoast.showToast(
  //         msg: 'تم إضافة المواعيد بنجاح',
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 5,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //     // }
  //   } catch (e) {
  //     // if (isEmit) emit(AddScheduleErrorState(e.toString()));
  //     emit(state.copyWith(loading: false));
  //     Fluttertoast.showToast(
  //         msg: 'حدث خطأ أثناء إضافة المواعيد\n${e.toString()}',
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 5,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //     // }
  //   }
  // }

  DateTime getNearestDayOfWeek(String dayOfWeek) {
    // Get the current date
    DateTime now = DateTime.now();

    // Get the integer value of the selected day of the week
    int selectedDayOfWeek = [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ].indexOf(dayOfWeek);

    // Calculate the difference between the selected day of the week and the current day of the week
    int difference = selectedDayOfWeek - now.weekday;

    // If the difference is negative, add 7 to get the nearest day of the week
    if (difference < 0) {
      difference += 7;
    }

    // Add the difference to the current date to get the nearest day of the week
    DateTime nearestDay = now.add(Duration(days: difference));

    return nearestDay;
  }

  void updateTime2(String day, TimeOfDay startTime) {
    _times[day]?['start'] = startTime;
    _times[day]?['end'] = startTime.replacing(hour: startTime.hour + 1);
    emit(state.copyWith(times: _times));
  }
  // setState(() {
  //   if (widget.isCoach) {
  //     _selectedCoachesUids = users.map((e) => e.uId!).toList();
  //   } else {
  //     _selectedUsersUids = users.map((e) => e.uId!).toList();
  //   }
  //   // _selectedCoaches = users;
  // });

  void setSelectedCoaches(List<UserModel> users) {
selectedCoachesUids = users.map((e) => e.uId!).toList();
    selectedCoaches = users;
    emit(state.copyWith(selectedCoaches: users));
  }

  void setSelectedUsers(List<UserModel> users) {
    selectedUsersUids = users.map((e) => e.uId!).toList();
    selectedUsers = users;
    emit(state.copyWith(selectedUsers: users));
  }

  void updateQuery(Query query) {
    usersQuery = query;
    emit(state.copyWith(query: query));
  }

  void updateMaxUsers(int parse) {
    maxUsers = parse.toString();
    emit(state.copyWith(maxUsers: parse.toString()));
  }
}

class AddGroupState {
   List<UserModel> selectedUsers;
   List<UserModel> selectedCoaches;
  final List<String> selectedTimes;
  final String selectedBranch;
  final String selectedOption;
  final int currentIndex;
  final List<Widget> screens;
  final String? searchQuery;
  final List<UserModel> selectedUsersUids;
  final Map<String, Map<dynamic, dynamic>> times;
  final bool loading;
  final Query? query;
  final String? maxUsers;

  AddGroupState({
    this.maxUsers,
    this.query ,
    this.selectedUsers = const [],
    this.selectedCoaches = const [],
    this.selectedTimes = const [],
    this.selectedBranch = '',
    this.selectedOption = '',
    this.currentIndex = 0,
    required this.screens,
    this.searchQuery,
    this.selectedUsersUids = const [],
    this.times = const {
      'السبت': {'start': null, 'end': null},
      'الأحد': {'start': null, 'end': null},
      'الاثنين': {'start': null, 'end': null},
      'الثلاثاء': {'start': null, 'end': null},
      'الأربعاء': {'start': null, 'end': null},
      'الخميس': {'start': null, 'end': null},
      'الجمعة': {'start': null, 'end': null},
    },
    this.loading = false,
  });

  AddGroupState copyWith({
    List<UserModel>? selectedUsers,
    List<UserModel>? selectedCoaches,
    List<String>? selectedTimes,
    String? selectedBranch,
    String? selectedOption,
    int? currentIndex,
    String? searchQuery,
    List<String>? selectedUsersUids,
    Map<String, Map>? times,
    bool? loading, Query? query, String? maxUsers,
  }) {
    return AddGroupState(      query: query ?? this.query,
      selectedUsers: selectedUsers ?? this.selectedUsers,
      selectedCoaches: selectedCoaches ?? this.selectedCoaches,
      selectedTimes: selectedTimes ?? this.selectedTimes,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      selectedOption: selectedOption ?? this.selectedOption,
      currentIndex: currentIndex ?? this.currentIndex,
      screens: this.screens,
      searchQuery: searchQuery ?? this.searchQuery,
   //   selectedUsersUids: selectedUsersUids ?? this.selectedUsersUids,
      times: times ?? this.times,
      loading: loading ?? this.loading,
      maxUsers: maxUsers ?? this.maxUsers,
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // int _currentIndex = 0;

  // List<Widget> _screens = [
  //   SelectCoachesScreen(
  //     isCoach: true,
  //   ),
  //   SelectCoachesScreen(
  //     isCoach: false,
  //   ),
  //   Screen2(),
  //   SelectBranchScreen(),
  //   InfoScreen()
  // ];

  // void _next() {
  //   setState(() {
  //     _currentIndex++;
  //   });
  // }

  // void _previous() {
  //   setState(() {
  //     _currentIndex--;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
//         text: 'Add group of schedules',
        //traanslate the text to arabic
        text: 'اضافة مجموعة',
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                //delete borders
                //  decoration: BoxDecoration(
                //    border: Border.all(
                //      color: Colors.white,
                //    ),
                //  ),
                height: 650.h,
                width: double.infinity,
                child: Theme(
                  data: ThemeData(
                    canvasColor: Colors.white,
                    switchTheme: SwitchThemeData(
                      thumbColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      trackColor: MaterialStateProperty.all(
                        Colors.grey,
                      ),
                    ),
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                        //  primary: Colors.purple,
                        //disabledColor: Colors.purple,
                        //  background: Colors.white,
                        // secondary: Colors.purple,
                        ),
                    //change stepper color only
                    //primaryColor: Colors.purple,
                    //change the color of the text in the stepper
                  ),
                  child: Container(
                    //delete borders
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Stepper(
                      onStepContinue: //use AddGroupCubit
                          () {
                        context.read<AddGroupCubit>().nextScreen();
                      },
                      onStepCancel: //use AddGroupCubit
                          () {
                        context.read<AddGroupCubit>().previousScreen();
                      },
                      onStepTapped: (index) {
                        context.read<AddGroupCubit>().setCurrentIndex(index);
                      },
                      //handle navigation with swiping
                      physics: ClampingScrollPhysics(),
                      stepIconBuilder: (stepIndex, stepState) {
                        //change the icon of the step
                        if (stepState == StepState.complete) {
                          return

                              ///home/elreefy14/admin14/admin_future/assets/images/Group 1.svg
                              Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                              //make thick white border
                              border: Border.all(
                                color: Colors.white,
                                width: 2.5,
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/images/check.svg',
                              color: Colors.white,
                            ),
                          );
                        } else if (stepState == StepState.indexed) {
                          //assets/images/emty14.svg
                          return Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: Colors.white,
                                //make thick white border
                                border: Border.all(
                                  // color: Colors.white,
                                  width: .1,
                                ),
                              ),
                              child: Container(
                                width: 40.w,
                                //shape circke to make the icon in circle
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.all(1),
                                //padding: EdgeInsets.all(5),
                                //shape circke to make the icon in circle
                                //color: Colors.white,
                              ));
                        } else if (stepState == StepState.editing) {
                          return Container(
                            //shape circke to make the icon in circle
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/Group 1.svg',
                              color: Colors.purple,
                            ),
                          );
                        } else {
                          //this example, we add an assertion to make sure that the hour value is not null and is within the valid range of 0 to 23. If the assertion fails, an error will be thrown. If the assertion pass
                          return Text(
                            '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Montserrat-Arabic',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          );
                        }
                      },

                      type: StepperType.horizontal,
                      currentStep:
                          context.watch<AddGroupCubit>().state.currentIndex,
                      steps: context
                          .watch<AddGroupCubit>()
                          .state
                          .screens
                          .asMap()
                          .map((index, screen) => MapEntry(
                              index,
                              Step(
                                title: Text(''),
                                isActive: context
                                        .watch<AddGroupCubit>()
                                        .state
                                        .currentIndex >=
                                    index,
                                state: context
                                            .watch<AddGroupCubit>()
                                            .state
                                            .currentIndex ==
                                        index
                                    ? StepState.editing
                                    : context
                                                .watch<AddGroupCubit>()
                                                .state
                                                .currentIndex >
                                            index
                                        ? StepState.complete
                                        : StepState.indexed,
                                content: SizedBox(
                                    height: 900.h,
                                    width: double.infinity,
                                    child: screen),
                              )))
                          .values
                          .toList(),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: _screens[_currentIndex],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (context.watch<AddGroupCubit>().state.currentIndex > 0)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0.w,
                      ),
                      child: InkWell(
                        onTap: context.watch<AddGroupCubit>().previousScreen,
                        child: Container(
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'السابق',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Montserrat-Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0.08,
                                ),
                              )),
                        ),
                      ),
                    ),
                  //if current index is last index 'حفظ',

                  if (context.watch<AddGroupCubit>().state.currentIndex ==
                      context.watch<AddGroupCubit>().state.screens.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0.w,
                      ),
                      child: InkWell(
                        onTap: () {
                          print('save');
                          //print all   context.watch<AddGroupCubit>().state.times,
                          print(
                              'Selected Times: ${context.read<AddGroupCubit>().state.times}');
                          //
                          //select the users from screen 3
                          //   print(_Screen3State()._selectedUsers.length);
                          //print all selected users data
                          //   print('Selected Users: ${_Screen3State()._selectedUsers}');
                          //Provider.of<AddGroupCubit>(context, listen: false);
                          context.read<AddGroupCubit>().addGroup(
                                true,
                                context,
                                selectedUsers: context
                                    .read<AddGroupCubit>()
                                    .state
                                    .selectedUsers,
                                selectedCoaches: context
                                    .read<AddGroupCubit>()
                                    .state
                                    .selectedCoaches,
                                startTrainingTime: //random time
                                    Timestamp.now(),
                                endTrainingTime: //random time
                                    Timestamp.now(),
                                branch:
                                ManageAttendenceCubit.get(context)
                                .selectedBranch??'',
                                // 'error',
                                times: //call the times map from screen 2
                                    context.read<AddGroupCubit>().state.times,
                                //TODO :fix this error
                                // {
                                //   'السبت': {'start': TimeOfDay.now(), 'end': TimeOfDay.now()},
                                //  },
                                maxUsers: context.read<AddGroupCubit>().state.maxUsers,
                              );
//clr   context.read<AddGroupCubit>().state.times,
                          context.read<AddGroupCubit>().state.times.clear();
                        },
                        child: BlocBuilder<AddGroupCubit, AddGroupState>(
                          builder: (context, state) {
                            return state.loading
                                ? CircularProgressIndicator()
                                : Container(
                                    height: 50.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Text(
                                          'حفظ',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Montserrat-Arabic',
                                            fontWeight: FontWeight.w400,
                                            height: 0.08,
                                          ),
                                        )),
                                  );
                          },
                        ),
                      ),
                    ),

                  if (context.watch<AddGroupCubit>().state.currentIndex <
                      context.watch<AddGroupCubit>().state.screens.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: context.watch<AddGroupCubit>().nextScreen,
                        child: Container(
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'التالي',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Montserrat-Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0.08,
                                ),
                              )),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//assets/images/delete-2_svgrepo.com.svg
class Screen2 extends StatelessWidget {
  // static final Map<String, Map<dynamic, dynamic>> _times = {
  //   'السبت': {'start': null, 'end': null},
  //   'الأحد': {'start': null, 'end': null},
  //   'الاثنين': {'start': null, 'end': null},
  //   'الثلاثاء': {'start': null, 'end': null},
  //   'الأربعاء': {'start': null, 'end': null},
  //   'الخميس': {'start': null, 'end': null},
  //   'الجمعة': {'start': null, 'end': null},
  // };
  // Map<String, Map<dynamic, dynamic>> get times => _times;

  @override
  Widget build(BuildContext context) {
    dynamic _times = context.watch<AddGroupCubit>().times;
    return ListView(
      children: context.read<AddGroupCubit>().times.keys.map((day) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '/$day',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
          subtitle: Column(
            children: [
              //10
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      TimeOfDay? endTime = await showTimePicker(
                        context: context,
                        initialTime: _times[day]?['end'] ?? TimeOfDay.now(),
                      );
                      if (endTime != null) {
                        // setState(() {
                        //   //
                        //   _times[day]?['end'] = endTime;
                        //   //start time equal hour minus end time
                        //   _times[day]?['start'] =
                        //       endTime.replacing(hour: endTime.hour - 1);
                        // });
                        context.read<AddGroupCubit>().updateTime(day, endTime);
                      }
                    },
                    child: Container(
                      width: 125.w,
                      height: 35.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text(
                        // _times[day]?['end']?.format(context) ?? 'نهاية التدريب',
                        //make it in arabic like that 11 ص
                        _times[day]?['end']
                                ?.format(context)
                                .toString()
                                .replaceAll('PM', 'م')
                                .replaceAll('AM', 'ص') ??
                            'نهاية التدريب',

                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 16.sp,
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 8.0),
                      Text(
                        '-',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      InkWell(
                        onTap: () async {
                          TimeOfDay? startTime = await showTimePicker(
                            context: context,
                            initialTime:
                                _times[day]?['start'] ?? TimeOfDay.now(),
                          );
                          if (startTime != null) {
                            // setState(() {
                            //   //convert start time to time stamp

                            //   _times[day]?['start'] = startTime;
                            //   //end time equal hour plus start time
                            //   TimeOfDay endTime =
                            //       startTime.replacing(hour: startTime.hour + 1);
                            //   _times[day]?['end'] = endTime;
                            //   //save the start time as timeStamp get

                            //   //  DateTime getNearestDayOfWeek(String dayOfWeek) {
                            //   // Get the current date
                            //   //   DateTime now = DateTime.now();

                            //   //   // Get the integer value of the selected day of the week
                            //   //   int selectedDayOfWeek = [
                            //   //     'الأحد',
                            //   //     'الاثنين',
                            //   //     'الثلاثاء',
                            //   //     'الأربعاء',
                            //   //     'الخميس',
                            //   //     'الجمعة',
                            //   //     'السبت'
                            //   //   ].indexOf(dayOfWeek);

                            //   //   // Calculate the difference between the selected day of the week and the current day of the week
                            //   //   int difference = selectedDayOfWeek - now.weekday;

                            //   //   // If the difference is negative, add 7 to get the nearest day of the week
                            //   //   if (difference < 0) {
                            //   //     difference += 7;
                            //   //   }

                            //   //   // Add the difference to the current date to get the nearest day of the week
                            //   //   DateTime nearestDay = now.add(Duration(days: difference));

                            //   //   return nearestDay;
                            //   // }
                            // });
                            context
                                .read<AddGroupCubit>()
                                .updateTime2(day, startTime);
                          }
                        },
                        child: Container(
                          width: 125.w,
                          height: 35.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF6F6F6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Text(
                            // _times[day]?['start']?.format(context) ?? 'بداية التدريب',
                            //make it in arabic like that 11 ص
                            _times[day]?['start']
                                    ?.format(context)
                                    .toString()
                                    .replaceAll('PM', 'م')
                                    .replaceAll('AM', 'ص') ??
                                'بداية التدريب',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 16.sp,
                              fontFamily: 'IBM Plex Sans Arabic',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // onTap: () async {
          //   TimeOfDay? startTime = await showTimePicker(
          //     context: context,
          //     initialTime: _times[day]?['start'] ?? TimeOfDay.now(),
          //   );
          //   if (startTime != null) {
          //     TimeOfDay? endTime = await showTimePicker(
          //       context: context,
          //       initialTime: _times[day]?['end'] ?? TimeOfDay.now(),
          //     );
          //     setState(() {
          //       _times[day]?['start'] = startTime;
          //       if (endTime != null) {
          //         _times[day]?['end'] = endTime;
          //       }
          //     });
          //   }
          // },
        );
      }).toList(),
    );
  }
}

class SelectCoachesScreen extends StatelessWidget {
  final bool isCoach;

   SelectCoachesScreen({super.key, required this.isCoach});
  final TextEditingController _searchController = TextEditingController();

  // Future<void> _onSearchSubmitted(String value) async {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AddGroupCubit, AddGroupState>(
      builder: (context, state) {
        // if(widget.isCoach) {
        //   print('is coach');
        //   print(widget.isCoach);
        //   context.read<AddGroupCubit>().updateQuery(FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'coach'));
        // } else {
        //   print('is coach');
        //   print(widget.isCoach);
        //   context.read<AddGroupCubit>().updateQuery(FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'user'));
        // }
       // print('hjh' + widget.isCoach.toString());
       // print(widget.isCoach);
        return Column(
          children: [
            /*
        Text(
    'المدربين:',
    style: TextStyle(
        color: Color(0xFF333333),
        fontSize: 14,
        fontFamily: 'IBM Plex Sans Arabic',
        fontWeight: FontWeight.w400,
        height: 0,
    ),
)
//50

        */
            //50
            SizedBox(
              height: 40.h,
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Text(
                isCoach ? 'المدربين' : 'الطلاب',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  // added this line
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if(isCoach) {
                  print('is coach');
                  print(isCoach);
                  context.read<AddGroupCubit>().updateQuery(FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'coach'));
                } else {
                  print('is coach');
                  print(isCoach);
                  context.read<AddGroupCubit>().updateQuery(FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'user'));
                }
                showDialog(
                  context: context,
                  builder: (context) => ShowCoachesInDialog(
                    isCoach: isCoach ?? true,
                    selectedUsers: isCoach
                        ? context.read<AddGroupCubit>().state.selectedCoaches
                        : context.read<AddGroupCubit>().state.selectedUsers,
                    onSelectedUsersChanged: (users) {
                      // setState(() {
                      //   if (widget.isCoach) {
                      //     _selectedCoachesUids = users.map((e) => e.uId!).toList();
                      //   } else {
                      //     _selectedUsersUids = users.map((e) => e.uId!).toList();
                      //   }
                      //   // _selectedCoaches = users;
                      // });
                      // if (widget.isCoach) {
                      //
                      //   context.read<AddGroupCubit>().setSelectedCoaches(users);
                      // } else {
                      //   context.read<AddGroupCubit>().setSelectedUsers(users);
                      // }
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 280.w,
                    height: 48.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 11.30,
                          child: Icon(
                            Icons.arrow_drop_down,
                            // size: 20.sp,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              isCoach ? 'اختر المدربين' : 'اختر الطلاب',
                              // 'اختر المدربين',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 16.sp,
                                fontFamily: 'IBM Plex Sans Arabic',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => //5
                  SizedBox(
                height: 10.h,
              ),
              shrinkWrap: true,
              itemCount: isCoach
                  ? state.selectedCoaches.length
                  : state.selectedUsers.length,
              //     _selectedCoaches.length,
              itemBuilder: (context, index) {
                late UserModel user;
                if (isCoach == true)
                  user = state.selectedCoaches[index];
                else
                  user = state.selectedUsers[index];
                return Container(
                  width: 360,
                  height: 25,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            //svg image delete which is svg image images/delete-2_svgrepo.com.svg
                            InkWell(
                                onTap: () {
                                  if (isCoach) {
                                    // setState(() {
                                    //   _selectedCoaches.remove(user);
                                    //   _selectedCoachesUids.remove(user.uId!);
                                    // });
                                    context
                                        .read<AddGroupCubit>()
                                        .deselectCoach(user);
                                  } else {
                                    // setState(() {
                                    //   _selectedUsers.remove(user);
                                    //   _selectedUsersUids.remove(user.uId!);
                                    // });
                                    context
                                        .read<AddGroupCubit>()
                                        .deselectUser(user);
                                  }
                                },
                                child: SvgPicture.asset(
                                    'assets/images/delete-2_svgrepo.com.svg')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                //   '${user.name}-${index + 1}',
                                //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                                '${index + 1}-${user.name}',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat-Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class SelectBranchScreen extends StatefulWidget {
  @override
  _SelectBranchScreenState createState() => _SelectBranchScreenState();
}

class _SelectBranchScreenState extends State<SelectBranchScreen> {
  final _formKey = GlobalKey<FormState>();
  //static String? _maxUsers;
  //getter
 // String? get maxUsers => _maxUsers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(
      //    title: Text('Select Branch'),
      //  ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Text(
                ':اقصى عدد للمتدربين',
                //make it in arabic align right
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                width: 150,
                height: 48,
                //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   // اقصى عدد
                    //   ':اقصى عدد',
                    //   style: TextStyle(
                    //     color: Color(0xFF666666),
                    //     fontSize: 16,
                    //     fontFamily: 'IBM Plex Sans Arabic',
                    //     fontWeight: FontWeight.w400,
                    //     height: 0,
                    //   ),
                    // ),
                    Flexible(
                      child: TextFormField(
                        //rtl
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          context
                              .read<AddGroupCubit>()
                              .updateMaxUsers(int.parse(value));

                        },
                        decoration: InputDecoration(
                          hintText: '              :اقصى عدد',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'مكان التدريب:',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            //SizedBox(height: 5.0.h),
            // List<String> items = ['Item 1', 'Item 2', 'Item 3'];

            BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
              builder: (context, state) {
                return ManageAttendenceCubit.get(context).branches == null
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        // height: 200.h,
                        child: CheckboxListWidget(
                          onBranchSelected: (branch) {
                            // setState(() {
                            //   print('selected branch: $branch');
                            //   selectedBranch = branch;
                            // });
                            ManageAttendenceCubit.get(context)
                                .updateSelectedBranch(branch);
                          },
                          items:
                              ManageAttendenceCubit.get(context).branches ?? [],
                        ),
                      );
              },
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     if (_formKey.currentState!.validate()) {
            //       _formKey.currentState!.save();
            //       // Do something with _maxUsers
            //       Navigator.pop(context);
            //     }
            //   },
            //   child: Text('Save'),
            // ),
          ],
        ),
      ),
    );
  }
}

//info sceen
//make screen contat listofusers aand list of coaches and list of times and selectedBranch
//and maxUsers
class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupCubit, AddGroupState>(
  builder: (context, state) {
    //context.read<AddGroupCubit>() . make object from cubit
    final addGroupCubit = context.read<AddGroupCubit>();
    return Column(
      children: [
        state.selectedCoaches.isNotEmpty
            ?  Column(
    children: [
      SizedBox(
      height: 20.h,
    ),
    Align(
    alignment: AlignmentDirectional.topEnd,
    child: Text(
    ':المدربين',
    style: TextStyle(
    color: Color(0xFF333333),
    fontSize: 14,
    fontFamily: 'IBM Plex Sans Arabic',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    ),
    ],
    )
            : SizedBox(),

        // SizedBox(
        //   height: 10.h,
        // ),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => //5
              SizedBox(
            height: 10.h,
          ),
          shrinkWrap: true,
          itemCount: context.read<AddGroupCubit>().state.selectedCoaches.length,
          itemBuilder: (context, index) {
            final user =
                context.read<AddGroupCubit>().state.selectedCoaches[index];
            return Container(
              width: 360,
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        //svg image delete which is svg image images/delete-2_svgrepo.com.svg
                        InkWell(
                            onTap: () {
                              //   setState(() {
                              //     _SelectCoachesScreenState()
                              //         .selectedCoaches
                              //         .remove(user);
                              //   });
                              // },
                              context.read<AddGroupCubit>().deselectCoach(user);
                            },
                            child: SvgPicture.asset(
                                'assets/images/delete-2_svgrepo.com.svg')),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${index + 1}-${user.name}',
                            //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Montserrat-Arabic',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        state.selectedUsers.isNotEmpty?

        Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Text(
                ':الطلاب',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ):SizedBox(),

        ListView.separated(
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => //5
              SizedBox(
            height: 10.h,
          ),
          shrinkWrap: true,
          itemCount: context.read<AddGroupCubit>().state.selectedUsers.length,
          itemBuilder: (context, index) {
            final user =
                context.read<AddGroupCubit>().state.selectedUsers[index];
            return Container(
              width: 360,
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        //svg image delete which is svg image images/delete-2_svgrepo.com.svg
                        InkWell(
                            onTap: () {
                              // setState(() {
                              //   _SelectCoachesScreenState()
                              //       .selectedUsers
                              //       .remove(user);
                              // });
                              context.read<AddGroupCubit>().deselectUser(user);
                            },
                            child: SvgPicture.asset(
                                'assets/images/delete-2_svgrepo.com.svg')),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${index + 1}-${user.name}',
                            //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Montserrat-Arabic',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        //Text(
        //     'اقصى عدد للمتدربين: ',
        //     style: TextStyle(
        //         color: Color(0xFF333333),
        //         fontSize: 14,
        //         fontFamily: 'IBM Plex Sans Arabic',
        //         fontWeight: FontWeight.w400,
        //         height: 0,
        //     ),
        // )
        SizedBox(
          height: 20.h,
        ),
        // Text(
        //   'اقصى عدد للمتدربين: ${_SelectBranchScreenState().maxUsers}',
        //   textAlign: TextAlign.right,
        //   style: TextStyle(
        //     color: Color(0xFF333333),
        //     fontSize: 14,
        //     fontFamily: 'IBM Plex Sans Arabic',
        //     fontWeight: FontWeight.w400,
        //     height: 0,
        //   ),
        // ),
        state.maxUsers != null
            ? Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Text(
                      ':اقصى عدد للمتدربين',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${state.maxUsers} اقصى عدد للمتدربين',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Montserrat-Arabic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              )
            : SizedBox(),

//
//
//                         '${ManageAttendenceCubit.get(context).selectedBranch}',

        BlocBuilder< ManageAttendenceCubit, ManageAttendenceState>(
  builder: (context, state) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Text(
            //:مكان التدريب'
            ':مكان التدريب',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 14,
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                ' ${ManageAttendenceCubit.get(context).selectedBranch} ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Montserrat-Arabic',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  },
),
        //${ManageAttendenceCubit.get(context).selectedBranch}


        //Text(
        // 'التوقيات:',
        // style: TextStyle(
        //     color: Color(0xFF333333),
        //     fontSize: 14,
        //     fontFamily: 'IBM Plex Sans Arabic',
        //     fontWeight: FontWeight.w400,
        //     height: 0,
        // ),
        //)
//show times like that
//Text(
//     'الاحد ',
//     textAlign: TextAlign.right,
//     style: TextStyle(
//         color: Colors.black,
//         fontSize: 12,
//         fontFamily: 'Montserrat-Arabic',
//         fontWeight: FontWeight.w300,
//         height: 0,
//     ),
// )
// Text(
//     '11:00AM - 12:00AM',
//     textAlign: TextAlign.right,
//     style: TextStyle(
//         color: Colors.black,
//         fontSize: 12,
//         fontFamily: 'Montserrat-Arabic',
//         fontWeight: FontWeight.w400,
//         height: 0,
//     ),
// ),
        SizedBox(
          height: 20.h,
        ),
state.times.isEmpty?SizedBox():
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  ':التوقيات',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14,
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => //5
              SizedBox(
                height: 10.h,
              ),
              shrinkWrap: true,
              itemCount: context.read<AddGroupCubit>().times.length,
              itemBuilder: (context, index) {
                final day =
                context.read<AddGroupCubit>().times.keys.toList()[index];
                final time = context.read<AddGroupCubit>().times[day];
                return
                  //if day is null return empty container
                  time?['start'] == null
                      ? Container()
                      : Container(
                    width: 360.w,
                    height: 50.h,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$day',
                          //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Montserrat-Arabic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${time?['start']?.format(context).toString().replaceAll('PM', 'م').replaceAll('AM', 'ص')} - ${time?['end']?.format(context).toString().replaceAll('PM', 'م').replaceAll('AM', 'ص')}',
                                //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat-Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              },
            ),
          ],
        ),

      ],
    );
  },
);
  }
}
//
// class Screen1 extends StatefulWidget {
//   @override
//   _Screen1State createState() => _Screen1State();
// }
//
// class _Screen1State extends State<Screen1> {
//   // final TextEditingController _searchController = TextEditingController();
//   // Query? _query;
//   // Query? _query2;
//   // //onSubmitted
//   // String? onSubmitted;
//
//   // List<UserModel> _selectedUsersUids = [];
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _query = FirebaseFirestore.instance.collection('users');
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddGroupCubit, AddGroupState>(
//       builder: (context, state) {
//         return Center(
//           child: ElevatedButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: Text('Select Users'),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         TextField(
//                           //make input from right to left
//                           textDirection: TextDirection.rtl,
//
//                           controller: context.read<AddGroupCubit>()._searchController,
//                           decoration: InputDecoration(
//                             hintText: 'Search by name',
//                           ),
//                           onSubmitted: (onSubmitted) {
//                             setState(() {
//                               onSubmitted = onSubmitted.trim();
//                               context.read<AddGroupCubit>()._query
//                               = FirebaseFirestore.instance
//                                   .collection('users')
//                                   .where('name',
//                                   isGreaterThanOrEqualTo: onSubmitted)
//                                   .where('name', isLessThan: onSubmitted + 'z');
//                               context.read<AddGroupCubit>()._query2
//                               = FirebaseFirestore.instance
//                                   .collection('users')
//                                   .where('phone',
//                                   isGreaterThanOrEqualTo: onSubmitted)
//                                   .where('phone', isLessThan: onSubmitted + 'z');
//                             });
//                           },
//                           onChanged: (value) {
//                             setState(() {
//                               value = value.trim();
//                               context.read<AddGroupCubit>()._query
//                               = FirebaseFirestore.instance
//                                   .collection('users')
//                                   .where('name', isGreaterThanOrEqualTo: value)
//                                   .where('name', isLessThan: value + 'z');
//                               context.read<AddGroupCubit>()._query2
//                               = FirebaseFirestore.instance
//                                   .collection('users')
//                                   .where('phone', isGreaterThanOrEqualTo: value)
//                                   .where('phone', isLessThan: value + 'z');
//                             });
//                           },
//                         ),
//                         Expanded(
//                           child: FirestoreListView(
//                             cacheExtent: 300,
//                             pageSize: 5,
//                             query: context.read<AddGroupCubit>()._query ?? context.read<AddGroupCubit>()._query2!,
//                             itemBuilder: (context, snapshot) {
//                               final data = snapshot.data() as Map<String, dynamic>;
//                               UserModel user = UserModel(
//                                 name: data['name'],
//                                 email: data['email'],
//                                 level: data['level'],
//                                 hourlyRate: data['hourlyRate'],
//                                 totalHours: data['totalHours'],
//                                 totalSalary: data['totalSalary'],
//                                 currentMonthHours: data['currentMonthHours'],
//                                 currentMonthSalary: data['currentMonthSalary'],
//                                 uId: snapshot.id,
//                                 phone: data['phone'],
//                               );
//                               final selected = context
//                                   .read<AddGroupCubit>()
//                                   ._selectedUsersUids
//                                   .contains(user);
//                               return CheckboxListTile(
//                                 title: Text(user.name ?? ''),
//                                 subtitle: Text(user.phone ?? ''),
//                                 value: selected,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     if (value == true) {
//                                       context
//                                           .read<AddGroupCubit>()
//                                           ._selectedUsersUids
//                                           .add(user);
//                                       //use logger to print the selected users
//                                       // Logger.root.info(
//                                       //    'Selected Users: $_selectedUsersUids');
//                                     } else {
//                                       context
//                                           .read<AddGroupCubit>()
//                                           ._selectedUsersUids
//                                           .remove(user);
//                                       // Logger.root.info(
//                                       //      'Selected Users: $_selectedUsersUids');
//                                     }
//                                   });
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           //clear the search controller
//                           context.read<AddGroupCubit>()._searchController.clear();
//                         },
//                         child: Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // Add your logic for selecting users here
//                           //print('Selected Users: $_selectedUsersUids');
//                           Navigator.of(context).pop();
//                           //clear the search controller
//                           context.read<AddGroupCubit>()._searchController.clear();
//                         },
//                         child: Text('Select'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text('Select Users'),
//           ),
//         );
//       },
//     );
//   }
// }