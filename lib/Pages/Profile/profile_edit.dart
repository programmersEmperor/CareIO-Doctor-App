import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/page_header.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Experience.dart';
import 'package:careio_doctor_version/Pages/Doctors/custom/experience_card.dart';
import 'package:careio_doctor_version/Pages/Profile/controller/profile_page_controller.dart';
import 'package:careio_doctor_version/Pages/Profile/pages/profile_edit_experiences.dart';
import 'package:careio_doctor_version/Pages/Profile/pages/profile_edit_personal.dart';
import 'package:careio_doctor_version/Pages/Profile/pages/profile_edit_qualifications.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ProfileEditPage extends StatelessWidget {
  static const id = "/ProfileEditPage";
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.find<ProfilePageController>();
    controller.initControllers();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.sp),
          child: Text(
            AppStrings.editPersonalInfo.tr,
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 15.sp,
            left: 10.sp,
            right: 10.sp,
          ),
          child: Container(
            height: 35.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: Colors.grey.shade300,
            ),
            child: Padding(
              padding: EdgeInsets.all(2.sp),
              child: Material(
                color: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                    splashColor: Colors.transparent,
                    useMaterial3: false,
                    highlightColor: Colors.transparent,
                  ),
                  child: TabBar(
                    tabs: [
                      Tab(text: 'Personal'),
                      Tab(text: 'Experiences'),
                      Tab(text: 'Qualifications'),
                    ],
                    controller: controller.tabController,
                    indicator: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colors.white,
                    padding: EdgeInsets.zero,
                    labelStyle: TextStyle(fontSize: 10.sp, fontFamily: GoogleFonts.rubik().fontFamily),
                    enableFeedback: false,
                    indicatorPadding: EdgeInsets.all(4.sp),
                    unselectedLabelColor: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              ProfileEditPersonal(),
              ProfileEditExperiences(),
              ProfileEditQualifications(),
            ],
          ),
        ),
      ],
    );
  }
}
