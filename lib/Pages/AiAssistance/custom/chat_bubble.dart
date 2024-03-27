import 'dart:io';

import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String isMe;
  final bool isLoading;
  final File? image;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.isMe,
      this.image,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.sp, left: 5.sp, right: 5.sp),
      child: Align(
        alignment:
            isMe == "patient" ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMe == "dr") ...[
              CircleAvatar(
                radius: 12.sp,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.android,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
            if (image == null) ...[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.sp),
                padding: EdgeInsets.all(isLoading ? 7.sp : 10.sp),
                constraints: BoxConstraints(
                  maxWidth: isLoading ? 15.w : 60.w,
                ),
                decoration: BoxDecoration(
                    color: isMe == "patient"
                        ? const Color(0xffdeebe9)
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.sp)),
                child: isLoading
                    ? const SpinKitFadingCircle(
                        color: Colors.white,
                        size: 20.0,
                      )
                    : Text(
                        message,
                        style: TextStyle(
                            color: isMe == "patient"
                                ? AppColors.primaryColor
                                : Colors.white,
                            fontSize: 10.sp),
                      ),
              ),
            ],
            if (image != null) ...[
              OpenContainer(
                closedElevation: 0,
                openColor: AppColors.scaffoldColor,
                closedColor: AppColors.scaffoldColor,
                openElevation: 0,
                openBuilder: (context, builder) => Image.file(image!),
                closedBuilder: (context, builder) => Container(
                  height: 20.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    image: DecorationImage(
                      image: FileImage(image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    ).animate().fade().moveY();
  }
}
