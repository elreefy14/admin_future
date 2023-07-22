// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// //import 'package:connectivity/connectivity.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:swimmer_app/core/cashe_helper.dart';
// import '../../../registeration/data/user_cache_model.dart';
// import '../../data/Notification.dart';
// import '../../data/schedules.dart';
// import '../../data/userModel.dart';
// import '../../presenation/dash_board_screan.dart';
// import '../../presenation/home_lauout.dart';
// import '../../presenation/notification_screen.dart';
// import '../../presenation/profile_screen.dart';
// import '../../presenation/qr_screen.dart';
// import 'home_state.dart';
// // ****this is my firestore Collections and Documents:**
// // - *users*: A collection to store the information of all coaches.
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
// // - Subcollection: *`coaches`*
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
//
// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(InitialState()) {
//     // Call this method when connectivity changes
//    // _listenToConnectivityChanges();
//     //initControllers();
//   }
//   Future<void> getUserData() async {
//     emit(GetUserDataLoadingState());
//     if (await checkInternetConnection()) {
//       final user = FirebaseAuth.instance.currentUser;
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .get()
//           .then((value) {
//         if (value.exists) {
//           var data = value.data();
//           userCacheModel = UserCacheModel(
//             image: data?['image']??'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
//             email: user.email??'${data?['phone']}@placeholder.com',
//             phone: data?['phone'],
//             token:data?['deviceToken'][0],
//             uId: user.uid,
//             fname: data?['fname'],
//             lname: data?['lname'],
//             name: data?['name'],
//             level: data?['level'],
//             hourlyRate: data?['hourlyRate']??30,
//             totalHours: data?['totalHours']??0,
//             totalSalary: data?['totalSalary']??0,
//             currentMonthHours: data?['currentMonthHours']??0,
//             currentMonthSalary: data?['currentMonthSalary']??0,
//             branches: (data?['branches'] as List<dynamic>).map((branch) => branch.toString()).toList(),
//           );
//           CacheHelper.saveUser(userCacheModel);
//           emit(GetUserDataSuccessState());}
//       }).catchError((error) {
//         print(error.toString());
//         emit(GetUserDataErrorState(error: error.toString()));
//       });
//     } else {
//       userCacheModel = await CacheHelper.getUser();
//       emit(GetUserDataSuccessState());
//     }
//   }
//   final List<Widget> _screens = [
//     DashBoard(),
//     QrScreen(),
//     ProfileScreen(),
//     NotificationScreen(),
//     EditProfile(),
//   ];
// //check internet connection without using connectivity package
//   Future<bool> checkInternetConnection() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         return true;
//       }
//     } on SocketException catch (_) {
//       return false;
//     }
//     return false;
//   }
//
//   static HomeCubit get(context) => BlocProvider.of(context);
//
//   final formKey = GlobalKey<FormState>();
//   late TextEditingController firstNameController;
//   late TextEditingController lastNameController;
//   late TextEditingController phoneController;
//
//   void initControllers() {
//     firstNameController = TextEditingController(text: userCacheModel?.fname);
//     lastNameController = TextEditingController(text: userCacheModel?.lname??'kol');
//     phoneController = TextEditingController(text: userCacheModel?.phone??'011');
//   }
//
//
//   String? profilePicURL;
//
//   Future<void> uploadProfilePic(
//
//       ) async {
//     firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child(Uri.file(profileImage!.path).pathSegments.last)
//         .putFile(profileImage!)
//         .then((value) {
//       value.ref.getDownloadURL().then((value) {
//         editUserData(
//           image: value,
//         );
//         emit(UploadProfilePicSuccessState());
//       }).catchError((error) {
//         print(error.toString());
//         emit(UploadProfilePicErrorState());
//       });
//       emit(UploadProfilePicSuccessState());
//     }).catchError((error) {
//       print(error.toString());
//       emit(UploadProfilePicErrorState());
//     });
//   }
//   File? profileImage;
//   ImagePicker? picker = ImagePicker();
//
//   Future? getProfileImage() async {
//     final pickedFile = await picker?.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       profileImage =  File(pickedFile.path);
//       await uploadProfilePic();
//       emit(GetProfilePicSuccessState());
//     } else {
//       print('No Image Selected');
//       emit(GetProfilePicErrorState());
//     }
//   }
//   void editUserData({
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
// //static Future<UserCacheModel?> getUser() async {
// //     final jsonString = sharedPreferences.getString(AppStrings.userCacheModel);
// //     if (jsonString == null) {
// //       return null;
// //     }
// //     return UserCacheModel.fromJson(json.decode(jsonString));
// //   }
//   //get user data from shared pref
//   UserCacheModel? userCacheModel;
//   //checkInternetConnection
//   //if true
//   //get data from firebase
//   //else
//   //get data from shared pre
//
// //   List<String> listOfImages = [
// //     'assets/images/dashboard-2_svgrepo.com.png',
// //     'assets/images/scan-qrcode_svgrepo.com.png',
// //     'assets/images/🦆 icon _person_.png',
// //     'assets/images/Vector.png',
// //   ];
//   List<String> listOfTitles = [
//   'لوحة التحكم',
//   'مسح الكود',
//   'الملف الشخصي',
//   'الاشعارات',
// ];
//
//
//
//   //listOfIcons which is list of ImageIcons
//   final List<String> listOfIcons = [
//    'assets/images/dashboard-2_svgrepo.com.svg',
//    'assets/images/scan-qrcode_svgrepo.com.svg',
//    'assets/images/🦆 icon _person_.svg',
//    'assets/images/Vector.svg',
//   ];
//
// //function to select screen
//   int _currentIndex = 0;
//   //setter for current index
//
//
//   int get currentIndex => _currentIndex;
//   Widget get currentScreen => _screens[_currentIndex];
//   void changeBottomNav(int index) {
//     _currentIndex = index;
//     emit(ChangeBottomNavState());
//   }
// //make notification mode contain body and date fiels l .use flutter .i want to make function to store latest 20 notifications which is subcolection in users collection in shared  .it get the the latest notification from shared pref and get notification from firebase where it eariler than it . shared pref will contain list of only 20 item max . this my firebase firestore data base design .- *coaches*: A collection to store the information of all coaches.
// //     - Document ID: unique coach ID
// //     - Fields: *`name`, `level`, `hourly_rate`, `total_hours`, `total_salary`, `current_month_hours`, `current_month_salary`*
// //     - Subcollection: *`schedules`*
// //         - Document ID: unique schedule ID
// //         - Fields: *`branch_id`, `start_time`, `end_time`, `date`, `finished`*
// //         - Subcollection: *`attendance`*
// //             - Document ID: unique attendance ID (usually just the coach ID)
// //             - Fields: *`attended`, `qr_code`*
// //     - Subcollection: *`salaryHistory`*
// //         - Document ID: unique salary history ID (usually just the month and year)
// //         - Fields: *`month`, `year`, `total_hours`, `total_salary`*
// //     - Fields: *`branches`* (array of branch IDs that the coach works at)
// // - *branches*: A collection to store the information of all branches.
// //     - Document ID: unique branch ID
// //     - Fields: *`name`, `address`*
// //     - Subcollection: *`coaches`*
// //         - Document ID: unique coach ID who works at this branch
// // - *admins*: A collection to store the information of all admins.
// //     - Document ID: unique admin ID
// //     - Fields: *`name`, `email`, `branch_id`* (the ID of the branch they're responsible for)
// // - *schedules*: A collection to store the information of all schedules.
// //     - Document ID: unique schedule ID
// //     - Fields: *`branch_id`, `start_time`, `end_time`, `date`*
// //     - Subcollection: *`attendance`*
// //         - Document ID: unique attendance ID (usually just the coach ID)
// //         - Fields: *`attended`, `qr_code`*
//   Future<void> saveLatestNotifications(List<NotificationModel> notifications) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonList = notifications.map((n) => jsonEncode(n)).toList();
//     prefs.setStringList('latest_notifications', jsonList);
//   }
//   //clear notifications
//   Future<void> clearNotifications() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove('latest_notifications');
//   }
//   List<NotificationModel> todayNotifications = [];
//   List<NotificationModel> oldNotifications = [];
//   Future<List<NotificationModel>> getNotifications() async {
//     oldNotifications = [];
//     todayNotifications = [];
//     emit(GetNotificationsLoadingState());
//
//     final prefs = await SharedPreferences.getInstance();
//     final jsonList = prefs.getStringList('latest_notifications') ?? [];
//     NotificationModel? latestNotification =
//     jsonList.isNotEmpty ? NotificationModel.fromJson(jsonDecode(jsonList.first)) : null;
//     print('latestNotification: ${latestNotification?.timestamp}}');
//
//     List<NotificationModel> notifications = [];
//
//     if (await checkInternetConnection()) {
//       notifications = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid ?? 'fnBisJY3vGgHL3on0tYeAJWI5GA2')
//           .collection('notifications')
//           .where('timestamp', isGreaterThan: latestNotification?.timestamp ?? DateTime.fromMicrosecondsSinceEpoch(0))
//           .orderBy('timestamp', descending: true)
//        //   .limit(30 - jsonList.length)
//           .get()
//           .then((querySnapshot) {
//         return querySnapshot.docs.map((doc) {
//           final data = doc.data();
//         //  doc.reference.delete(); // Delete the notification from Firestore
//           return NotificationModel(message: data['message'], timestamp: data['timestamp'].toDate());
//         }).toList();
//       });
//     }
//
//     final allNotifications = [
//       ...notifications,
//       ...jsonList.map((json) => NotificationModel.fromJson(jsonDecode(json)))
//     ];
//     allNotifications.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
//
//     if (allNotifications.length > 30) {
//       allNotifications.removeRange(30, allNotifications.length);
//     }
//
//     await saveLatestNotifications(allNotifications);
//
//     allNotifications.forEach((element) {
//       if(element.timestamp!.day == DateTime.now().day){
//         todayNotifications.add(element);
//       }else{
//         oldNotifications.add(element);
//       }
//     });
//     print('allNotifications: ${allNotifications.map((n) => n.message).toList()}');
//     emit(GetNotificationsSuccessState(
//       notifications:  allNotifications,
//     ));
//     return allNotifications;
//   }
//
//   // Future<List<SchedulesModel>?> getAllSchedulesForSpecificUser() async {
//   //   await initializeDateFormatting('ar');
//   //  // await CacheHelper.clearSchedulesFromSharedPreferences();
//   //   emit(LoadingState());
//   //   print('Getting all schedules for specific coach');
//   //
//   //   // Check if there is an internet connection
//   //   bool hasInternet = await checkInternetConnection();
//   //
//   //   // Retrieve schedules from the cache
//   //   List<SchedulesModel>? schedules = await CacheHelper.getSchedulesFromSharedPreferences();
//   //   print('schedules.length: ${schedules.length}');
//   //   print('\n\n\n\n\n');
//   //
//   //   // If there is no internet connection, return schedules from the cache
//   //   if (!hasInternet) {
//   //
//   //     emit(GetAllSchedulesForSpecificCoachSuccessState(
//   //       schedules: schedules ?? [],
//   //     ));
//   //
//   //     return schedules;
//   //   }
//   //
//   //   // If there is an internet connection, retrieve schedules from Firestore
//   //   if (schedules.length < 20) {
//   //     DateTime now = DateTime.now();
//   //     DateTime lastDateInSharedPreferences = schedules.isNotEmpty ? schedules.last.date!.toDate() : //DATETIME.now -5 days
//   //     DateTime(now.year, now.month, now.day - 5);
//   //     print('lastDateInSharedPreferences: $lastDateInSharedPreferences');
//   //     print('now: $now');
//   //
//   //     FirebaseFirestore.instance
//   //         .collection('users')
//   //         .doc(FirebaseAuth.instance.currentUser!.uid ?? 'fnBisJY3vGgHL3on0tYeAJWI5GA2')
//   //         .collection('schedules')
//   //         .orderBy('start_time', descending: false)
//   //         .startAfter([
//   //       if (lastDateInSharedPreferences != null) Timestamp.fromDate(lastDateInSharedPreferences),
//   //       if (schedules.isNotEmpty && schedules.last.startTime != null) schedules.last.startTime!,
//   //     ])
//   //         .limit(20 - schedules.length)
//   //         .get()
//   //         .then((querySnapshot) async {
//   //       print('Successfully retrieved all schedules for specific coach');
//   //       print('querySnapshot.docs.length: ${querySnapshot.docs.length}');
//   //       //edit this to show start time like this 12:00 am
//   //       querySnapshot.docs.forEach((doc) {
//   //         var schedule = SchedulesModel.fromJson2(doc.data());
//   //         var startTime = DateFormat('hh a', 'ar').format(schedule.startTime!.toDate());
//   //         var date = DateFormat('yyyy/MM/dd EEEE', 'ar').format(schedule.startTime!.toDate());
//   //         var formattedSchedule = '$startTime $date';
//   //         print('formattedSchedule: $formattedSchedule');
//   //         schedules?.add(schedule);
//   //       });
//   //
//   //       // Sort schedules in descending order based on the date
//   //       schedules?.sort((a, b) => b.startTime!.compareTo(a.startTime!));
//   //
//   //       // Keep only the latest 20 schedules
//   //       schedules = schedules?.take(20).toList();
//   //
//   //       await CacheHelper.storeSchedulesInSharedPreferences(schedules!);
//   //       print('schedules.lengthtt: ${schedules?.length}');
//   //       emit(GetAllSchedulesForSpecificCoachSuccessState(
//   //         schedules: schedules ?? [],
//   //       ));
//   //     }).catchError((error) {
//   //       print('Failed to retrieve all schedules for specific coach due to error: $error');
//   //       emit(GetAllSchedulesForSpecificCoachErrorState(error: error.toString()));
//   //     });
//   //   } else {
//   //     emit(GetAllSchedulesForSpecificCoachSuccessState(
//   //       schedules: schedules ?? [],
//   //     ));
//   //   }
//   //
//   //   return schedules;
//   // }
// //
//
//
//   Future<List<SchedulesModel>?> getAllSchedulesForSpecificUser2() async {
//     //SharedPreferences.setMockInitialValues({});
//    await initializeDateFormatting('ar');
//     await CacheHelper.clearSchedulesFromSharedPreferences();
//     emit(LoadingState());
//     print('Getting all schedules for specific coach');
//     print('FirebaseAuth.instance.currentUser!.uid: ${FirebaseAuth.instance.currentUser!.uid}');
//     List<SchedulesModel>? schedules = await CacheHelper.getSchedulesFromSharedPreferences();
//     print('schedules.length: ${schedules?.length ?? 0}');
//     print('\n\n\n\n\n');
// //daebug dateTimes.now
//     print('DateTime.now(): ${DateTime.now()}');
//     // Delete schedules with start time before today
//     schedules?.removeWhere((schedule) => schedule.startTime!.toDate().isBefore(DateTime.now()));
//      bool hasInternet = await checkInternetConnection();
//     if (!hasInternet) {
//       emit(GetAllSchedulesForSpecificCoachSuccessState(
//         schedules: schedules ?? [],
//       ));
//       return schedules;
//     }
//     if (schedules.length < 20) {
//       DateTime now = DateTime.now();
//       DateTime lastDateInSharedPreferences = schedules.isNotEmpty ? schedules.last.startTime!.toDate() : //DATETIME.now -5 days
//       DateTime(now.year, now.month, now.day - 5);
//       print('lastDateInSharedPreferences: $lastDateInSharedPreferences');
//       print('now: $now');
//
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid ?? 'fnBisJY3vGgHL3on0tYeAJWI5GA2')
//           .collection('schedules')
//           .orderBy('start_time', descending: false)
//           .startAfter([
//        // if (lastDateInSharedPreferences != null) Timestamp.fromDate(lastDateInSharedPreferences),
//         if (schedules.isNotEmpty && schedules.last.startTime != null) schedules.last.startTime! else
//           Timestamp.fromDate(DateTime.now()),
//            ]).limit(20 - schedules.length)
//           .get()
//           .then((querySnapshot) async {
//
//         print('Successfully retrieved all schedules for specific coach');
//         print('querySnapshot.docs.length: ${querySnapshot.docs.length}');
//         //edit this to show start time like this 12:00 am
//         if( querySnapshot.docs.length != 0) {
//           querySnapshot.docs.forEach((doc) {
//             var schedule = SchedulesModel.fromJson2(doc.data());
//             // var startTime = DateFormat('hh:mm a', 'ar').format(
//             //     schedule.startTime!.toDate());
//             // var date = DateFormat('yyyy/MM/dd EEEE', 'ar').format(
//             //     schedule.startTime!.toDate());
//             // var formattedSchedule = '$startTime $date';
//             // print('formattedSchedule: $formattedSchedule');
//             schedules?.add(schedule);
//           });
//
//           // Sort schedules in ascending order based on the date
//           //schedules?.sort((a, b) => b.startTime!.compareTo(a.startTime!));
//           schedules?.sort((a, b) => a.startTime!.compareTo(b.startTime!));
//
//           // Keep only the latest 20 schedules
//           schedules = schedules?.take(20).toList();
//  //loop on schedules and print each one
//           schedules?.forEach((element) {
//             print('element: ${element.startTime}');
//           });
//           await CacheHelper.storeSchedulesInSharedPreferences(schedules!);
//           print('schedules.lengthtt: ${schedules?.length}');
//
//         }else
//         emit(GetAllSchedulesForSpecificCoachSuccessState(
//           schedules: schedules ?? [],
//         ));
//       },
//       ).catchError((error) {
//         print('Failed to retrieve all schedules for specific coach due to error: $error');
//         emit(GetAllSchedulesForSpecificCoachErrorState(error: error.toString()));
//       });
//     }
//     return schedules;
//   }
//
//
//   List<SchedulesModel>? schedulesList;
//
//   Future<List<SchedulesModel>?> getAllSchedulesForSpecificUser() async  {
// //SharedPreferences.setMockInitialValues({});
//     await initializeDateFormatting('ar');
// //await CacheHelper.clearSchedulesFromSharedPreferences();
//     emit(LoadingState());
//     print('Getting all schedules for specific coach');
//     print('FirebaseAuth.instance.currentUser!.uid: ${FirebaseAuth.instance.currentUser!.uid}');
//     schedulesList = await CacheHelper.getSchedulesFromSharedPreferences();
//     print('schedules.length: ${schedulesList?.length ?? 0}');
//     print('\n\n\n\n\n');
// //daebug dateTimes.now
//     print('DateTime.now(): ${DateTime.now()}');
// // Delete schedules with start time before today
//     schedulesList?.removeWhere((schedule) => schedule.startTime!.toDate().isBefore(DateTime.now()));
//     bool hasInternet = await checkInternetConnection();
//     if (!hasInternet) {
//       emit(GetAllSchedulesForSpecificCoachSuccessState(
//         schedules: schedulesList ?? [],
//       ));
//       return schedulesList;
//     }
//     //if ((schedulesList?.length ?? 0) < 20) {
//     if ((schedulesList?.length ?? 0) < 20) {
//     //if (schedulesList?.length   < 20) {
//       DateTime now = DateTime.now();
//       DateTime? lastDateInSharedPreferences = schedulesList!.isNotEmpty ? schedulesList?.last.startTime!.toDate() : //DATETIME.now -5 days
//       DateTime(now.year, now.month, now.day - 5);
//       print('lastDateInSharedPreferences: $lastDateInSharedPreferences');
//       print('now: $now');
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid ?? 'fnBisJY3vGgHL3on0tYeAJWI5GA2')
//           .collection('schedules')
//           .orderBy('start_time', descending: false)
//           .startAfter([
//         // if (lastDateInSharedPreferences != null) Timestamp.fromDate(lastDateInSharedPreferences),
//         if (schedulesList!.isNotEmpty && schedulesList!.last.startTime != null) schedulesList!.last.startTime! else
//           Timestamp.fromDate(DateTime.now()),
//       ]).limit(20 - schedulesList!.length??0)
//           .get()
//           .then((querySnapshot) async {
//
//         print('Successfully retrieved all schedules for specific coach');
//         print('querySnapshot.docs.length: ${querySnapshot.docs.length}');
//         //edit this to show start time like this 12:00 am
//         if( querySnapshot.docs.length != 0) {
//           querySnapshot.docs.forEach((doc) {
//             var schedule = SchedulesModel.fromJson2(doc.data());
//             schedulesList?.add(schedule);
//           });
//
//           // Sort schedules in ascending order based on the date
//           schedulesList?.sort((a, b) => a.startTime!.compareTo(b.startTime!));
//
//           // Keep only the latest 20 schedules
//           schedulesList = schedulesList?.take(20).toList();
//           //loop on schedules and print each one
//           schedulesList?.forEach((element) {
//             print('element: ${element.startTime}');
//           });
//           await CacheHelper.storeSchedulesInSharedPreferences(schedulesList!);
//           print('schedules.lengthtt: ${schedulesList?.length}');
//           emit(GetAllSchedulesForSpecificCoachSuccessState(
//             schedules: schedulesList ?? [],
//           ));
//         }else
//           emit(GetAllSchedulesForSpecificCoachSuccessState(
//             schedules: schedulesList ?? [],
//           ));
//       },
//       ).catchError((error) {
//         print('Failed to retrieve all schedules for specific coach due to error: $error');
//         emit(GetAllSchedulesForSpecificCoachErrorState(error: error.toString()));
//       });
//     }
//     return schedulesList;
//   }
//   ///////////////////////////////////////////////////////////////////
//   // Add this method to listen for connectivity changes
//   // void _listenToConnectivityChanges() {
//   //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
//   //     if (result != ConnectivityResult.none) {
//   //       print('Network is available');
//   //       await syncOfflineAttendanceData();
//   //     } else {
//   //       print('Network is not available');
//   //     }
//   //   });
//   // }
//
//   Future<void> saveAttendanceDataLocally(String coachId, String scheduleId, DateTime timestamp) async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     List<String> attendanceList = sharedPreferences.getStringList('offlineAttendance') ?? [];
//
//     Map<String, dynamic> attendanceData = {
//       'coach_id': coachId,
//       'schedule_id': scheduleId,
//       'timestamp': timestamp.toIso8601String(),
//     };
//
//     attendanceList.add(jsonEncode(attendanceData));
//     sharedPreferences.setStringList('offlineAttendance', attendanceList);
//     print('Attendance data saved locally');
//   }
//
//   // Future<bool> isConnected() async {
//   //   ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
//   //   return connectivityResult != ConnectivityResult.none;
//   // }
//
//   Future<void> syncOfflineAttendanceData() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     List<String> attendanceList = sharedPreferences.getStringList('offlineAttendance') ?? [];
//
//     if (attendanceList.isNotEmpty) {
//       print('Syncing offline attendance data...');
//       for (String attendanceJson in attendanceList) {
//         Map<String, dynamic> attendanceData = jsonDecode(attendanceJson);
//
//         // Check for duplicates or conflicts before uploading
//         // ...
//
//         // Get the scheduleid and timestamp from the attendance data
//         // then go to the schedules collection and make finished = true for the schedule with this id and timestamp
//         print('Syncing attendance data for schedule ID ${attendanceData['schedule_id']}');
//         await addAttendance(attendanceData['schedule_id']);
//       }
//       // Clear the locally stored attendance data after successful sync
//       sharedPreferences.remove('offlineAttendance');
//       print('Offline attendance data synced successfully');
//     } else {
//       print('No offline attendance data to sync');
//     }
//   }
//
//   //edit this function to get schedules for current coach and date(timeStamp) equal to today and finished = false
//   //subtract start time for each schedule from timestamp.now and get the smallest one
//   //make bool finished = true for the smallest one
//   //this is my **Collections and Documents:**
// // 1. **users**: A collection to store the information of all coaches.   - Document ID: unique coach ID   - Fields: `name`, `level`, `hourly_rate`, `total_hours`, `total_salary`, `current_month_hours`, `current_month_salary`
// // 2. **branches**: A collection to store the information of all branches.   - Document ID: unique branch ID   - Fields: `name`, `address`
// // 3. **schedules**: A collection to store the information of all schedules.   - Document ID: unique schedule ID   - Fields: `coach_id`, `branch_id`, `start_time`, `end_time`, `date`,  `finished `,
// // 4. **attendanceRequests**: A collection to store the attendance requests sent by coaches.   - Document ID: unique attendance request ID   - Fields: `coach_id`, `schedule_id`, `status`(e.g. 'pending', 'accepted', 'rejected')
// // 5. **salaryHistory**: A subcollection inside the coach document to store the salary history of each coach.   - Document ID: unique salary history ID (usually just the month and year)   - Fields: `month`, `year`, `total_hours`, `total_salary`
//   Future<void> onQRCodeScanned({required String coachId, required String scheduleId}) async {
//     DateTime timestamp = DateTime.now();
//    Timestamp today = Timestamp.fromDate(DateTime.now());
//
//     if (true) {
//     //if (await isConnected()) {
//       // Get today's unfinished schedules for the current coach
//       // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       //     .collection('schedules')
//       //     .where('coach_id', isEqualTo: coachId)
//       //     .where('date', isEqualTo: today)
//       //     .where('finished', isEqualTo: false)
//       //     .get();
//       //
//       // // If there are any unfinished schedules
//       // if (querySnapshot.docs.isNotEmpty) {
//       //   // Find the schedule closest to the current time
//       //   DocumentSnapshot closestSchedule = querySnapshot.docs.first;
//       //   Duration smallestDuration = timestamp
//       //       .difference(closestSchedule['start_time'].toDate())
//       //       .abs();
//       //
//       //   for (DocumentSnapshot doc in querySnapshot.docs) {
//       //     Duration currentDuration =
//       //     timestamp.difference(doc['start_time'].toDate()).abs();
//       //     if (currentDuration < smallestDuration) {
//       //       smallestDuration = currentDuration;
//       //       closestSchedule = doc;
//       //     }
//       //   }
//
//         // Update the closest schedule's finished status to true
//         // await FirebaseFirestore.instance
//         //     .collection('schedules')
//         //     .doc(scheduleId)
//         //     .update({'finished': true});
//       addAttendance(scheduleId);
//     //  }
//     } else {
//       print('No internet connection, saving attendance data locally');
//       await saveAttendanceDataLocally(coachId, scheduleId, timestamp);
//     }
//   }
//   Future<void> addAttendance(String scheduleId) async {
//     await FirebaseFirestore.instance
//         .collection('schedules')
//         .doc(scheduleId)
//         .update({
//       'finished': true,
//     });
//
//     final scheduleSnapshot = await FirebaseFirestore.instance
//         .collection('schedules')
//         .doc(scheduleId)
//         .get();
//
//     final start = scheduleSnapshot['startTime'] as Timestamp;
//     final end = scheduleSnapshot['endTime'] as Timestamp;
//
//     final startTime = start.toDate();
//     final endTime = end.toDate();
//
//     final duration = endTime.difference(startTime).inHours;
//
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(scheduleSnapshot['coachId'])
//         .update({'totalHours': FieldValue.increment(duration)});
//
//     print('Attendance added successfully');
//   }
//
// // admin (
// // genereate qr code
//   //
// // Generate a QR code for the schedule using the UUID
//  // QrImage qrImage = QrImage(
//  //   data: 'schedule:$scheduleId',
//  //   version: QrVersions.auto,
//  //   size: 200.0,
//   //);
//   //TODO;subtract now - start time get first schedule
//   Future<void> generateQrImageBasedOnNearestSchedule() async {
//     emit(GenerateQrImageLoadingState());
//
//     // Get the current timestamp
//     DateTime timestamp = DateTime.now();
//     Timestamp now = Timestamp.fromDate(timestamp);
//
//
//     // Query Firestore for the nearest schedule
//     QuerySnapshot scheduleQuerySnapshot = await FirebaseFirestore.instance
//         .collection('schedules')
//         .where('finished', isEqualTo: false)
//         //.where('start_time', isGreaterThan: now)
//         //.orderBy('start_time', descending: false)
//         .get();
//
//     // Check if any schedules were found
//     QrImage qrImage;
//     if (scheduleQuerySnapshot.docs.isNotEmpty) {
//       // Get the ID of the first schedule document
//       String scheduleId = scheduleQuerySnapshot.docs.first.id;
//
//       // Generate a QR code image with the schedule ID as data
//
//       print('\n\n\n\n\n');
//       print('$scheduleId');
//       print('$scheduleId');
//       print('$scheduleId');
//       print('$scheduleId');
//       print('$scheduleId');
//       print('\n\n\n\n\n\n\n');
//
//       qrImage = QrImage(
//         data: scheduleId,
//         version: QrVersions.auto,
//         size: 200.0,
//       );
//       emit(GenerateQrImageSuccessState());
//     } else {
//       // Handle case where no schedules were found
//       qrImage = QrImage(
//         data: "No schedules found",
//         version: QrVersions.auto,
//         size: 200.0,
//       );
//       emit(GenerateQrImageErrorState(
//           error:'error'
//       ));
//     }
//
//
//     // // If there are any unfinished schedules
//     // if (querySnapshot.docs.isNotEmpty) {
//     //   // Find the schedule closest to the current time
//     //   DocumentSnapshot closestSchedule = querySnapshot.docs.first;
//     //   Duration smallestDuration = timestamp
//     //       .difference(closestSchedule['start_time'].toDate().millisecondsSinceEpoch)
//     //       .abs();
//     //
//     //   for (DocumentSnapshot doc in querySnapshot.docs) {
//     //     Duration currentDuration = timestamp
//     //         .difference(doc['start_time'].toDate().millisecondsSinceEpoch)
//     //         .abs();
//     //     if (currentDuration < smallestDuration) {
//     //       smallestDuration = currentDuration;
//     //       closestSchedule = doc;
//     //     }
//     //   }
//
//       // Generate a QR code for the schedule using the UUID
//
//
//       // Update the QR image
//
//
//
//     }
//   Future<void> addScheduleToCoachCollection() async {
//     emit(LoadingState());
//     print('Adding schedule to coach collection');
//     await CacheHelper.clearSchedulesFromSharedPreferences();
//
//     final Random random = Random();
//
//     for (int i = 0; i < 1; i++) {
//       // Generate a random start time between 9:00 AM and 5:00 PM
//       final int startHour = random.nextInt(8) + 9;
//       final int startMinute = random.nextInt(4) * 15;
//       final DateTime startTime = DateTime(2040, 5, random.nextInt(9) + 17, startHour, startMinute);
//
//       // Generate a random end time between 1 and 3 hours after the start time
//       final int duration = random.nextInt(2) + 1;
//       final DateTime endTime = startTime.add(Duration(hours: duration));
//
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection('schedules')
//           .add({
//         'branch_id': 'edasdaseeeeeeee',
//         'coach_id': 'awak4gIQ28SdtDYLJIEF9phS20p2',
//         'start_time': Timestamp.fromDate(startTime),
//         'end_time': Timestamp.fromDate(endTime),
//         'finished': false,
//       })
//           .then((value) {
//         print('Successfully added schedule to coach collection');
//         emit(AddScheduleToCoachCollectionSuccessState());
//       })
//           .catchError((error) {
//         print('Failed to add schedule to coach collection due to error: $error');
//         emit(AddScheduleToCoachCollectionErrorState(error: error.toString()));
//       });
//     }
//   }
//
//   clearNotificationsfromcache() {
//     CacheHelper.clearNotificationsFromSharedPreferences();
//   }
//   Future<void> generateRandomNotifications() async {
//     for (int i = 0; i < 20; i++) {
//       await generateRandomNotification();
//     }
//   }
//   Future<void> generateRandomNotification() async {
//     final random = Random();
//     final notificationsCollection = FirebaseFirestore.instance.collection('users').doc('fnBisJY3vGgHL3on0tYeAJWI5GA2').collection('notifications');
//
//     final daysAgo = random.nextInt(30);
//     final notification = {
//       'body': 'Notification ${random.nextInt(100)}',
//       'date': DateTime.now().add(Duration(days: daysAgo)),
//     };
//
//     await notificationsCollection.add(notification);
//
//   }
// }
