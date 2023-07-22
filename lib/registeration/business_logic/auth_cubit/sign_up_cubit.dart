import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/userModel.dart';
import 'sign_up_state.dart';
//**Collections and Documents:**
// 1. **users**: A collection to store the information of all coaches.   - Document ID: unique coach ID   - Fields: `name`, `level`, `hourly_rate`, `total_hours`, `total_salary`, `current_month_hours`, `current_month_salary`
// 2. **branches**: A collection to store the information of all branches.   - Document ID: unique branch ID   - Fields: `name`, `address`
// 3. **schedules**: A collection to store the information of all schedules.   - Document ID: unique schedule ID   - Fields: `coach_id`, `branch_id`, `start_time`, `end_time`, `date`,  `finished `,
// 4. **attendanceRequests**: A collection to store the attendance requests sent by coaches.   - Document ID: unique attendance request ID   - Fields: `coach_id`, `schedule_id`, `status`(e.g. 'pending', 'accepted', 'rejected')
// 5. **salaryHistory**: A subcollection inside the coach document to store the salary history of each coach.   - Document ID: unique salary history ID (usually just the month and year)   - Fields: `month`, `year`, `total_hours`, `total_salary`

// **Workflow:**
// 1. When a coach logs in, retrieve their information from the `coaches` collection, display their name, training hours, and branches they're assigned to.
// 2. To display the schedules for each coach, query the `schedules` collection with the `coach_id`. Use the `branch_id` to get branch details from the `branches` collection.
// 3. When a coach arrives at their schedule, they create a new document in the `attendanceRequests` collection with the `coach_id`, `schedule_id`, and `status` as 'pending'.
// 4. The admin reviews the attendance requests and updates the `status` field to 'accepted' or 'rejected'.
// 5. Upon receiving an 'accepted' status, calculate the hours worked for that schedule and update the coach's `total_hours`, `total_salary`, `current_month_hours`, and `current_month_salary` in the `coaches` collection.
// 6. At the end of each month, create a new document in the `salaryHistory` subcollection for each coach, storing their `total_hours` and `total_salary` for the current month. After that, reset the `current_month_hours` and `current_month_salary` fields in the `coaches` collection.
// 7. To display the salary history for each coach, query the `salaryHistory` subcollection inside the coach document and show the list containing the current month's total hours and salary, along with all previous months.
// This design allows you to efficiently handle the required functionality while minimizing the number of reads and writes to the Firestore database.

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(InitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
bool showPassword = true;
void changePasswordVisibility(){
  showPassword = !showPassword;
  emit(ChangePasswordVisibilityState());
}
//function to check if email and password are in firebase

//make function yo update new password in firebase
  Future<void> updatePassword({
    required String password,
  }) async {
    emit(UpdatePasswordLoadingState());
    FirebaseAuth.instance.currentUser!.updatePassword(password).then((value) {
      emit(UpdatePasswordSuccessState());
    }).catchError((error) {
      String? errorMessage;
      switch (error.code) {
        case "weak-password":
          if (kDebugMode) {
            print(errorMessage);
            errorMessage = 'The password provided is too weak.';
          }
          break;
        case "email-already-in-use":
          if (kDebugMode) {
            print(errorMessage);
            errorMessage = 'The account already exists for that email.';
          }
          break;
        case "invalid-email":
          if (kDebugMode) {
            print(errorMessage);
            errorMessage = 'The email address is badly formatted.';
          }
          break;
        case "operation-not-allowed":
          if (kDebugMode) {
            print(errorMessage);
            errorMessage = 'Email/password accounts are not enabled.';
          }
          break;
        default:
          if (kDebugMode) {
            errorMessage = 'The error is $error';
            print(errorMessage);
          }
      }
      emit(UpdatePasswordErrorState(
        error: errorMessage,
      ));
    });
  }

  Future<void> signUp({
    required String lName,
    required String fName,
    required String phone,
    required String password,
  }) async {
    emit(SignUpLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '$phone@placeholder.com',
        password: password
    ).then((value) {
      print(value.user!.uid);
      createUser(
        uId: value.user!.uid,
        phone: phone,
        fname: fName,
        lname: lName,
      );
      emit(SignUpSuccessState(value.user!.uid));
    }).catchError((error) {
      String? errorMessage;
   switch (error.code) {
     //case user already exists
          case "email-already-in-use":
            if (kDebugMode) {
              print(errorMessage);
            errorMessage = 'The account already exists for that email.';
            }
            break;
         case "invalid-email":
            if (kDebugMode) {
              print(errorMessage);
            errorMessage = 'The email address is badly formatted.';
            }
            break;
          case "user-not-found":
            if (kDebugMode) {
              print(errorMessage);
            errorMessage = 'No user found for that email.';
            }
            break;
          case "wrong-password":
            if (kDebugMode) {
              print(errorMessage);
            errorMessage = 'Wrong password provided for that user.';
            }
            break;
          default:
            if (kDebugMode) {
              errorMessage = 'The error is $error';
              print(errorMessage);
            }
    }
      emit(SignUpErrorState(
        error: errorMessage,
      ));
    });
  }

  void createUser({
    required String? uId,
    required String? phone,
    required String? fname,
    required String? lname,
  }) {
    emit(CreateUserLoadingState());
    UserModel model = UserModel(
      phone: phone,
        uId: uId,
        name: 'Write your name...',
        level: 3,
        hourlyRate: 30,
        totalHours: 0,
        totalSalary: 0,
        currentMonthHours: 0,
        currentMonthSalary: 0,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(uId!));
    }).catchError((error) {
      emit(CreateUserErrorState());
    });
  }
  
}

