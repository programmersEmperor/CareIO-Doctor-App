import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  const NoDataWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 35.h,
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
