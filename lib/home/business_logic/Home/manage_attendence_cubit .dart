//import 'package:connectivity/connectivity.dart';
import 'dart:math';
//import 'package:firestore_cache/firestore_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  static List<Map<String, dynamic>> schedulesList = [];
  Map<String, dynamic>? firstSchedule; // Variable to store the first schedule

  Future<void> getSchedulesForAdmin() async {
    initializeDateFormatting();
    emit(GetSchedulesForAdminLoadingState());
    try {
      final DateTime now = DateTime.now();
      final DateTime startOfToday = DateTime(now.year, now.month, now.day);
      final QuerySnapshot schedulesQuerySnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser!.uid)
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

        // Store the first schedule in the variable
        if (firstSchedule == null) {
          firstSchedule = scheduleWithUserData;
        }
      }

      // Print the first schedule
      print('First schedule:\n\n\n $firstSchedule');

      emit(GetSchedulesForAdminSuccessState());
    } catch (e) {
      emit(GetSchedulesForAdminErrorState(e.toString()));
    }
  }

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
//  bool? updatedFinishedValue ;
//   void changeAttendance(String scheduleId, String userId, bool? value) async {
//     final CollectionReference adminsCollection =
//     FirebaseFirestore.instance.collection('admins');
//     final DocumentSnapshot scheduleSnapshot =
//     await adminsCollection.doc('JcElORFrvvpvtSsk4Iou').get();
//     final DocumentReference userRef = scheduleSnapshot
//         .reference
//         .collection('schedules')
//         .doc(scheduleId)
//         .collection('users')
//         .doc(userId);
//
//     if (value != null) {
//       try {
//         // Fetch the current value of 'finished' from Firestore
//         final DocumentSnapshot userSnapshot = await userRef.get();
//         final Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>? ?? {};
//         final bool currentFinishedValue = userData['finished'] ?? false;
//
//         // Toggle the value of 'finished'
//          updatedFinishedValue = !currentFinishedValue;
// emit(AttendanceChangedState(updatedFinishedValue!));
//         // Update the document with the new value
//         await userRef.update({'finished': updatedFinishedValue});
//       } catch (e) {
//         // If there's an error updating the document, it means there's no internet connection
//         // Use FirestoreCache to store the update locally
//         // await FirestoreCache.set(userRef, {'finished': updatedFinishedValue});
//       }
//     }
//   }
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

// - *admins*: A collection to store the information of all admins.
//   - Document ID: unique admin ID
//   - Fields:*`phone`*, *`name`*, *`email`*, *`branch_id`* (list of string of the branches they're responsible for)
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



}
