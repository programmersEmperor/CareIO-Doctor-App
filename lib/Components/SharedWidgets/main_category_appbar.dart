import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

AppBar mainCategoryAppBar(dynamic controller, String name) {
  return AppBar(
    toolbarHeight: 8.h,
    leading: Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 15.sp,
        ),
        onPressed: () => Get.back(),
      ),
    ),
    title: Text(
      name,
      style: TextStyle(color: Colors.black, fontSize: 12.sp),
    ),
    centerTitle: true,
  );
}
