import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
