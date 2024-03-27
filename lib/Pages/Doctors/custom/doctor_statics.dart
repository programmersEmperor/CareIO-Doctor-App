import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DoctorStatics extends StatelessWidget {
  final String title, info;
  const DoctorStatics({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title.capitalize!,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        Text(
          info,
          style: TextStyle(fontSize: 8.sp, color: Colors.black45),
        ),
      ],
    );
  }
}
