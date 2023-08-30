import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/auth_cubit/sign_up_cubit.dart';
import '../../business_logic/auth_cubit/sign_up_state.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;
  final Function(List<String>)? onConfirm;

  const MultiSelect({
    Key? key,
    required this.items,
    this.onConfirm,
  }) : super(key: key);

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems = SignUpCubit.get(context).selectedItems ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('برجاء اختيار الفروع المسؤول عنها'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map(
                (item) => CheckboxListTile(
              value: selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) {
                setState(() {
                  if (isChecked!) {
                    selectedItems.add(item);
                  } else {
                    selectedItems.remove(item);
                  }
                });
              },
            ),
          ).toList(),
        ),
      ),
      actions: [
        Center(
          child: Container(
            width: 100.w,
            height: 40.h,
            child: ElevatedButton(
              onPressed: () {
                print('selectedItems $selectedItems');
                if (widget.onConfirm != null) {
                  widget.onConfirm!(selectedItems);
                }
                Navigator.pop(context, selectedItems);
              },
              child: const Text('Submit'),
            ),
          ),
        ),
      ],
    );
  }
}