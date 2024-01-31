import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/Home/manage_attendence_cubit .dart';

class CheckboxListWidget extends StatefulWidget {
  final List<String> items;
  final Function(String) onBranchSelected;

  CheckboxListWidget({required this.items, required this.onBranchSelected});

  @override
  _CheckboxListWidgetState createState() => _CheckboxListWidgetState();
}

class _CheckboxListWidgetState extends State<CheckboxListWidget> {
  int? checkedItem;

  @override
  void initState() {
    super.initState();
    // Initialize the checkedItem to the index of the selected branch
    if (widget.items.contains(ManageAttendenceCubit.get(context).selectedBranch)) {
      checkedItem = widget.items.indexOf(ManageAttendenceCubit.get(context).selectedBranch!);
    } else {
      checkedItem = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          activeColor: Colors.blue,
          //height between each item in the list =5
          //  contentPadding: const EdgeInsets.symmetric(vertical: 0),
          title: //Text(widget.items[index]),
          Text(
            widget.items[index],
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.h,
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),

          value: checkedItem == index,
          onChanged: (value) {
            setState(() {
              if (value != null && value) {
                checkedItem = index;
                widget.onBranchSelected(widget.items[index]);
              } else {
                checkedItem = null;
                widget.onBranchSelected('');
              }
            });
          },
        );
      },
    );
  }
}