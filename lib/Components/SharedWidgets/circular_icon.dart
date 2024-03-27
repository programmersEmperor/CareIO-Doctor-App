import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color backgroundColor, iconColor;
  final double radius, size;

  const CircularIcon({
    super.key,
    this.icon = Icons.arrow_back_ios,
    this.onTap,
    this.backgroundColor = Colors.grey,
    this.iconColor = Colors.white,
    this.radius = 10,
    this.size = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(8.sp)),
      width: 8.w,
      height: 4.5.h,
      child: Icon(
        icon, // Your icon here
        size: size, // Icon size
        color: iconColor, // Icon color
      ),
    );
  }
}
