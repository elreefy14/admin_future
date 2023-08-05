import 'dart:io';

import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:admin_future/home/business_logic/Home/manage_salary_cubit.dart';
import 'package:admin_future/registeration/business_logic/auth_cubit/login_cubit.dart';
import 'package:admin_future/registeration/presenation/login_screen.dart';
import 'package:admin_future/registeration/presenation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'core/constants/routes_manager.dart';
import 'core/constants/strings.dart';
import 'home/presenation/widget/home_layout.dart';
import 'home/presenation/widget/manage_attendence.dart';
import 'home/presenation/widget/manage_coaches.dart';
import 'home/presenation/widget/mange_salary.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
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
            BlocProvider(
              create: (context) => ManageAttendenceCubit()..generateRandomData(),
              child: ManageAttendence(),
            ));
    //ManageCoaches
      case AppRoutes.manageCoaches:
        return MaterialPageRoute(builder: (_) => ManageCoaches());
    // manage Salary
      case AppRoutes.manageSalary:
        return MaterialPageRoute(builder: (_) => ManageSalary());
    // default:
    //   return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    // Exit the app if there is no route defined for the given route settings
    return MaterialPageRoute(builder: (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) => exit(0));
      return Container();
    });
  }
}