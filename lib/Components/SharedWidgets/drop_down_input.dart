import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sizer/sizer.dart';

class DropDownInput extends StatelessWidget{
  final String name;
  final String hintText;
  final dynamic initialValue;
  final List<DropdownMenuItem<dynamic>> items;
  final Function(dynamic item) onChanged;

  const DropDownInput({super.key, required this.name, required this.hintText, this.initialValue, required this.items, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
        onChanged: onChanged,
        menuMaxHeight: 200,
        borderRadius: BorderRadius.circular(15),
        name: name,
        initialValue: initialValue,
        icon: Padding(
          padding: EdgeInsetsDirectional.only(end: 5.sp, top: 1.sp),
          child: Icon(CupertinoIcons.chevron_down, color: AppColors.primaryColor, size: 11.sp),
        ),
        style: TextStyle(fontSize: 9.sp, color: Colors.black54),
        decoration: InputDecoration(
          counter: const SizedBox(),
          isDense: true,
          suffixIconColor: Colors.grey,
          floatingLabelStyle:
          TextStyle(color: AppColors.primaryColor, fontSize: 13.sp),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 10.sp, color: Colors.grey),
          fillColor: CupertinoColors.systemGrey5,
          filled: true,
          focusColor: AppColors.primaryColor,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
              borderSide: const BorderSide(color: Colors.redAccent)),
          // labelText: enableLabel ? name.capitalize : null,
          errorStyle: TextStyle(
            fontSize: 10.sp,
          ),
          labelStyle: TextStyle(
            fontSize: 10.sp,
            color: Colors.black45,
          ),
          // contentPadding:
          //     EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(color: CupertinoColors.systemGrey5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(color: CupertinoColors.systemGrey5),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
              borderSide: BorderSide(color: AppColors.primaryColor)),
        ),
        items: items,
    );
  }

}