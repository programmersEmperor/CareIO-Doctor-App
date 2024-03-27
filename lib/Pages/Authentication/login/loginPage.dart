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
                        AppStrings.login.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 22.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.0.sp),
                        child: Text(
                          AppStrings.loginSubtitle.tr,
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
                        TextButton(
                          onPressed: () => Get.toNamed(SignupPage.id),
                          child: Text(
                            AppStrings.createNewAccount.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: Colors.black54),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // Text(
                        //   "or continue with",
                        //   style: TextStyle(
                        //       fontSize: 10.sp,
                        //       fontWeight: FontWeight.w600,
                        //       color: AppColors.primaryColor),
                        // ),
                        // SizedBox(
                        //   height: 15.sp,
                        // ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     SocialMediaButton(
                        //       icon: Boxicons.bxl_google,
                        //       onTap: () {},
                        //     ),
                        //     SizedBox(
                        //       width: 10.sp,
                        //     ),
                        //     SocialMediaButton(
                        //       icon: Boxicons.bxl_facebook,
                        //       onTap: () {},
                        //     ),
                        //   ],
                        // ),
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
