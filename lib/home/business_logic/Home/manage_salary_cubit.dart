import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  num globalTotalSalary = 0; // Declare globalTotalSalary variable as num
// salary textEditingController
  TextEditingController salaryController = TextEditingController();

// update total salary of all users
  //make total salary = 0
  //for user with this uid userId
  //use catch error
  Future<void> paySalary({String? userId}) async {
    try {
      print('userId: $userId');
      emit(PaySalaryLoadingState());

      bool isConnected = await checkInternetConnectivity(); // Custom function to check internet connectivity

      if (!isConnected) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get(GetOptions(source: Source.serverAndCache));

        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          int newTotalSalary = 0;

          // Store the updated salary locally until an internet connection is available
          saveSalaryLocally(userId, newTotalSalary);

          // Update the user in the users list
          UserModel updatedUser = UserModel.fromJson(userData);
          updatedUser.totalSalary = newTotalSalary;
          int userIndex = users.indexWhere((user) => user.uId == userId);
          if (userIndex != -1) {
            users[userIndex] = updatedUser;
          }
          emit(PaySalarySuccessStateWithoutInternet());
          return;
        }
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'totalSalary': 0});

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get(GetOptions(source: Source.server));

      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        int newTotalSalary = 0;

        // Update the user in the users list
        UserModel updatedUser = UserModel.fromJson(userData);
        updatedUser.totalSalary = newTotalSalary;
        int userIndex = users.indexWhere((user) => user.uId == userId);
        if (userIndex != -1) {
          users[userIndex] = updatedUser;
        }

        emit(PaySalarySuccessState());
      } else {
        throw 'User data not found';
      }
    } catch (error) {
      print(error.toString());
      emit(PaySalaryErrorState(error.toString()));
    }
  }
  //minus salary from total salary in firestore for this user
  //update total salary
  //don't use globalTotalSalary
  //use value from firestore
  Future<void> payPartialSalary({String? userId, String? salary}) async {
    try {
      print('userId: $userId');
      emit(PaySalaryLoadingState());

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get(GetOptions(source: Source.serverAndCache));

      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

      int? totalSalary = userData?['totalSalary'];
      int? salary14 = int.parse(salary!);
      int? newTotalSalary = totalSalary! - salary14!;
      print('newTotalSalary: $newTotalSalary');

      bool isConnected = await checkInternetConnectivity(); // Custom function to check internet connectivity

      if (!isConnected) {
        // Store the updated salary locally until an internet connection is available
        saveSalaryLocally(userId, newTotalSalary);

        // Update the user in the users list
        int userIndex = users.indexWhere((user) => user.uId == userId);
        if (userIndex != -1) {
          users[userIndex].totalSalary = newTotalSalary;
        }

        emit(PaySalarySuccessStateWithoutInternet());
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'totalSalary': newTotalSalary});
      // Update the user in the users list
      int userIndex = users.indexWhere((user) => user.uId == userId);
      if (userIndex != -1) {
        users[userIndex].totalSalary = newTotalSalary;
      }


      emit(PaySalarySuccessState());
    } catch (error) {
      print(error.toString());
      emit(PaySalaryErrorState(error.toString()));
    }
  }

  Future<void> payBonus(String? userId, context, {String? salary}) async {
    print('userId: $userId');
    emit(PayBonusLoadingState());

    try {
      bool isConnected = await checkInternetConnectivity(); // Custom function to check internet connectivity

      if (!isConnected) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get(GetOptions(source: Source.serverAndCache));

        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          int? totalSalary = userData['totalSalary'];
          int? salary14 = int.parse(salary!);
          int? newTotalSalary = totalSalary! + salary14!;
          print('newTotalSalary: $newTotalSalary');

          // Store the updated salary locally until an internet connection is available
          saveSalaryLocally(userId, newTotalSalary);

          // Update the user in the users list
          UserModel updatedUser = UserModel.fromJson(userData);
          updatedUser.totalSalary = newTotalSalary;
          int userIndex = users.indexWhere((user) => user.uId == userId);
          if (userIndex != -1) {
            users[userIndex] = updatedUser;
          }
          emit(PayBonusSuccessStateWithoutInternet());
          return;
        }
      }

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get(GetOptions(source: Source.server));

      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        int? totalSalary = userData['totalSalary'];
        int? salary14 = int.parse(salary!);
        int? newTotalSalary = totalSalary! + salary14!;
        print('newTotalSalary: $newTotalSalary');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'totalSalary': newTotalSalary});

        // Update the user in the users list
        UserModel updatedUser = UserModel.fromJson(userData);
        updatedUser.totalSalary = newTotalSalary;
        int userIndex = users.indexWhere((user) => user.uId == userId);
        if (userIndex != -1) {
          users[userIndex] = updatedUser;
        }

        emit(PayBonusSuccessState());
      } else {
        throw 'User data not found';
      }
    } catch (error) {
      print(error.toString());
      emit(PayBonusErrorState(error.toString()));
    }
  }
  List<UserModel> users = [];
  Future<void> getUsers() async {
    emit(GetUsersLoadingState());
    users = [];
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

  checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void saveSalaryLocally(String? userId, int newTotalSalary) {
    // Save the updated salary locally until an internet connection is available
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(userId!, newTotalSalary);
    });
  }
  //sync data from local to firestore when internet is available
  //check if internet is available
  void syncData() async {
    bool isConnected = await checkInternetConnectivity();
    if (isConnected) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.getKeys().forEach((key) async {
          int? newTotalSalary = prefs.getInt(key);
          if (newTotalSalary != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(key)
                .update({'totalSalary': newTotalSalary});
          }
        });
      });
      //clear local data
      SharedPreferences.getInstance().then((prefs) {
        prefs.clear();
      });
    }

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
