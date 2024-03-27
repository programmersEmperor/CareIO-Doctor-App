import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sizer/sizer.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final FocusNode? node;
  final String name;
  final bool showAttachment;
  final Function(String) onChange;
  const RoundedTextField(
      {super.key,
      required this.controller,
      required this.name,
      required this.hint,
      this.node,
      this.showAttachment = true,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      controller: controller,
      onChanged: (value) {
        onChange(value ?? '');
      },
      cursorRadius: const Radius.circular(15),
      cursorColor: AppColors.primaryColor,
      style: TextStyle(fontSize: 9.sp, color: Colors.black54),
      decoration: InputDecoration(
        counter: const SizedBox(),
        floatingLabelStyle:
            TextStyle(color: AppColors.primaryColor, fontSize: 12.sp),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 9.5.sp),
        fillColor: Colors.white,
        filled: true,
        focusColor: AppColors.primaryColor,
        contentPadding: EdgeInsets.only(top: 2.sp, left: 10.sp, right: 10.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.sp),
          borderSide: const BorderSide(color: CupertinoColors.systemGrey5),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: BorderSide(color: AppColors.primaryColor)),
      ),
    );
  }
}
