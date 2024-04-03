import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Authentication/controllers/authentication_controller.dart';
import 'package:careio_doctor_version/Pages/Authentication/forgetPassword/forget_password_page.dart';
import 'package:careio_doctor_version/Pages/Authentication/signup/signupPage.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  static const id = '/loginPage';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController controller = Get.find<AuthenticationController>();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25.h,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.login.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 22.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 12.0.sp, left: 40.sp, right: 40.sp),
                        child: Text(
                          AppStrings.loginSubtitle.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
                vertical: 10.sp,
              ),
              children: [
                FormBuilder(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      const TextInputField(
                        name: 'phone',
                        inputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      const TextInputField(
                        name: 'password',
                        inputType: TextInputType.text,
                        password: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Get.toNamed(ForgetPasswordPage.id),
                          child: Text(
                            AppStrings.forgetPassword.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 9.sp,
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      MainColoredButton(
                        text: AppStrings.login.tr,
                        fontSize: 12.sp,
                        isLoading: controller.isLoading,
                        onPress: () => controller.login(),
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      // TextButton(
                      //   onPressed: () => Get.offNamed(SignupPage.id),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         AppStrings.dontHaveAccount.tr,
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 10.sp,
                      //             color: Colors.black54),
                      //       ),
                      //       SizedBox(
                      //         width: 6.sp,
                      //       ),
                      //       Text(
                      //         AppStrings.createNewAccount.tr,
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 10.sp,
                      //             color: AppColors.primaryColor
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
