import 'package:admin_future/add_grouup_of_schedules/presentation/search_users_widget.dart';
import 'package:admin_future/add_grouup_of_schedules/presentation/select_coaches.dart';
import 'package:admin_future/home/data/userModel.dart';
import 'package:admin_future/home/presenation/widget/widget/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  List<Widget> _screens = [
    // Add your screens here
    Screen1(),
    // Screen2(),
    // Screen2(),
    // Screen2(),
    Screen3(),
    Screen2(),
    Screen1(),
    Screen3(),
    //  Screen4(),
  ];

  void _next() {
    setState(() {
      _currentIndex++;
    });
  }

  void _previous() {
    setState(() {
      _currentIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
//         text: 'Add group of schedules',
        //traanslate the text to arabic
        text: 'اضافة مجموعة',
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                //delete borders
                //  decoration: BoxDecoration(
                //    border: Border.all(
                //      color: Colors.white,
                //    ),
                //  ),
                height: 900.h,
                width: double.infinity,
                child: Theme(
                  data: ThemeData(
                    canvasColor: Colors.white,
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: Colors.purple,
                          //disabledColor: Colors.purple,
                          background: Colors.white,
                          secondary: Colors.purple,
                        ),
                  ),
                  child: Stepper(
                    onStepContinue: _next,
                    onStepCancel: _previous,
                    onStepTapped: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    //handle navigation with swiping
                    physics: ClampingScrollPhysics(),
                    stepIconBuilder: (stepIndex, stepState) {
                      //change the icon of the step
                      if (stepState == StepState.complete) {
                        return

                            ///home/elreefy14/admin14/admin_future/assets/images/Group 1.svg
                            SvgPicture.asset(
                          'assets/images/check.svg',
                          color: Colors.white,
                        );
                      } else if (stepState == StepState.error) {
                        return Icon(
                          Icons.error,
                          color: Colors.red,
                        );
                      } else if (stepState == StepState.editing) {
                        return Container(
                          
                          //shape circke to make the icon in circle
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/Group 1.svg',
                            color: Colors.purple,
                          ),
                        );
                      } else {
                        return Text(
                          '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat-Arabic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        );
                      }
                    },

                    type: StepperType.horizontal,
                    currentStep: _currentIndex,
                    steps: _screens
                        .asMap()
                        .map((index, screen) => MapEntry(
                            index,
                            Step(
                              title: Text(''),
                              isActive: _currentIndex >= index,
                              state: _currentIndex == index
                                  ? StepState.editing
                                  : StepState.complete,
                              content: SizedBox(
                                  height: 900.h,
                                  width: double.infinity,
                                  child: screen),
                            )))
                        .values
                        .toList(),
                  ),
                ),
              ),
              // Expanded(
              //   child: _screens[_currentIndex],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentIndex > 0)
                    ElevatedButton(
                      onPressed: _previous,
                      child: Text('Previous'),
                    ),
                  if (_currentIndex < _screens.length - 1)
                    ElevatedButton(
                      onPressed: _next,
                      child: Text('Next'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _searchController = TextEditingController();
  Query? _query;
  Query? _query2;
  //onSubmitted
  String? onSubmitted;

  List<UserModel> _selectedUsersUids = [];

  @override
  void initState() {
    super.initState();
    _query = FirebaseFirestore.instance.collection('users');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Select Users'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      //make input from right to left
                      textDirection: TextDirection.rtl,

                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name',
                      ),
                      onSubmitted: (onSubmitted) {
                        setState(() {
                          onSubmitted = onSubmitted.trim();
                          _query = FirebaseFirestore.instance
                              .collection('users')
                              .where('name',
                                  isGreaterThanOrEqualTo: onSubmitted)
                              .where('name', isLessThan: onSubmitted + 'z');
                          _query2 = FirebaseFirestore.instance
                              .collection('users')
                              .where('phone',
                                  isGreaterThanOrEqualTo: onSubmitted)
                              .where('phone', isLessThan: onSubmitted + 'z');
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          value = value.trim();
                          _query = FirebaseFirestore.instance
                              .collection('users')
                              .where('name', isGreaterThanOrEqualTo: value)
                              .where('name', isLessThan: value + 'z');
                          _query2 = FirebaseFirestore.instance
                              .collection('users')
                              .where('phone', isGreaterThanOrEqualTo: value)
                              .where('phone', isLessThan: value + 'z');
                        });
                      },
                    ),
                    Expanded(
                      child: FirestoreListView(
                        cacheExtent: 300,
                        pageSize: 5,
                        query: _query ?? _query2!,
                        itemBuilder: (context, snapshot) {
                          final data = snapshot.data() as Map<String, dynamic>;
                          UserModel user = UserModel(
                            name: data['name'],
                            email: data['email'],
                            level: data['level'],
                            hourlyRate: data['hourlyRate'],
                            totalHours: data['totalHours'],
                            totalSalary: data['totalSalary'],
                            currentMonthHours: data['currentMonthHours'],
                            currentMonthSalary: data['currentMonthSalary'],
                            uId: snapshot.id,
                            phone: data['phone'],
                          );
                          final selected = _selectedUsersUids.contains(user);
                          return CheckboxListTile(
                            title: Text(user.name ?? ''),
                            subtitle: Text(user.phone ?? ''),
                            value: selected,
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  _selectedUsersUids.add(user);
                                  //use logger to print the selected users
                                  // Logger.root.info(
                                  //    'Selected Users: $_selectedUsersUids');
                                } else {
                                  _selectedUsersUids.remove(user);
                                  // Logger.root.info(
                                  //      'Selected Users: $_selectedUsersUids');
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      //clear the search controller
                      _searchController.clear();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add your logic for selecting users here
                      print('Selected Users: $_selectedUsersUids');
                      Navigator.of(context).pop();
                      //clear the search controller
                      _searchController.clear();
                    },
                    child: Text('Select'),
                  ),
                ],
              );
            },
          );
        },
        child: Text('Select Users'),
      ),
    );
  }
}

//assets/images/delete-2_svgrepo.com.svg
class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
final Map<String, Map<dynamic, dynamic>> _times = {
  'السبت': {'start': null, 'end': null},
  'الأحد': {'start': null, 'end': null},
  'الاثنين': {'start': null, 'end': null},
  'الثلاثاء': {'start': null, 'end': null},
  'الأربعاء': {'start': null, 'end': null},
  'الخميس': {'start': null, 'end': null},
  'الجمعة': {'start': null, 'end': null},
};

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _times.keys.map((day) {
        return ListTile(

          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '/$day',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
          subtitle: Column(
            children: [
              //10
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
            TimeOfDay? endTime = await showTimePicker(
              context: context,
              initialTime: _times[day]?['end'] ?? TimeOfDay.now(),
            );
            if (endTime != null) {
              setState(() {
                _times[day]?['end'] = endTime;
                //start time equal hour minus end time
                _times[day]?['start']
                 = endTime.replacing(hour: endTime.hour - 1);
              });
            }
        },
                    child: Container(
                    width: 125.w,
                    height: 35.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text(
                     // _times[day]?['end']?.format(context) ?? 'نهاية التدريب',
                     //make it in arabic like that 11 ص 
                      _times[day]?['end']?.format(context).toString().replaceAll('PM', 'م').replaceAll('AM', 'ص') ?? 'نهاية التدريب',
                     
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 16.sp,
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                ),
                  ),

                  Row(
                    children: [
                      SizedBox(width: 8.0),
                      Text(
                        '-',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      InkWell(
                                onTap: () async {
            TimeOfDay? startTime = await showTimePicker(
              context: context,
              initialTime: _times[day]?['start'] ?? TimeOfDay.now(),
            );
            if (startTime != null) {
            
              setState(() {
                _times[day]?['start'] = startTime;
              //end time equal hour plus start time
             TimeOfDay endTime = startTime.replacing(hour: startTime.hour + 1);
                  _times[day]?['end'] = endTime;
              //save the start time as timeStamp get 
                
              });
            }
          },
                        child: Container(
                          width: 125.w,
                          height: 35.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF6F6F6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Text(
                            // _times[day]?['start']?.format(context) ?? 'بداية التدريب',
                            //make it in arabic like that 11 ص
                            _times[day]?['start']?.format(context).toString().replaceAll('PM', 'م').replaceAll('AM', 'ص') ??
                            'بداية التدريب',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 16.sp,
                              fontFamily: 'IBM Plex Sans Arabic',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // onTap: () async {
          //   TimeOfDay? startTime = await showTimePicker(
          //     context: context,
          //     initialTime: _times[day]?['start'] ?? TimeOfDay.now(),
          //   );
          //   if (startTime != null) {
          //     TimeOfDay? endTime = await showTimePicker(
          //       context: context,
          //       initialTime: _times[day]?['end'] ?? TimeOfDay.now(),
          //     );
          //     setState(() {
          //       _times[day]?['start'] = startTime;
          //       if (endTime != null) {
          //         _times[day]?['end'] = endTime;
          //       }
          //     });
          //   }
          // },
        );
      }).toList(),
    );
  }
}

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final TextEditingController _searchController = TextEditingController();
  Query? _query;
  int? numberOfQuery;
  List<String> _selectedUsersUids = [];
  List<UserModel> _selectedUsers = [];

  @override
  void initState() {
    super.initState();
    _query = FirebaseFirestore.instance.collection('users');
  }

  Future<void> _onSearchSubmitted(String value) async {
    Query newQuery = FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: value)
        .where('name', isLessThan: value + 'z')
        .where('role', isEqualTo: 'coach')
        //order by name
        .orderBy('name', descending: false)
        .limit(100);

    QuerySnapshot querySnapshot =
        await newQuery.get(GetOptions(source: Source.serverAndCache));
    numberOfQuery = querySnapshot.docs.length;
    print('number of query is $numberOfQuery');
    print(numberOfQuery);

    if (numberOfQuery == 0) {
      newQuery = FirebaseFirestore.instance
          .collection('users')
          .where('phone', isGreaterThanOrEqualTo: value)
          .where('phone', isLessThan: value + 'z')
          .where('role', isEqualTo: 'coach')
          //order by name
          .orderBy('phone', descending: false)
          .limit(100);
    }

    setState(() {
      _query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*
        Text(
    'المدربين:',
    style: TextStyle(
        color: Color(0xFF333333),
        fontSize: 14,
        fontFamily: 'IBM Plex Sans Arabic',
        fontWeight: FontWeight.w400,
        height: 0,
    ),
)
//50

        */
        //50
        SizedBox(
          height: 40.h,
        ),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Text(
            ':المدربين',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 14,
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.w400,
              height: 0,
              // added this line
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ShowCoachesInDialog(
                selectedUsers: _selectedUsers,
                onSelectedUsersChanged: (users) {
                  setState(() {
                    _selectedUsers = users;
                  });
                },
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 280.w,
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 11.30,
                      child: Icon(
                        Icons.arrow_drop_down,
                        // size: 20.sp,
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          'اختر المدربين',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 16.sp,
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => //5
              SizedBox(
            height: 10.h,
          ),
          shrinkWrap: true,
          itemCount: _selectedUsers.length,
          itemBuilder: (context, index) {
            final user = _selectedUsers[index];
            return Container(
              width: 360,
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        //svg image delete which is svg image images/delete-2_svgrepo.com.svg
                        InkWell(
                            onTap: () {
                              setState(() {
                                _selectedUsers.remove(user);
                                _selectedUsersUids.remove(user.uId!);
                              });
                            },
                            child: SvgPicture.asset(
                                'assets/images/delete-2_svgrepo.com.svg')),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            //   '${user.name}-${index + 1}',
                            //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                            '${index + 1}-${user.name}',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Montserrat-Arabic',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
