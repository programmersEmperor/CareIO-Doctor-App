import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PageHeader extends StatelessWidget {
  final String heading;
  const PageHeader({
    super.key,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.sp, left: 10.sp, right: 10.sp),
      child: Align(
        alignment: Get.locale.toString() == 'ar_AR'? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          heading.capitalize!,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
