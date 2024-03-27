import 'package:careio_doctor_version/Models/Notification.dart' as model;
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotificationCard extends StatelessWidget {
  final model.Notification notification;
  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("local ${Get.locale}");
    return Padding(
      padding: EdgeInsets.only(bottom: 10.sp),
      child: Card(
        elevation: notification.isRead ? 0 : 15,
        shadowColor: Colors.grey.withOpacity(0.2),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(
            children: [
              Icon(
                Icons.notifications_active,
                size: 26.sp,
                color: AppColors.primaryColor,
              ),
              SizedBox(
                width: 10.sp,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${notification.title}",
                      style: TextStyle(
                          fontSize: 9.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    Text(
                      "${notification.body}",
                      style: TextStyle(fontSize: 8.sp, color: Colors.black38, height: 1.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 1.sp,
              ),
              if(notification.createdAt != null) ...[
                Text(
                  notification.createdAt!,
                  style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                      color: notification.isRead
                          ? Theme.of(context).disabledColor
                          : Theme.of(context)
                          .primaryColor
                          .withOpacity(0.5.sp)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
