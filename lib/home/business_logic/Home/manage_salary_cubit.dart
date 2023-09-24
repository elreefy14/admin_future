import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/flutter_flow/flutter_flow_util.dart';
import '../../../registeration/data/userModel.dart';
import '../../../registeration/presenation/widget/widget.dart';
import '../../data/Notification.dart';
import '../../data/day_model.dart';
import '../../data/schedules.dart';

part 'manage_salary_state.dart';

class ManageSalaryCubit extends Cubit<ManageSalaryState> {
  //final UserModel userModel;
  ManageSalaryCubit() : super(ManageSalaryInitial());
  static ManageSalaryCubit get(context) => BlocProvider.of(context);
  //messageController
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController salaryPerHourController;
  void initControllers(userModel) {
    firstNameController = TextEditingController(text: userModel.fname);
    lastNameController = TextEditingController(text: userModel.lname);
    phoneController = TextEditingController(text: userModel.phone);
    salaryPerHourController =
        TextEditingController(text: userModel.hourlyRate.toString() ?? '');
  }
  //changeSelectedDayIndex
  int selectedDayIndex = 0;
  void changeSelectedDayIndex(int index) {
    selectedDayIndex = index;
    emit(ChangeSelectedDayIndexState(
      selectedDayIndex,
    ));
  }

  //get list of next 7 days from today and prind the day like friday in arabic


  List<DayModel> days = [];
  String? today;

  Future<void> getDays() async {
    days = [];
    if (kDebugMode) {
      print('getDays\n\n\n');
    }
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = now.add(Duration(days: i));
      String day = date.weekday.toString();
      switch (day) {
        case '1':
          day = 'الاثنين';
          break;
        case '2':
          day = 'الثلاثاء';
          break;
        case '3':
          day = 'الأربعاء';
          break;
        case '4':
          day = 'الخميس';
          break;
        case '5':
          day = 'الجمعة';
          break;
        case '6':
          day = 'السبت';
          break;
        case '7':
          day = 'الأحد';
          break;
          //,make random dummy values list of days
        //['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
      }
      Timestamp timestamp = Timestamp.fromDate(date);
      days.add(DayModel(name: day, timestamp: timestamp));
      //print list of days
      if (kDebugMode) {
        print('days: $days');
      }
    }
    today = days[0].name;
  }
  //get list of schedules from admin collection then schedule subcollection for specific day like friday
  List<SchedulesModel> schedules = [];
  Future<void> getSchedules({required String day}) async {
    print('a7a \n\n\n\n');
    print('day: $day');
    emit(GetSchedulesLoadingState());
    schedules = [];
    await FirebaseFirestore.instance
        .collection('admins')
        //todo change this to admin id
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('schedules')
        .doc(day)
        .collection('schedules')
        .get(const GetOptions(source: Source.serverAndCache))
        .then((value) {
      value.docs.forEach((element) {
        schedules.add(SchedulesModel.fromJson2(element.data()));
        //print list of schedules
      });
      //print all info for each schedule
      if (kDebugMode) {
        schedules.forEach((element) {
          print('branchId: ${element.branchId}');
          print('startTime: ${element.startTime}');
          print('endTime: ${element.endTime}');
          //print end time like that 12 : 00
          print('endTime: ${element.endTime?.toDate().hour} : ${element.endTime?.toDate().minute}');
          print('usersList: ${element.usersList}');
        });
      }
      emit(GetSchedulesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSchedulesErrorState(error.toString()));
    });
  }

  //generate random data to test getSchedules function
  // Future<void> generateRandomSchedules() async {
  //   emit(GenerateRandomSchedulesLoadingState());
  //   List<String> days = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];
  //   List<String> branches = ['فرع جرين بارك', 'فرع النزهة', 'فرع الدقي'];
  //   List<String> startTimes = ['10:00', '12:00', '14:00', '16:00'];
  //   List<String> endTimes = ['12:00', '14:00', '16:00', '18:00'];
  //   List<List<String>> usersNames = [
  //     [
  //       'محمد محمود',
  //       'محمود علي',
  //       'أحمد محمود',
  //     ],
  //     [
  //       'محمد محمود',
  //       'محمود علي',
  //       'أحمد محمود',
  //     ],
  //     [
  //       'محمد محمود',
  //       'محمود علي',
  //       'أحمد محمود',
  //     ],
  //     [
  //       'محمد محمود',
  //       'محمود علي',
  //       'أحمد محمود',
  //     ],
  //   ];
  //   List<bool> finished = [false, true];
  //   for (int i = 0; i < 7; i++) {
  //     for (int j = 0; j < 4; j++) {
  //       final randomDay = days[Random().nextInt(days.length)];
  //       final randomBranch = branches[Random().nextInt(branches.length)];
  //       final randomStartTime = startTimes[Random().nextInt(startTimes.length)];
  //       final randomEndTime = endTimes[Random().nextInt(endTimes.length)];
  //       final randomFinished = finished[Random().nextInt(finished.length)];
  //       final randomUsersNames =
  //           usersNames[Random().nextInt(usersNames.length)];
  //
  //       final DateTime startDate =
  //           DateFormat('dd/MM/yyyy hh:mm').parse('10/10/2021 $randomStartTime');
  //       final DateTime endDate =
  //           DateFormat('dd/MM/yyyy hh:mm').parse('10/10/2021 $randomEndTime');
  //
  //       final schedule = SchedulesModel(
  //         scheduleId: ,
  //         pId: 'pId',
  //         branchId: randomBranch,
  //         startTime: Timestamp.fromDate(startDate),
  //         endTime: Timestamp.fromDate(endDate),
  //         finished: randomFinished,
  //         usersList: randomUsersNames,
  //       );
  //
  //       await FirebaseFirestore.instance
  //           .collection('admins')
  //           //todo change this to admin id
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           .collection('schedules')
  //           .doc(randomDay)
  //           .collection('schedules')
  //           .add(schedule.toJson2())
  //           .then((value) {
  //         print('Schedule added');
  //       }).catchError((error) {
  //         print(error.toString());
  //       });
  //     }
  //   }
  //   emit(GenerateRandomSchedulesSuccessState());
  // }

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
  //firstNameController

// update total salary of all users
  //make total salary = 0
  //for user with this uid userId
  //use catch error
  Future<void> paySalary({String? userId}) async {
    try {
      print('userId: $userId');
      emit(PaySalaryLoadingState());

      bool isConnected =
          await checkInternetConnectivity(); // Custom function to check internet connectivity

      if (!isConnected) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get(GetOptions(source: Source.serverAndCache));

        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

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

      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

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

      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      int? totalSalary = userData?['totalSalary'];
      int? salary14 = int.parse(salary!);
      int? newTotalSalary = totalSalary! - salary14!;
      print('newTotalSalary: $newTotalSalary');

      bool isConnected =
          await checkInternetConnectivity(); // Custom function to check internet connectivity

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
      bool isConnected =
          await checkInternetConnectivity(); // Custom function to check internet connectivity

      if (!isConnected) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get(GetOptions(source: Source.serverAndCache));

        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

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

      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

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
      globalTotalSalary =
          totalSalary; // Assign totalSalary value to globalTotalSalary
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

//  void editUserData({
//     String? firstName,
//     String? lastName,
//     String? phone,
//     String? image,
//   }) async {
//     emit(EditUserDataLoadingState());
//     final user = FirebaseAuth.instance.currentUser;
//     final updateData = <String, Object?>{};
//     final notificationData = <String, dynamic>{};
//
//     if (firstName != null || lastName != null) {
//       updateData['name'] = firstName??'' + ' ' + (lastName ?? '');
//       //userData!.name = firstName + ' ' + (lastName ?? '');
//     }
//     if (firstName != null) {
//       updateData['fname'] = firstName;
//       updateData['name'] = firstName + ' ' + (lastName ?? '');
//
//       //userData!.fname = firstName;
//       notificationData['message'] = 'تم تحديث معلومات الحساب الشخصية';
//     }
//     if (lastName != null) {
//       updateData['lname'] = lastName;
//       updateData['name'] = firstName??'' + ' ' + (lastName ?? '');
//      // userData!.lname = lastName;
//       notificationData['message'] = 'تم تحديث معلومات الحساب الشخصية';
//     }
//     if (phone != null) {
//       updateData['phone'] = phone;
//      // userData!.phone = phone;
//       notificationData['message'] = 'تم تحديث معلومات الحساب الشخصية';
//     }
//     if (image != null) {
//       updateData['image'] = image;
//
//       //userData!.image = image;
//       notificationData['message'] = ' تم تحديث معلومات الحساب الشخصية';
//     //'personal info '
//       //translation
//
//        }
//
//
//     // Update the user data
//     try {
//      // CacheHelper.saveUser(userData);
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .update(updateData);
//
//       // Update the local cache
//       CacheHelper.getUser()!.then((userData) async {
//           if (firstName != null) {
//             userData!.fname = firstName ;
//           }
//           if (lastName != null) {
//             userData!.lname = lastName ;
//           }
//         if (firstName != null || lastName != null) {
//           userData!.name = firstName??'' + ' ' + (lastName ?? '');
//         }
//         if (phone != null) {
//           userData!.phone = phone;
//         }
//         if (image != null) {
//           userData!.image = image;
//         }
//         CacheHelper.saveUser(userData);
//        await getUserData();
//
//       });
//       // Add notification to the subcollection
//       notificationData['timestamp'] = DateTime.now();
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('notifications')
//           .add(notificationData);
//
//       emit(EditUserDataSuccessState());
//     } catch (error) {
//       print(error.toString());
//       emit(EditUserDataErrorState(error.toString()));
//     }
//   }
//make update user info like above function
  Future<void>? updateUserInfo(
      {required String fname,
      required String lname,
      required String phone,
      required String hourlyRate,
      required uid}) async {
    final updateData = <String, Object?>{};
    print('hourlyRate: $hourlyRate');
    print('fname: $fname');
    print('lname: $lname');
    print('phone: $phone');
    // print('password: $password');

    final notificationData = <String, dynamic>{};
    if (hourlyRate != null && hourlyRate != '' && hourlyRate != 'null') {
      print('hourlyRate: a7a $hourlyRate');
      updateData['hourlyRate'] = int.parse(hourlyRate);
      notificationData['message'] = 'تم تحديث معلومات الحساب الشخصية';
    }
    if (fname != null &&
        lname != null &&
        fname != '' &&
        lname != '' &&
        fname != 'null' &&
        lname != 'null') {
      updateData['name'] = '$fname $lname';
      updateData['fname'] = fname;
      updateData['lname'] = lname;

      //userData!.name = firstName + ' ' + (lastName ?? '');
    }
    if (fname != null && fname != '' && fname != 'null') {
      updateData['fname'] = fname;
      notificationData['message'] = 'تم تحديث معلومات الحساب الشخصية';
    }
    if (lname != null && lname != '' && lname != 'null') {
      updateData['lname'] = lname;
      notificationData['message'] = 'تم تحديث معلومات الحساب الشخصية';
    }
    if (phone != null && phone != '' && phone != 'null') {
      print('phone: a7a $phone');
      updateData['phone'] = phone.toString();
      notificationData['message'] = 'تم تحديث معلومات الحساب الشخصية';
    }
    //print updateData
    print('updateData: $updateData');

    notificationData['timestamp'] = DateTime.now();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notifications')
        .add(notificationData);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(updateData)
        .then((value) async {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get(GetOptions(source: Source.serverAndCache));

      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      UserModel user = UserModel.fromJson(userData!);
      if (updateData != null) {
        int userIndex = users.indexWhere((user) => user.uId == uid);
        if (userIndex != -1) {
          users[userIndex] = user;
        }
        //   emit(PaySalarySuccessStateWithoutInternet());
        return;
      }
    }).catchError((error) {
      print(error.toString());
      //emit(PaySalaryErrorStateWithoutInternet(error.toString()));
    });
  }

  Future<void> updatePassword(String password, String? uid) async {
    try {
      // Get the user using the uid
      final userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!userSnapshot.exists) {
        print('User not found');
        return;
      }

      // Get the user ID
      final userId = userSnapshot.id;

      // Update password
      await FirebaseAuth.instance.currentUser!.updatePassword(password);

      print('Successfully changed password');
    } catch (error) {
      print('Password change failed: $error');
    }
  }

  Future<void> sendMessage(
      {required BuildContext context, required String message, String? uid}) {
    //add notification to the subcollection of the user who will receive the message
    NotificationModel notification = NotificationModel(
      message: message,
      timestamp: DateTime.now(),
    );
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notifications')
        .add(notification.toMap())
        .then((value) {
      print('Notification added');
      //show toast message
      showToast(
        state: ToastStates.SUCCESS,
        msg: 'تم إرسال الرسالة',
      );
    }).catchError((error) {
      print('Failed to add notification: $error');
      showToast(msg: 'فشل إرسال الرسالة', state: ToastStates.ERROR);
    });
  }

  void getSchedulesForDay(String day) {
    emit(GetSchedulesForDayLoadingState());
    schedules = [];
    FirebaseFirestore.instance
        .collection('admins')
        //todo change this to admin id
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('schedules')
        .doc(day)
        .collection('schedules')
        .get(const GetOptions(source: Source.serverAndCache))
        .then((value) {
      value.docs.forEach((element) {
        schedules.add(SchedulesModel.fromJson2(element.data()));
      });
      emit(GetSchedulesForDaySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSchedulesForDayErrorState(error.toString()));
    });
  }

  Future deleteSchedule({
    required String scheduleId,
    required String day,
    required List<String>? usersIds,
  }) {
    emit(DeleteScheduleLoadingState());
    return FirebaseFirestore.instance
        .collection('admins')
        //todo change this to admin id
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('schedules')
        .doc(day)
        .collection('schedules')
        .doc(scheduleId)
        .delete()
        .then((value) async {
      print('Schedule deleted');

      // Delete the subcollection 'users'
      FirebaseFirestore.instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('schedules')
          .doc(day)
          .collection('schedules')
          .doc(scheduleId)
          .collection('users')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      // Remove the schedule from the list of schedules
      schedules.removeWhere((schedule) => schedule.scheduleId == scheduleId);

      // Delete the schedule from each user's collection
      if (usersIds != null) {
        for (String userId in usersIds) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('schedules')
              .doc(scheduleId)
              .delete()
              .then((value) {
            print('Schedule deleted from user $userId');
          }).catchError((error) {
            print('Failed to delete schedule from user $userId: $error');
          });
        }
      }

      emit(DeleteScheduleSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteScheduleErrorState(error.toString()));
    });
  }


  void updateSchedules(SchedulesModel schedule) {
     emit(UpdateSchedulesLoadingState());
    schedules.add(schedule);
    //sort based on start time
    schedules.sort((a, b) => a.startTime!.compareTo(b.startTime!));
    emit(UpdateSchedulesSuccessState());
  }

  //                     ManageSalaryCubit.get(context).deleteSchedule(
// scheduleId: scheduleId,
// );
//make function to delete schedule from firebase
}
