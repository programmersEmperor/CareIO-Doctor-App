import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Authentication/controllers/authentication_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordPage extends GetView<AuthenticationController> {
  static const id = '/ForgetPasswordPage';
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(() => AuthenticationController());
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.forgetPassword.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 22.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0.sp),
                          child: SizedBox(
                            width: 70.w,
                            child: Text(
                              AppStrings.forgetPasswordSubtitle.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
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
                    key: controller.sendOtpFormKey,
                    child: Column(
                      children: [
                        const TextInputField(
                          name: 'phone',
                          inputType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        MainColoredButton(
                          text: AppStrings.sendOtp.tr,
                          fontSize: 12.sp,
                          isLoading: controller.isLoading,
                          onPress: controller.sendOtp,
                        ),
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
