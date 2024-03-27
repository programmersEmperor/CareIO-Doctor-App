import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Authentication/controllers/authentication_controller.dart';
import 'package:careio_doctor_version/Pages/Authentication/login/loginPage.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignupPage extends StatelessWidget {
  static const id = '/SignupPage';
  const SignupPage({super.key});

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
                        AppStrings.register.tr,
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
                          AppStrings.createNewAccountSubtitle.tr,
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
                  key: controller.signupFormKey,
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
                      SizedBox(
                        height: 15.sp,
                      ),
                      const TextInputField(
                        name: 'confirm Password',
                        inputType: TextInputType.text,
                        password: true,
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      MainColoredButton(
                        text: "Sign up",
                        fontSize: 12.sp,
                        isLoading: controller.isLoading,
                        onPress: controller.signup,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(LoginPage.id),
                        child: Text(
                          AppStrings.alreadyHaveAccount.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                              color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
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
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: 10.sp, vertical: 20.sp),
                      //   child: RichText(
                      //     textAlign: TextAlign.center,
                      //     text: TextSpan(
                      //       text:
                      //           'By clicking the button "Sign up" you agree to all our ',
                      //       style: TextStyle(
                      //           color: Colors.black26, fontSize: 8.sp),
                      //       children: [
                      //         TextSpan(
                      //             text: " Terms of service",
                      //             style: TextStyle(
                      //                 color: AppColors.primaryColor),
                      //             recognizer: TapGestureRecognizer()
                      //               ..onTap = () {}),
                      //         TextSpan(
                      //           text: " and",
                      //           onEnter: (e) {
                      //             debugPrint('test');
                      //           },
                      //         ),
                      //         TextSpan(
                      //             text: " Privacy policy",
                      //             style: TextStyle(
                      //                 color: AppColors.primaryColor),
                      //             recognizer: TapGestureRecognizer()
                      //               ..onTap = () {}),
                      //       ],
                      //     ),
                      //   ),
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
