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

  final bool? toggle;
  final Timestamp? startTime;
  final Timestamp? endTime;
  final String ?date;
  //scheduleId
  final String? scheduleId;
  final List<String>? usersList;
  //selectedBranch
  final String? selectedBranch;

  const AddSchedule({
     this.toggle,
     this.startTime,
     this.endTime,
     this.date,
     this.usersList,
      this.scheduleId,
      this.selectedBranch,
  });
  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
   //Timestamp startTime = Timestamp.now();

   // Timestamp endTime = Timestamp.now();

  late String dayOfWeek;

  // String selectedBranch = widget.selectedBranch??'';
  late List<UserModel>? selectedUsers;
  late List<String> results;



  // void updateSelectedBranch(String branch) {
  //   setState(() {
  //     selectedBranch = branch;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var startTime = widget.startTime;
    var endTime = widget.endTime;
    var date = widget.date;
    var usersList = widget.usersList;
    bool toggle = widget.toggle??true;
    String? selectedBranch = widget.selectedBranch;

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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
        Column(
          children: [
            //60.h
            SizedBox(height: 70.0.h),
             Center(
              child: Text(
                toggle == false ?
                'تعديل موعد'
                    : 'اضافة موعد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 28,
                  fontFamily: 'Montserrat-Arabic',
                  fontWeight: FontWeight.w400,
                  height: 0.81,
                ),
              ),
            ),
            SizedBox(height: 50.0.h),
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
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 9.w),
                  InkWell(
                onTap: () {
                  _showMultiSelect2(
                      list : [
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
                    child: Flexible(
                      flex: 3,
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
                            SizedBox(width: 115.w),
                            Text(
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
                           SizedBox(width: 20.w),
                           //  SizedBox(width: 5.w),
                          ],
                        ),
                      ),
                    ),
                  ),
                 // Spacer(),
                  SizedBox(width: 5.w),
                  Flexible(
                    flex: 1,
                    child: const Text(
                      'يوم التدريب',
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
                      print('startTime: $startTime');
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
                              '${startTime != null ? (startTime!.toDate().hour > 12 ? startTime!.toDate().hour - 12 : startTime!.toDate().hour) : 11}:${startTime?.toDate().minute.toString().padLeft(2, '0')}${endTime != null ? (endTime!.toDate().hour >= 12 ? 'م' : 'ص') : 'ص'}',

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
                    'موعد بدء التدريب:',
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
                              '${endTime != null ? (endTime!.toDate().hour > 12 ? endTime!.toDate().hour - 12 : endTime!.toDate().hour) : 11}:${endTime?.toDate().minute.toString().padLeft(2, '0')}${endTime != null ? (endTime!.toDate().hour >= 12 ? 'م' : 'ص') : 'ص'}',
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
            //SizedBox(height: 5.0.h),
            // List<String> items = ['Item 1', 'Item 2', 'Item 3'];

            BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
              builder: (context, state) {
                return ManageAttendenceCubit.get(context).branches == null
                    ? const Center(child: CircularProgressIndicator())
                    :
                  Container(
                   // height: 200.h,
                    child: CheckboxListWidget(

                      onBranchSelected: (branch) {
                        setState(() {
                          selectedBranch = branch;
                        });
                      },
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
                  text:  toggle == false ?
                  'حفظ التعديلات'
                      : 'اضافة موعد', onPressed: () {
                    if (toggle == false) {
                      ManageAttendenceCubit.get(context).updateSchedule(
                          startTrainingTime: startTime!,
                          endTrainingTime: endTime!,
                          //day: 'الثلاثاء',
                          branch: selectedBranch,
                          scheduleId: widget.scheduleId!,
                          //   users: ManageAttendenceCubit.get(context).selectedItems??[]
                      );
                    }
                    else
                  ManageAttendenceCubit.get(context).addSchedule(context,
                    startTrainingTime:startTime!,
                    endTrainingTime: endTime!,
                    //  day: 'الثلاثاء',
                    branch: selectedBranch??'',
                    //   users: ManageAttendenceCubit.get(context).selectedItems??[]
                  );
                }, options: FFButtonOptions(
                  width: 200.w,
                  height: 50.h,
                  color: const Color(0xFF2196F3),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w400,
                  ),
                  // borderSide: const BorderSide(
                  //  color: Color(0xFF2196F3),
                  //    width: 0,
                  //  ),
                  //  borderRadius: BorderRadius.circular(12),
                ),);
              },
            ),


          ],
        ),

        ),
      ),
     // bottomNavigationBar:
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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          //height between each item in the list =5
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          title: //Text(widget.items[index]),
          Text(
            widget.items[index],
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
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