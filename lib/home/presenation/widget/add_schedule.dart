import 'package:admin_future/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:admin_future/home/presenation/widget/widget/select_day.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multiselect/multiselect.dart';
import '../../../registeration/data/userModel.dart';

import 'widget/multi_select.dart';
import '../../business_logic/Home/manage_attendence_state.dart';

class AddSchedule extends StatefulWidget {

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
   Timestamp startTime = Timestamp.now();

    Timestamp endTime = Timestamp.now();

  late String dayOfWeek;

  late String selectedBranch;
  late List<UserModel>? selectedUsers;
  late List<String> results;

  void updateSelectedBranch(String branch) {
    setState(() {
      selectedBranch = branch;
    });
  }

  @override
  Widget build(BuildContext context) {
    //save start time and end time to variables and day of week to variable

    void _showMultiSelect({
      required List<String> list,

    }) async {
      results = (await showDialog<List<String>>(
        context: context,
        builder: (BuildContext context) {
          return MultiSelectUserNames(
            items: ManageAttendenceCubit.get(context).MyUsersNames??[],

          );
        },
      ))!;

      // Handle results if needed
      if (results != null) {
      }
    }   void _showMultiSelect2({
      required List<String> list,

    }) async {
      results = (await showDialog<List<String>>(
        context: context,
        builder: (BuildContext context) {
          return MultiSelectDays(
            items2: list,

          );
        },
      ))!;

      // Handle results if needed
      if (results != null) {
      }
    }
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //60.h
            SizedBox(height: 70.0.h),
            const Center(
              child: Text(
                'اضافة موعد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 32,
                  fontFamily: 'Montserrat-Arabic',
                  fontWeight: FontWeight.w400,
                  height: 0.81,
                ),
              ),
            ),
            SizedBox(height: 80.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    // RoundedRectangleBorder(
                    // side: BorderSide(
                    // width: 0.75,
                    // strokeAlign: BorderSide.strokeAlignOutside,
                    // color: Color(0xFF2196F3),
                    // ),
                    // borderRadius: BorderRadius.circular(4),
                    // ),
                      decoration: BoxDecoration(
                        color: //#F4F4F4
                        const Color(0xFFF4F4F4),
                        border: Border.all(
                          color: const Color(0xFF2196F3),
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      //   width: 240.w,

                      //  height: 40.h,
                      //   color:
                      //   Color(0xFFF4F4F4),

                      child: Row(
                        children: [
                          const Icon(Icons.keyboard_arrow_down_outlined,
                            size: 35,
                          ),
                          SizedBox(width: 5.w),

                          InkWell(
                            onTap: () {
                              _showMultiSelect(
                                list: ManageAttendenceCubit.get(context).MyUsersNames??[],
                              );

                            },
                            child: const SizedBox(
                              width: 171,
                              child: Text(
                                //please select the users
                                'اختر المدربين',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'IBM Plex Sans Arabic',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),

                        ],
                      )
                  ),
                ),
                //5
                SizedBox(width: 5.w),
                const Flexible(
                  flex: 2,
                  child: Text(
                    'اسم المدربين ',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0.h),
            GestureDetector(
              onTap: () {
                DatePicker.showDatePicker(

                  context,
                  showTitleActions: true,
                  minTime: DateTime(2023, 3, 5),
                  maxTime: DateTime(2030, 6, 7),
                  onChanged: (date) {
                    print('change $date');

                  },
                  onConfirm: (date) {
                    if (kDebugMode) {
                      print('confirm $date');
                    }
                    dayOfWeek = date.toString();

                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              //    SizedBox(width: 10.w),
                  InkWell(
                onTap: () {
                  _showMultiSelect2(
                      list : [
                        //  case '1':
        //   day = 'الاثنين';
        //   break;
        // case '2':
        //   day = 'الثلاثاء';
        //   break;
        // case '3':
        //   day = 'الأربعاء';
        //   break;
        // case '4':
        //   day = 'الخميس';
        //   break;
        // case '5':
        //   day = 'الجمعة';
        //   break;
        // case '6':
        //   day = 'السبت';
        //   break;
        // case '7':
        //   day = 'الأحد';
                        'السبت',
                        'الأحد',
                        'الاثنين',
                        'الثلاثاء',
                        'الأربعاء',
                        'الخميس',
                        'الجمعة',

                      ]
                  );
                },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        border: Border.all(
                          color: const Color(0xFF2196F3),
                         // width: 0
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 35,
                          ),
                          SizedBox(width: 5.w),
                            SizedBox(
                            width: 190.w,
                            child: const Text(
                              //please select the days of week
                              ' اختر الأيام',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'IBM Plex Sans Arabic',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                         //  SizedBox(width: 5.w),
                        ],
                      ),
                    ),
                  ),
                 // Spacer(),
                  SizedBox(width: 5.w),
                  const Text(
                    'يوم التدريب',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ), SizedBox(height: 20.0.h),
            GestureDetector(
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((selectedTime) {
                  if (selectedTime != null) {
                    // Convert selected time to DateTime object
                    final now = DateTime.now();
                    final selectedDateTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);

                    // Save selected time as timestamp
                    setState(() {
                      startTime = Timestamp.fromMillisecondsSinceEpoch(selectedDateTime.millisecondsSinceEpoch);
                    });

                    // Handle the selected time
                    final formattedTime = selectedTime.format(context); // Format the selected time as needed
                    print('Selected time: $formattedTime');
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 50.w),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        border: Border.all(
                          color: const Color(0xFF2196F3),
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 25,
                          ),
                          SizedBox(width: 5.w),
                          SizedBox(
                            width: 86,
                            child: Text(
                              '${startTime?.toDate().hour}:${startTime?.toDate().minute}' ?? '11:00ص',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'IBM Plex Sans Arabic',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  const Text(
                    'موعد انتهاء التدريب:',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.0.h),
            GestureDetector(
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((selectedTime) {
                  if (selectedTime != null) {
                    // Convert selected time to DateTime object
                    final now = DateTime.now();
                    final selectedDateTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);

                    // Save selected time as timestamp
                    setState(() {
                      endTime = Timestamp.fromMillisecondsSinceEpoch(selectedDateTime.millisecondsSinceEpoch);
                    });

                    // Handle the selected time
                    final formattedTime = selectedTime.format(context); // Format the selected time as needed
                    print('Selected time: $formattedTime');
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 50.w),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        border: Border.all(
                          color: const Color(0xFF2196F3),
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 25,
                          ),
                          SizedBox(width: 5.w),
                          SizedBox(
                            width: 86,
                            child: Text(
                              '${endTime?.toDate().hour}:${endTime?.toDate().minute}' ?? '11:00ص',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'IBM Plex Sans Arabic',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  const Text(
                    'موعد انتهاء التدريب:',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0.h),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'مكان التدريب:',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0.h),
            // List<String> items = ['Item 1', 'Item 2', 'Item 3'];

            BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
              builder: (context, state) {
                return ManageAttendenceCubit.get(context).branches == null
                    ? const Center(child: CircularProgressIndicator())
                    :
                  Expanded(
                  child: CheckboxListWidget(

                    onBranchSelected: updateSelectedBranch,
                      items: ManageAttendenceCubit.get(context).
                          branches ?? [],
                  ),
                );
              },
            ),
            SizedBox(height: 20.0.h),
            BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
  builder: (context, state) {
    return FFButtonWidget(
              text: 'اضافة موعد', onPressed: () {
ManageAttendenceCubit.get(context).addSchedule(context,
    startTrainingTime:startTime!,
    endTrainingTime: endTime!,
  //  day: 'الثلاثاء',
    branch: selectedBranch,
 //   users: ManageAttendenceCubit.get(context).selectedItems??[]
);
    }, options: FFButtonOptions(
              width: 200.w,
              height: 40.h,
              color: const Color(0xFF2196F3),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'IBM Plex Sans Arabic',
                fontWeight: FontWeight.w400,
              ),
              borderSide: const BorderSide(
                color: Color(0xFF2196F3),
                width: 0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),);
  },
),


          ],
        ),
      ),
    );
  }
}


class CheckboxListWidget extends StatefulWidget {
  final List<String> items;
  final Function(String) onBranchSelected;

  CheckboxListWidget({required this.items, required this.onBranchSelected});

  @override
  _CheckboxListWidgetState createState() => _CheckboxListWidgetState();
}

class _CheckboxListWidgetState extends State<CheckboxListWidget> {
  List<bool> checkedItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize the checkedItems list with false for each item
    checkedItems = List<bool>.generate(widget.items.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(widget.items[index]),
          value: checkedItems[index],
          onChanged: (value) {
            setState(() {
              checkedItems[index] = value!;
              if (value) {
                widget.onBranchSelected(widget.items[index]);
              } else {
                widget.onBranchSelected('');
              }
            });
          },
        );
      },
    );
  }
}