//import 'package:connectivity/connectivity.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'manage_attendence_state.dart';
// ****this is my firestore Collections and Documents:**
// - *users*: A collection to store the information of all coaches.
// - Document ID: unique coach ID
// - Fields: *`name`, *`level`*, *`hourly_rate`*, *`total_hours`*, *`total_salary`*, *`current_month_hours`*, *`current_month_salary`**
// - Subcollection: *`schedules`*
// - Document ID: unique schedule ID
// - Fields: *`branch_id`, *`start_time`*, *`end_time`*, *`date`*, *`finished`**
// - Subcollection: *`attendance`*
// - Document ID: unique attendance ID (usually just the coach ID)
// - Fields: *`attended`, *`qr_code`**
// - Subcollection: *`salaryHistory`*
// - Document ID: unique salary history ID (usually just the month and year)
// - Fields: *`month`, *`year`*, *`total_hours`*, *`total_salary`**
// - Fields: *`branches`* (array of branch IDs that the coach works at)
//
// - *branches*: A collection to store the information of all branches.
// - Document ID: unique branch ID
// - Fields: *`name`, *`address`**
// - Subcollection: *`coaches`*
// - Document ID: unique coach ID who works at this branch
//
// - *admins*: A collection to store the information of all admins.
// - Document ID: unique admin ID
// - Fields: *`name`, *`email`*, *`branch_id`** (the ID of the branch they're responsible for)
//
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
  final List<Map<String, dynamic>> schedulesList = [];

  // Future<void> getSchedulesForAdmin(String adminUid) async {
  //   emit(LoadingState());
  //   final QuerySnapshot schedulesQuerySnapshot = await FirebaseFirestore.instance
  //       .collection('admins')
  //       .doc(adminUid)
  //       .collection('schedules')
  //       .get();
  //
  //   for (final QueryDocumentSnapshot scheduleDoc in schedulesQuerySnapshot.docs) {
  //     final Map<String, dynamic> scheduleData =
  //     scheduleDoc.data() as Map<String, dynamic>;
  //
  //     final QuerySnapshot usersQuerySnapshot = await scheduleDoc.reference
  //         .collection('users')
  //         .get();
  //
  //     final List<Map<String, dynamic>> usersList = usersQuerySnapshot.docs
  //         .map<Map<String, dynamic>>(
  //             (QueryDocumentSnapshot documentSnapshot) =>
  //         documentSnapshot.data() as Map<String, dynamic>)
  //         .toList();
  //
  //     final Map<String, dynamic> scheduleWithUserData = {
  //       ...scheduleData,
  //       'users': usersList,
  //     };
  //
  //     schedulesList2.add(scheduleWithUserData);
  //   }
  //   emit(SuccessState());
  // }
//use catch error in above function
  Future<void> getSchedulesForAdmin(String adminUid) async {
    initializeDateFormatting();
    emit(GetSchedulesForAdminLoadingState());
    try {
      final QuerySnapshot schedulesQuerySnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .doc(adminUid)
          .collection('schedules')
          .get();

      for (final QueryDocumentSnapshot scheduleDoc in schedulesQuerySnapshot.docs) {
        final Map<String, dynamic> scheduleData =
        scheduleDoc.data() as Map<String, dynamic>;

        final QuerySnapshot usersQuerySnapshot = await scheduleDoc.reference
            .collection('users')
            .get();

        final List<Map<String, dynamic>> usersList = usersQuerySnapshot.docs
            .map<Map<String, dynamic>>(
                (QueryDocumentSnapshot documentSnapshot) =>
            documentSnapshot.data() as Map<String, dynamic>)
            .toList();

        final Map<String, dynamic> scheduleWithUserData = {
          ...scheduleData,
          'users': usersList,
        };

        schedulesList.add(scheduleWithUserData);
      }
      //print all content of schedulesList2
      for (int i = 0; i < schedulesList.length; i++) {
        print(schedulesList[i]);
      }
      //print length of schedulesList2
      print('schedulesList2 length is:\n\n\n\n' );
      print(schedulesList.length);
      emit(GetSchedulesForAdminSuccessState(
      ));
    }
    catch(e){
      emit(GetSchedulesForAdminErrorState(e.toString()));
    }
  }
  void generateRandomData() async {
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

    // Generate 4 random admins
    for (int i = 0; i < 4; i++) {
      final Random random = Random();

      final String name = adminNames[random.nextInt(adminNames.length)];
      final String email = '$name@example.com';
      final int branchId = random.nextInt(4) + 1; // Random branch ID between 1-4

      final Map<String, dynamic> adminData = {
        'name': name,
        'email': email,
        'branch_id': branchId,
      };

      final DocumentReference adminDocRef =
      await adminsCollection.add(adminData);

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
          final int hourlyRate = 10 + random.nextInt(20); // Random hourly rate between 10-30
          final int totalHours = random.nextInt(50); // Random total hours between 0-50
          final int currentMonthHours = random.nextInt(20); // Random current month hours between 0-20
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

      // Generate a random salary history for this admin
      final int year = 2021;
      final int month = random.nextInt(12) + 1; // Random month between 1-12
      final int totalHours = random.nextInt(100); // Random total hours between 0-100
      final int totalSalary = totalHours * 20; // Random total salary between 0-2000

      final Map<String, dynamic> salaryHistoryData = {
        'month': month,
        'year': year,
        'total_hours': totalHours,
        'total_salary': totalSalary,
      };

      await adminDocRef.collection('salaryHistory').add(salaryHistoryData);
    }

    // Generate 4 random branches
    for (int i = 0; i < 4; i++) {
      final Random random = Random();

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

        final Map<String,dynamic> coachData = {
          'coach_id': coachId,
        };

        await branchDocRef.collection('coaches').add(coachData);
      }
    }
  }

// - *admins*: A collection to store the information of all admins.
//   - Document ID: unique admin ID
//   - Fields:*`phone`*, *`name`*, *`email`*, *`branch_id`* (list of string of the branches they're responsible for)
//   - Subcollection: *`schedules`*
//     - Document ID: unique schedule ID
//     - Fields: *`branch_id`*, *`start_time`*, *`end_time`*, *`date`*, *`finished`*
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



}
