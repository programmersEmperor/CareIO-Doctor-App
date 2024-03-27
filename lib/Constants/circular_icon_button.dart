import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.onTap,
    this.onLongPress,
    required this.height,
    required this.width,
    required this.iconSize,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  final VoidCallback? onTap, onLongPress;
  final double height, width, iconSize;
  final IconData icon;
  final Color backgroundColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        width: width,
        height: height,
        child: Icon(
          icon, // Your icon here
          size: iconSize, // Icon size
          color: iconColor, // Icon color
        ),
      ),
    );
  }
}
