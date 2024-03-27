import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SocialMediaButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const SocialMediaButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.sp),
            color: CupertinoColors.systemGrey5),
        padding: EdgeInsets.symmetric(horizontal: 9.sp, vertical: 6.sp),
        child: Icon(icon),
      ),
    );
  }
}
