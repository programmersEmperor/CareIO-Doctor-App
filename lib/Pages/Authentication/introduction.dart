import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Authentication/login/loginPage.dart';
import 'package:careio_doctor_version/Pages/Authentication/signup/signupPage.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent),
        ),
      ),
      extendBody: true,
      body: Column(
        children: [
          SizedBox(
            height: 55.h,
            width: 100.w,
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
                  child: SizedBox(
                    width: 70.w,
                    child: SvgPicture.asset("assets/svgs/undraw_medcine.svg"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 30.sp),
              child: Column(
                children: [
                  Text(
                    AppStrings.introductionHeading.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontSize: 25.sp),
                  ),
                  const Spacer(),
                  Text(
                    AppStrings.introductionSubHeading.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.sp, color: Colors.black38),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MainColoredButton(
                          text: AppStrings.login.tr,
                          onPress: () => Get.toNamed(LoginPage.id),
                        ),
                      ),
                      // Expanded(
                      //   child: TextButton(
                      //     onPressed: () => Get.toNamed(SignupPage.id),
                      //     child: Text(
                      //       AppStrings.register.tr,
                      //       style: const TextStyle(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                    ],
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
