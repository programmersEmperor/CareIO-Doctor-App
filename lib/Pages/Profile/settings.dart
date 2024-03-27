import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Profile/controller/profile_page_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends GetView<ProfilePageController> {
  static const id = "/settings";
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  AppStrings.settings.tr,
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () => controller.changeLanguageBottomSheet(),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                leading: Icon(
                  Boxicons.bx_globe,
                  color: AppColors.primaryColor,
                ),
                title: Text(
                  AppStrings.appLanguage.tr,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
