import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../registeration/data/userModel.dart';

part 'manage_salary_state.dart';

class ManageSalaryCubit extends Cubit<ManageSalaryState> {
  ManageSalaryCubit() : super(ManageSalaryInitial());
  static ManageSalaryCubit get(context) => BlocProvider.of(context);
//*users*: A collection to store the information of all users.
// // - Document ID: unique coach ID
// // - Fields: *`name`, *`level`*, *`hourly_rate`*, *`total_hours`*, *`total_salary`*, *`current_month_hours`*, *`current_month_salary`**
// // - Subcollection: *`schedules`*
// // - Document ID: unique schedule ID
// // - Fields: *`branch_id`, *`start_time`*, *`end_time`*, *`date`*, *`finished`**
// // - Subcollection: *`attendance`*
// // - Document ID: unique attendance ID (usually just the coach ID)
// // - Fields: *`attended`, *`qr_code`**
// // - Subcollection: *`salaryHistory`*
// // - Document ID: unique salary history ID (usually just the month and year)
// // - Fields: *`month`, *`year`*, *`total_hours`*, *`total_salary`**
// // - Fields: *`branches`* (array of branch IDs that the coach works at)
// //
// // - *branches*: A collection to store the information of all branches.
// // - Document ID: unique branch ID
// // - Fields: *`name`, *`address`**
// // - Subcollection: *`users`*
// // - Document ID: unique coach ID who works at this branch
// //
// // - *admins*: A collection to store the information of all admins.
// // - Document ID: unique admin ID
// // - Fields: *`name`, *`email`*, *`branch_id`** (the ID of the branch they're responsible for)
// //
// // - *schedules*: A collection to store the information of all schedules.
// // - Document ID: unique schedule ID
// // - Fields: *`branch_id`, *`start_time`*, *`end_time`*, *`date`**
// // - Subcollection: *`attendance`*
// // - Document ID: unique attendance ID (usually just the coach ID)
// // - Fields: *`attended`, *`qr_code`**
  List<UserModel> users = [];
  num globalTotalSalary = 0; // Declare globalTotalSalary variable as num

  Future<void> getUsers() async {
    emit(GetUsersLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .get(GetOptions(source: Source.serverAndCache))
        .then((value) {
      num totalSalary = 0; // Change the type of totalSalary to num
      value.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
        totalSalary += element.data()['totalSalary'];
      });
      globalTotalSalary = totalSalary; // Assign totalSalary value to globalTotalSalary
      print('Total salary of all users: $globalTotalSalary');
      emit(GetUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUsersErrorState(error.toString()));
    });
  }
  // UserModel({
//     this.name,
//     this.email,
//     this.level,
//     this.hourlyRate,
//     this.totalHours,
//     this.totalSalary,
//     this.currentMonthHours,
//     this.currentMonthSalary,
//     this.uId,
//     this.phone,
//     this.role,
//
//   });
  //edit function to get sum of totalSalary of all users

  // List<Map<String, dynamic>>? users = [];
  //
  // void getUsers() async {
  //   try {
  //     QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .get();
  //
  //     List<Map<String, dynamic>> users = usersSnapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       data['id'] = doc.id;
  //       return data;
  //     }).toList();
  //     print('\n\n\n\n\n');
  //     print(users.length);
  //     this.users = users;
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //     QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .get(GetOptions(source: Source.cache));
  //
  //     List<Map<String, dynamic>> users = usersSnapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       data['id'] = doc.id;
  //       return data;
  //     }).toList();
  // print('\n\n\n\n\n');
  // print(users.length);
  //     this.users = users;
  //   }
  // }



}
