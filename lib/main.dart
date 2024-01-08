import 'package:admin_future/add_grouup_of_schedules/presentation/onboarding_screen.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:admin_future/home/business_logic/Home/manage_salary_cubit.dart';
import 'package:admin_future/registeration/business_logic/auth_cubit/sign_up_cubit.dart';
import 'package:admin_future/routiong.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/bloc_observer.dart';
import 'core/constants/routes_manager.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message:\n\n\n ${message.messageId}');
}

late String mainRoute;
final remoteConfig = //firabase remote config
FirebaseRemoteConfig.instance;

Future<void> main() async {
  //await initializeDateFormatting('ar', null);

  //wait widget tree to be built
  WidgetsFlutterBinding.ensureInitialized();
  //await AndroidAlarmManager.initialize();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //make bottom bar transparent
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  // use future builder to wait for firebase to be initialized and cache to be initialized
  // await CacheHelper.init();
  //
   await Firebase.initializeApp(
   );
  FirebaseFirestore.instance.settings =
  const Settings(persistenceEnabled: true);
  //if frebase login is null
  //late String mainRoute;
  if (FirebaseAuth.instance.currentUser == null) {
    mainRoute = AppRoutes.welcome;
  } else {
    print('user is not null');
    //uid
    print(FirebaseAuth.instance.currentUser!.uid);
    mainRoute = AppRoutes.home;
  }
  //await DioHelper.init();
  FirebaseMessaging.onMessage.listen((event) {
    print('onMessage\n\n\n');
    print(event.notification!.title);
    print(event.notification!.body);
  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('onMessageOpenedApp\n\n\n\n\n\n\n');
    print(event.notification!.title);
    print(event.notification!.body);
  });
  // background notification
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //firebase messaging PERMISSION
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  BlocOverrides.runZoned(() => runApp(const MyApp()),
      blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddGroupCubit(

        ),
        ),
        BlocProvider(create: (context) => SignUpCubit()
          //..addBranches()
          ..getBranches()
        ),
        BlocProvider(create: (context) => ManageSalaryCubit()
        //    ..generateRandomSchedules()
       //    ..generateRandomSchedules()
          //..getDays()
        ),
        BlocProvider(create: (context) => ManageAttendenceCubit()
        //    ..addToWhatsAppGroup('https://chat.whatsapp.com/FV27zAcLJocKycZDScif1S', '+2001020684123 ')

        //    ..getNearestScedule(
          //  )
        ),
      ],child:  ScreenUtilInit(
        designSize: const Size(390, 845),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) =>
            MaterialApp(

              // localizationsDelegates: [
              //   GlobalMaterialLocalizations.delegate,
              //   GlobalWidgetsLocalizations.delegate,
              //   GlobalCupertinoLocalizations.delegate,
              // ],
              // supportedLocales: const [
              //   Locale('ar', "AE"),
              // ],

              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                
                primarySwatch: //use this as material color #4F46E5
                Colors.blue,
                //MyColors.primaryColor,
              ),
              initialRoute:
              mainRoute,
              //AppRoutes.manageGroups,
              onGenerateRoute: RouteGenerator.generateRoute,
            ),

      ),
    );
  }
}
