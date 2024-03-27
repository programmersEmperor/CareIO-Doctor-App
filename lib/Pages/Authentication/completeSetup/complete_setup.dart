import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Authentication/controllers/authentication_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CompleteSetup extends StatelessWidget {
  static const id = "/CompleteSetup";
  const CompleteSetup({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController controller = Get.find<AuthenticationController>();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.directional(
                  textDirection: TextDirection.ltr,
                  top: -200,
                  end: -120,
                  child: CircleAvatar(
                    radius: 150.sp,
                    backgroundColor: AppColors.secondaryColor,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.finalSetup.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 22.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 12.0.sp, left: 10.sp, right: 10.sp),
                        child: Text(
                          AppStrings.finalSetupSubtitle.tr.capitalize!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.sp, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FormBuilder(
                    key: controller.completeSetupFormKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Obx(
                            () => controller.getImage.path.isEmpty
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundColor: AppColors.secondaryColor,
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 40,
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                    .animate(
                                      autoPlay: true,
                                    )
                                    .slideY(
                                        curve: Curves.ease,
                                        duration:
                                            GetNumUtils(1200).milliseconds)
                                    .fade(
                                        curve: Curves.ease,
                                        duration: GetNumUtils(1).seconds)
                                : Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundColor:
                                            AppColors.secondaryColor,
                                        backgroundImage:
                                            FileImage(controller.getImage),
                                      ),
                                      GestureDetector(
                                        onTap: controller.removeImage,
                                        child: Container(
                                            margin: EdgeInsets.all(2.sp),
                                            padding: EdgeInsets.all(4.sp),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.scaffoldColor,
                                                    width: 2.sp),
                                                shape: BoxShape.circle,
                                                color: AppColors.primaryColor),
                                            child: Icon(
                                              Boxicons.bx_trash_alt,
                                              size: 15,
                                              color: AppColors.secondaryColor,
                                            )),
                                      )
                                    ],
                                  ),
                          ),
                          onTap: () => controller.showImageSelector(context),
                        )
                            .animate(
                              autoPlay: true,
                            )
                            .slideY(
                                curve: Curves.ease,
                                duration: GetNumUtils(1200).milliseconds)
                            .fade(
                                curve: Curves.ease,
                                duration: GetNumUtils(1).seconds),
                        SizedBox(
                          height: 15.sp,
                        ),
                        const TextInputField(
                          name: 'name',
                          required: true,
                        )
                            .animate(
                              autoPlay: true,
                            )
                            .slideY(
                                curve: Curves.ease,
                                duration: GetNumUtils(1500).milliseconds)
                            .fade(
                                curve: Curves.ease,
                                duration: GetNumUtils(1.7).seconds),
                        SizedBox(
                          height: 15.sp,
                        ),
                        MainColoredButton(
                          text: AppStrings.saveAndContinue.tr,
                          fontSize: 12.sp,
                          isLoading: controller.isLoading,
                          onPress: controller.completeSetup,
                        )
                            .animate(
                              autoPlay: true,
                            )
                            .slideY(
                                curve: Curves.ease,
                                duration: GetNumUtils(1900).milliseconds)
                            .fade(
                                curve: Curves.ease,
                                duration: GetNumUtils(1).seconds),
                        SizedBox(
                          height: 15.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
