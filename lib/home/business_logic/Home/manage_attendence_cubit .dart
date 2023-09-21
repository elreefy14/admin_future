//import 'package:connectivity/connectivity.dart';
import 'dart:math';
//import 'package:firestore_cache/firestore_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/flutter_flow/flutter_flow_util.dart';
import '../../../registeration/data/userModel.dart';
import 'manage_attendence_state.dart';
import 'manage_salary_cubit.dart';
// ****this is my firestore Collections and Documents:**
// - *users*: A collection to store the information of all coaches.
// - Document ID: unique coach ID
// - Fields: *`name`, *`level`*, *`hourly_rate`*, *`total_hours`*, *`total_salary`*, *`current_month_hours`*, *`current_month_salary`**
//  *admins*: A collection to store the information of all admins.
//  - Document ID: unique admin ID
//  - Fields: *`name`, *`email`*, *`branch_id`** (the ID of the branch they're responsible for)
// - Subcollection: *`schedules`*
// - Document ID: unique schedule ID
// - Fields: *`branch_id`, *`start_time`*, *`end_time`*, *`date`*, *`finished`**

// - *branches*: A collection to store the information of all branches.
// - Document ID: unique branch ID
// - Fields: *`name`, *`address`**
// - Subcollection: *`coaches`*
// - Document ID: unique coach ID who works at this branch
//
// -
// - *schedules*: A collection to store the information of all schedules.
// - Document ID: unique schedule ID
// - Fields: *`branch_id`, *`start_time`*, *`end_time`*, *`date`**
// - Subcollection: *`attendance`*
// - Document ID: unique attendance ID (usually just the coach ID)
// - Fields: *`attended`, *`qr_code`**

class ManageAttendenceCubit extends Cubit<ManageAttendenceState> {
  ManageAttendenceCubit() : super(InitialState()) {
  }
  static ManageAttendenceCubit get(context) => BlocProvider.of(context);
  // function to get string
//     // get the nearest schedule to the current timw using utc time
//      //schedulesList is a list of all schedules for the current day which is stored descendingly
//      //loop on the list and check if the current time is less than the start time of the schedule
//       //if it is less than the start time then this is the nearest schedule
//       //if it is not less than the start time then check if it is less than the end time
  //use utc time
  //use catch error to catch the error
  //use emit to emit the state

  Map<String, dynamic>? nearestSchedule;
  static List<Map<String, dynamic>> schedulesList = [];
  List<Map<String, dynamic>> schedulesList2 = [];
 // Subcollection: *`schedules`*
// - Document ID: unique schedule ID
// - Fields: *`branch_id`, *`start_time`*, *`end_time`*, *`date`*, *`finished`**
  Future<void> getNearestSchedule() async {
    try {
      emit(GetNearestScheduleLoadingState());

      final DateTime now = DateTime.now();
      final String today = getdayinArabic();
      final schedulesCollection = FirebaseFirestore.instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('schedules')
          .doc(today)
          .collection('schedules');

      final QuerySnapshot snapshot = await schedulesCollection
          .orderBy('start_time', descending: false)
          .get();

      List<Map<String, dynamic>> schedulesList = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      for (final Map<String, dynamic> schedule in schedulesList) {
        final DateTime utcStartTime = schedule['start_time'].toDate().toUtc();
        final DateTime utcEndTime = schedule['end_time'].toDate().toUtc();

        final DateTime utcNow = DateTime.utc(now.year, now.month, now.day, now.hour, now.minute, now.second);

        if (utcNow.isBefore(utcStartTime)) {
          nearestSchedule = schedule;
          break;
        } else if (utcNow.isAfter(utcStartTime) && utcNow.isBefore(utcEndTime)) {
          nearestSchedule = schedule;
          break;
        }
      }

      if (nearestSchedule != null) {
        print('nearestSchedule:\n\n\n ');
       // print(nearestSchedule['start_time'].toDate().toUtc());
      }

      emit(GetNearestScheduleSuccessState(
       // nearestSchedule,
      ));
    } catch (e) {
      print('Error in getNearestSchedule()\n\n\n\n');
      print(e.toString());
      emit(GetNearestScheduleErrorState(e.toString()));
    }
  }

  Map<String, dynamic>? firstSchedule; // Variable to store the first schedule

  Future<void> getSchedulesForAdmin() async {
    initializeDateFormatting();
    emit(GetSchedulesForAdminLoadingState());
    try {
      final DateTime now = DateTime.now();
      final DateTime startOfToday = DateTime(now.year, now.month, now.day);
      //  final schedulesCollection = FirebaseFirestore.instance
      //           .collection('admins')
      //           .doc(FirebaseAuth.instance.currentUser!.uid)
      //           .collection('schedules')
      //           .doc(today)
      //           .collection('schedules');
       final String today = getdayinArabic();
      final QuerySnapshot schedulesQuerySnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('schedules')
           .doc(today)
          .collection('schedules')
      // Start_time greater than or equal to yesterday 12:00 am and less than tomorrow 12:00 am
          .where('start_time', isGreaterThanOrEqualTo: startOfToday.toUtc())
          .where('start_time', isLessThan: startOfToday.add(const Duration(days: 1)).toUtc())
          .orderBy('start_time', descending: false)
          .get(
        const GetOptions(
          source: Source.serverAndCache,
        ),
      );

      for (final QueryDocumentSnapshot scheduleDoc in schedulesQuerySnapshot.docs) {
        final Map<String, dynamic> scheduleData =
        scheduleDoc.data() as Map<String, dynamic>;

        final QuerySnapshot usersQuerySnapshot = await scheduleDoc.reference
            .collection('users')
            .get(
          const GetOptions(
            source: Source.serverAndCache,
          ),
        );

        final List<Map<String, dynamic>> usersList = usersQuerySnapshot.docs
            .map<Map<String, dynamic>>(
              (QueryDocumentSnapshot documentSnapshot) =>
          documentSnapshot.data() as Map<String, dynamic>,
        )
            .toList();

        final Map<String, dynamic> scheduleWithUserData = {
          ...scheduleData,
          'users': usersList,
        };

        schedulesList.add(scheduleWithUserData);

      }

      emit(GetSchedulesForAdminSuccessState());
    } catch (e) {
      emit(GetSchedulesForAdminErrorState(e.toString()));
    }
  }
  // Future<void> getSchedulesForAdmin(SharedPreferences sharedPreferences) async {
  //   initializeDateFormatting();
  //   emit(GetSchedulesForAdminLoadingState());
  //   try {
  //     final DateTime now = DateTime.now();
  //     final String todayKey = 'schedules_${now.year}_${now.month}_${now.day}';
  //
  //     if (sharedPreferences.containsKey(todayKey)) {
  //       final String schedulesJson = sharedPreferences.getString(todayKey);
  //       // Convert schedulesJson to a List<Map<String, dynamic>> and use it as needed
  //       // You can skip the Firestore query and emit success state here
  //       emit(GetSchedulesForAdminSuccessState());
  //       return;
  //     }
  //
  //     final DateTime startOfToday = DateTime(now.year, now.month, now.day);
  //     final QuerySnapshot schedulesQuerySnapshot = await FirebaseFirestore.instance
  //         .collection('admins')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('schedules')
  //     // Start_time greater than or equal to yesterday 12:00 am and less than tomorrow 12:00 am
  //         .where('start_time', isGreaterThanOrEqualTo: startOfToday.toUtc())
  //         .where('start_time', isLessThan: startOfToday.add(const Duration(days: 1)).toUtc())
  //         .orderBy('start_time', descending: false)
  //         .get(
  //       const GetOptions(
  //         source: Source.serverAndCache,
  //       ),
  //     );
  //
  //     final List<Map<String, dynamic>> schedulesList = [];
  //
  //     for (final QueryDocumentSnapshot scheduleDoc in schedulesQuerySnapshot.docs) {
  //       final Map<String, dynamic> scheduleData = scheduleDoc.data() as Map<String, dynamic>;
  //
  //       final QuerySnapshot usersQuerySnapshot = await scheduleDoc.reference
  //           .collection('users')
  //           .get(
  //         const GetOptions(
  //           source: Source.serverAndCache,
  //         ),
  //       );
  //
  //       final List<Map<String, dynamic>> usersList = usersQuerySnapshot.docs
  //           .map<Map<String, dynamic>>(
  //             (QueryDocumentSnapshot documentSnapshot) =>
  //         documentSnapshot.data() as Map<String, dynamic>,
  //       )
  //           .toList();
  //
  //       final Map<String, dynamic> scheduleWithUserData = {
  //         ...scheduleData,
  //         'users': usersList,
  //       };
  //
  //       schedulesList.add(scheduleWithUserData);
  //     }
  //
  //     // After processing the schedulesList, store it in SharedPreferences
  //     final String schedulesJson = json.encode(schedulesList);
  //     await sharedPreferences.setString(todayKey, schedulesJson);
  //
  //     emit(GetSchedulesForAdminSuccessState());
  //   } catch (e) {
  //     emit(GetSchedulesForAdminErrorState(e.toString()));
  //   }
  // }

  void generateRandomData() async {
    print('Generating random data...');
    final CollectionReference adminsCollection =
    FirebaseFirestore.instance.collection('admins');
    final CollectionReference branchesCollection =
    FirebaseFirestore.instance.collection('branches');

    final List<String> adminNames = ['Alice', 'Bob', 'Charlie', 'David'];
    final List<String> branchNames = [
      'Branch A',
      'Branch B',
      'Branch C',
      'Branch D'
    ];
    final List<String> branchAddresses = [
      '123 Main St',
      '456 Elm St',
      '789 Oak St',
      '321 Pine St'
    ];

    final Random random = Random();

    // Get the admin with UID Oco5jDV6nkhA4jgkStLCTbiB2hJ3
    final QuerySnapshot adminSnapshot = await adminsCollection
        .where('id', isEqualTo: 'Oco5jDV6nkhA4jgkStLCTbiB2hJ3')
        .get();

    if (adminSnapshot.docs.length == 0) {
      return; // Admin not found
    }

    final DocumentReference adminDocRef = adminSnapshot.docs.first.reference;

    // Generate 2 random schedules for this admin
    for (int j = 0; j < 2; j++) {
      final int branchId = random.nextInt(4) + 1; // Random branch ID between 1-4
      final DateTime now = DateTime.now();
      final DateTime startDate =
      now.add(Duration(days: random.nextInt(7))); // Random start date within the next 7 days
      final DateTime endDate = startDate.add(Duration(
          hours: 4 + random.nextInt(4))); // Random end date within 4-7 hours of start date

      final Map<String, dynamic> scheduleData = {
        'branch_id': branchId,
        'start_time': Timestamp.fromDate(startDate),
        'end_time': Timestamp.fromDate(endDate),
        'date': Timestamp.fromDate(startDate),
        'finished': false,
      };

      final DocumentReference scheduleDocRef =
      await adminDocRef.collection('schedules').add(scheduleData);

      // Generate 3 random users for this schedule
      for (int k = 0; k < 3; k++) {
        final String name = 'User ${k + 1}';
        final int level = random.nextInt(3) + 1; // Random level between 1-3
        final int hourlyRate =
            10 + random.nextInt(20); // Random hourly rate between 10-30
        final int totalHours =
        random.nextInt(50); // Random total hours between 0-50
        final int currentMonthHours =
        random.nextInt(20); // Random current month hours between 0-20
        final int currentMonthSalary = currentMonthHours * hourlyRate;

        final Map<String, dynamic> userData = {
          'name': name,
          'finished': false,
          'phone': '123-456-7890',
          'hourly_rate': hourlyRate,
          'total_hours': totalHours,
          'total_salary': totalHours * hourlyRate,
          'current_month_hours': currentMonthHours,
          'current_month_salary': currentMonthSalary,
        };

        await scheduleDocRef.collection('users').add(userData);
      }
    }

    // Generate 4 random branches
    for (int i = 0; i < 4; i++) {
      final String name = branchNames[random.nextInt(branchNames.length)];
      final String address =
      branchAddresses[random.nextInt(branchAddresses.length)];

      final Map<String, dynamic> branchData = {
        'name': name,
        'address': address,
      };

      final DocumentReference branchDocRef =
      await branchesCollection.add(branchData);

      // Generate 3 random coaches for this branch
      for (int j = 0; j < 3; j++) {
        final String coachId = 'Coach ${j + 1}';

        final Map<String, dynamic> coachData = {
          'coach_id': coachId,
        };

        await branchDocRef.collection('coaches').add(coachData);
      }
    }
  }

  bool? updatedFinishedValue;

  void changeAttendance(String scheduleId, String userId, bool? value) async {
    final CollectionReference adminsCollection =
    FirebaseFirestore.instance.collection('admins');
    final DocumentSnapshot scheduleSnapshot =
    await adminsCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    ).get();
    final DocumentReference userRef = scheduleSnapshot
        .reference
        .collection('schedules')
        .doc(scheduleId)
        .collection('users')
        .doc(userId);

    if (value != null) {
      try {
        // Fetch the current value of 'finished' from Firestore
        final DocumentSnapshot userSnapshot = await userRef.get();
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>? ?? {};
        final bool currentFinishedValue = userData['finished'] ?? false;

        // Toggle the value of 'finished'
        updatedFinishedValue = !currentFinishedValue;

        emit(AttendanceChangedState(updatedFinishedValue!));

        // Update the document with the new value
        await userRef.update({'finished': updatedFinishedValue});

        // Update the schedulesList for the specific user
        // for (int i = 0; i < schedulesList.length; i++) {
        //   final Map<String, dynamic> schedule = schedulesList[i];
        //   if (schedule['id'] == scheduleId) {
        //     final List<Map<String, dynamic>> usersList =
        //     List<Map<String, dynamic>>.from(schedule['users']);
        //     for (int j = 0; j < usersList.length; j++) {
        //       if (usersList[j]['id'] == userId) {
        //         usersList[j]['finished'] = updatedFinishedValue;
        //         break;
        //       }
        //     }
        //     schedulesList[i]['users'] = usersList;
        //     break;
        //   }
        // }
      } catch (e) {
        // If there's an error updating the document, it means there's no internet connection
        // Use FirestoreCache to store the update locally
        // await FirestoreCache.set(userRef, {'finished': updatedFinishedValue});
      }
    }
  }

  String getdayinArabic() {
    final DateTime now = DateTime.now();
    final String dayOfWeek = DateFormat('EEEE').format(now);
    switch (dayOfWeek) {
      case 'Saturday':
        return 'السبت';
      case 'Sunday':
        return 'الأحد';
      case 'Monday':
        return 'الاثنين';
      case 'Tuesday':
        return 'الثلاثاء';
      case 'Wednesday':
        return 'الأربعاء';
      case 'Thursday':
        return 'الخميس';
      case 'Friday':
        return 'الجمعة';
      default:
        return 'السبت';
    }

  }

// - *admins*: A collection to store the information of all admins.
//   - Document ID: unique admin ID
//   - Fields:*`phone`*, *`name`*, *`email`*, *`branches`* (list of string of the branches they're responsible for) ,pId
//   - Subcollection: *`schedules`*
//     - Document ID: unique schedule ID
//     - Fields: *`branch_id`*, *`start_time`*, *`end_time`*, *`date`*,
//     - Subcollection: *`users`*
//       - Document ID: unique user ID
//       - Fields: *`name`*, *`phone`*, *`hourly_rate`*, *`total_hours`*, *`total_salary`*, *`current_month_hours`*, *`current_month_salary`* ,*`finished`*
//   - Subcollection: *`salaryHistory`*
//     - Document ID: unique salary history ID (usually just the month and year)
//     - Fields: *`month`*, *`year`*, *`total_hours`*, *`total_salary`*
//   - Fields: *`branches`* (array of branch IDs that the admin is responsible for)
//
// - *branches*: A collection to store the information of all branches.
//   - Document ID: unique branch ID
//   - Fields: *`name`*, *`address`*
//   - Subcollection: *`coaches`*
//     - Document ID: unique coach ID who works at this branch
//get all user where pid equal FirebaseAuth.instance.currentUser!.uid
  List<UserModel>? MyUsers;
  List<String>? MyUsersNames;
  List<String>? branches;

  Future<void> getAdminData() async {
    try {
      emit(GetUserDataLoadingState());
      //get list branches from firebase admins collection
      final CollectionReference branchesCollection =
      FirebaseFirestore.instance.collection('admins');
      final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
      final QuerySnapshot usersQuerySnapshot = await usersCollection
          .where('pid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get(
        const GetOptions(
          source: Source.serverAndCache,
        ),
      );

      // - *admins*: A collection to store the information of all admins.
      //   - Document ID: unique admin ID
      //   - Fields:*`phone`*, *`name`*, *`email`*, *`branches`* (list of string of the branches they're responsible for) ,pId
      //get list of branches from firebase admins collection
      final DocumentSnapshot adminSnapshot = await branchesCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final Map<String, dynamic> adminData =
      adminSnapshot.data() as Map<String, dynamic>;
      branches = List<String>.from(adminData['branches']);

      final List<UserModel> usersList = [];
      MyUsersNames = []; // Initialize MyUsersNames as an empty list

      for (final QueryDocumentSnapshot userDoc in usersQuerySnapshot.docs) {
        final Map<String, dynamic> userData =
        userDoc.data() as Map<String, dynamic>;
        usersList.add(UserModel.fromJson(userData));
        // add usersname to list
        MyUsersNames!.add(userData['name']); // Use MyUsersNames! to access the non-null list
        print(userData['name']);
        print(MyUsersNames);
        print(MyUsers?.length);
      }
      MyUsers = usersList;
      emit(GetUserDataSuccessState());
    } catch (e) {
      emit(GetUserDataErrorState(e.toString()));
    } 
  }
  Future<void> updateSchedule({
      String? scheduleId,
      Timestamp? startTrainingTime,
      Timestamp? endTrainingTime,
      String? branch,
    }) async {
    emit(AddScheduleLoadingState());

      List<String> days = selectedDays ?? [];
      List<String> coaches = selectedCoaches ?? [];
      try {
        if (days.length > 1) {
          // Update the schedule for the first day in the list
          await FirebaseFirestore.instance
              .collection('admins')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('schedules')
              .doc(days[0])
              .collection('schedules')
              .doc(scheduleId)
              .update({
            'start_time': startTrainingTime,
            'end_time': endTrainingTime,
            'date': days[0],
            'branch_id': branch,
            'usersList': coaches,
          });
          //if usersList is not empty then update the subcollection users
          if (coaches.isNotEmpty) {
            for (var coach in coaches) {
              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .where('name', isEqualTo: coach)
                  .get();
              if (querySnapshot.docs.isNotEmpty) {
                String userId = querySnapshot.docs.first.id;
                await FirebaseFirestore.instance
                    .collection('admins')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('schedules')
                    .doc(days[0])
                    .collection('schedules')
                    .doc(scheduleId)
                    .collection('users')
                    .doc(userId)
                    .set({
                  'name': querySnapshot.docs.first['name'],
                  'uid' : userId,
                  'finished': false,
                });
              }
            }
          }
          // Create new schedules for the rest of the days in the list
          for (int i = 1; i < days.length; i++) {
            await FirebaseFirestore.instance
                .collection('admins')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('schedules')
                .doc(days[i])
                .collection('schedules')
                .add({
              'start_time': startTrainingTime,
              'end_time': endTrainingTime,
              'date': days[i],
              'branch_id': branch,
              'usersList': coaches
            });
          }
              
        } else {
          // Update the schedule for the only day in the list
          await FirebaseFirestore.instance
              .collection('admins')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('schedules')
              .doc(days[0])
              .collection('schedules')
              .doc(scheduleId)
              .update({
            'start_time': startTrainingTime,
            'end_time': endTrainingTime,
            'date': days[0],
            'branch_id': branch,
            'usersList': coaches,
          });
        }

        // Update the user information in the subcollection
        for (var coach in coaches) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('name', isEqualTo: coach)
              .get();

          for (var doc in querySnapshot.docs) {
            String userId = doc.id;
            await FirebaseFirestore.instance
                .collection('admins')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('schedules')
                .doc(days[0])
                .collection('schedules')
                .doc(scheduleId)
                .collection('users')
                .doc(userId)
                .set({
              'name': doc['name'],
              'uid': userId,
              'finished': false,
            });
          }
        }
        // Import the ManageSalaryCubit file
        // Create an instance of ManageSalaryCubit
        final manageSalaryCubit = ManageSalaryCubit();
        print('days[0]: ${days[0]}');
       await manageSalaryCubit.getSchedules(day: days[0]);
        emit(AddScheduleSuccessState());
      } catch (e) {
        print('Error updating schedule: $e');
        emit(AddScheduleErrorState(e.toString()));
      }
    }

  
  Future<void> addSchedule(BuildContext context, {required Timestamp
  startTrainingTime, required 
  Timestamp
  endTrainingTime, required String branch}) async {
    List<String> days = selectedDays ?? [];
    List<String> coaches = selectedCoaches ?? [];

    try {
      //emit(LoadingState());
      emit(AddScheduleLoadingState());
      for (var day in days) {
        await FirebaseFirestore.instance
            .collection('admins')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('schedules')
            .doc(day)
            .collection('schedules')
            .add({
          'start_time': startTrainingTime,
          'end_time': endTrainingTime,
          'date': day,
          'branch_id': branch,
          'usersList': [], // add empty usersList field to each schedule
        }).then((scheduleDoc) async {
          if (coaches.isNotEmpty) {
            for (var coach in coaches) {
              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .where('name', isEqualTo: coach)
                  .get();
              if (querySnapshot.docs.isNotEmpty) {

                String userId = querySnapshot.docs.first.id;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('schedules')
                    .doc(scheduleDoc.id)
                    .set({
                  'start_time': startTrainingTime,
                  'end_time': endTrainingTime,
                  'date': day,
                  'branch_id': branch,
                });
                await FirebaseFirestore.instance
                    .collection('admins')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('schedules')
                    .doc(day)
                    .collection('schedules')
                    .doc(scheduleDoc.id)
                    .collection('users')
                    .doc(userId)
                    .set({
                  'name': querySnapshot.docs.first['name'],
                  'uid' : userId,
                  'finished': false,
                });

                // add user to usersList field in schedule
                await scheduleDoc.update({
                  'usersList': FieldValue.arrayUnion([querySnapshot.docs.first['name']]),
                });
              }
            }
          }

          await scheduleDoc.update({
            'schedule_id': scheduleDoc.id,
          });
        });
      }

      //emit(SuccessState());
      emit(AddScheduleSuccessState());
    } catch (e) {
      emit(AddScheduleErrorState(e.toString()));
    //  emit(ErrorState(errorMessage: 'Error updating schedule: $e'));
    }
  } 
  //selected items
  List<String>? selectedCoaches;
  void add(String itemValue) {
    selectedCoaches ??= [];
    print('add');
    print(itemValue);
    print(itemValue.toString());
    selectedCoaches?.add(itemValue.toString());



    emit(UpdateSelectedItemsState(
    //  selectedItems: selectedItems,
    ));
    print(selectedCoaches);
  }

  void remove(String itemValue) {
    selectedCoaches ??= [];
    selectedCoaches?.remove(itemValue.toString());
    emit(UpdateSelectedItemsState(

    ));
    print(selectedCoaches);
  }
  void itemChange(String itemValue, bool isSelected, BuildContext context) {
    //final List<String> updatedSelection = List.from(
    //   SignUpCubit.get(context).selectedItems ?? []);

    if (isSelected) {
      add(itemValue);
      // updatedSelection.add(itemValue);
    } else {
      remove(itemValue);
      //  updatedSelection.remove(itemValue);
    }

    //  onSelectionChanged(updatedSelection);
  }  //selected items
  List<String>? selectedDays;
  void add2(String itemValue) {
    selectedDays ??= [];
    print('add');
    print(itemValue);
    print(itemValue.toString());
    selectedDays?.add(itemValue.toString());



    emit(UpdateSelectedItemsState(
    //  selectedItems: selectedItems,
    ));
    print(selectedDays);
  }

  void remove2(String itemValue) {
    selectedDays ??= [];
    selectedDays?.remove(itemValue.toString());
    emit(UpdateSelectedItemsState(

    ));
    print(selectedDays);
  }
  void itemChange2(String itemValue, bool isSelected, BuildContext context) {
    //final List<String> updatedSelection = List.from(
    //   SignUpCubit.get(context).selectedItems ?? []);

    if (isSelected) {
      add2(itemValue);
      // updatedSelection.add(itemValue);
    } else {
      remove2(itemValue);
      //  updatedSelection.remove(itemValue);
    }

    //  onSelectionChanged(updatedSelection);
  }

  String? selectedBranch;
  void updateSelectedBranch(String branch) {
    selectedBranch = branch;
    emit(UpdateSelectedBranchState());
  }

  var endTime;
  void updateEndTime(Timestamp timestamp) {
    endTime = timestamp;
    emit(UpdateEndTimeState());
  }
  //start time
  var startTime;
  void updateStartTime(Timestamp timestamp) {
    startTime = timestamp;
    emit(UpdateStartTimeState());
  }



}
