import 'dart:io';

import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:admin_future/home/business_logic/Home/manage_salary_cubit.dart';
import 'package:admin_future/registeration/data/userModel.dart';
import 'package:admin_future/registeration/business_logic/auth_cubit/login_cubit.dart';
import 'package:admin_future/registeration/business_logic/auth_cubit/sign_up_cubit.dart';
import 'package:admin_future/registeration/presenation/SignUpScreen.dart';
import 'package:admin_future/registeration/presenation/add_coach_screen.dart';
import 'package:admin_future/registeration/presenation/login_screen.dart';
import 'package:admin_future/registeration/presenation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'add_grouup_of_schedules/presentation/onboarding_screen.dart';
import 'core/constants/routes_manager.dart';
import 'core/constants/strings.dart';
import 'home/presenation/widget/add_schedule.dart';
import 'home/presenation/widget/edit_users.dart';
import 'home/presenation/widget/home_layout.dart';
import 'home/presenation/widget/manage_attendence.dart';
import 'home/presenation/widget/manage_users.dart';
import 'home/presenation/widget/manage_schedules_screen.dart';
import 'home/presenation/widget/mange_coaches.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      //OnboardingScreen
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      //AddSchedule
//AddCoachScreen
case AppRoutes.addCoach:
  args = settings.arguments as Map<String, dynamic>;
  return MaterialPageRoute(builder: (_) => AddCoachScreen(
    isCoach: (args as Map<String, dynamic>)?['isCoach'],
  ));
    
      case AppRoutes.addSchedule:
        args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => AddSchedule(
            toggle: (args as Map<String, dynamic>)?['toggle'],
          startTime:(args as Map<String, dynamic>)?['startTime'],
          endTime: (args as Map<String, dynamic>)?['endTime'],
          date: (args as Map<String, dynamic>)?['date'],
          usersList: (args as Map<String, dynamic>)?['usersList'],
          //scheduleId
          scheduleId: (args as Map<String, dynamic>)?['scheduleId'],
          //usersIdsusersIds
          usersIds: (args as Map<String, dynamic>)?['usersIds'],
        ));

      //signUp
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) =>
     SignUpScreen());
      //ManageSchedulesScreen
       case AppRoutes.manageSchedules:
         return MaterialPageRoute(builder: (_) => ManageSchedulesScreen());
    //HomeScreen
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => LoginCubit(),
              child: SignInScreen(),
            ));
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeLayout());
    // manage attendence
      case AppRoutes.manageAttendence:
        return MaterialPageRoute(builder: (_) =>
             ManageAttendence());
    //ManageCoaches
      case AppRoutes.manageCoaches:
        return MaterialPageRoute(builder: (_) => ManageCoaches());
    // manage Salary
      case AppRoutes.manageSalary:
        return MaterialPageRoute(builder: (_) => ManageSalary());
    // default:
    //   return _errorRoute();
    //EditUsers
    //     await Navigator.pushNamed(context,
    //                                  AppRoutes.editProfile,
    //                                  arguments: ManageSalaryCubit.get(context).users[index]);
       case AppRoutes.editProfile:
         //make args as map to get the data from it
     //  args = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => EditUsers(user: args
          ,));
  }

  // static Route<dynamic> _errorRoute() {
  //   // Exit the app if there is no route defined for the given route settings
  //   return MaterialPageRoute(builder: (_) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) => exit(0));
  //     return Container();
  //   });
  }
}