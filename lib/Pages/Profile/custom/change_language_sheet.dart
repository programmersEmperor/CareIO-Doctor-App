import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Localization/localization_helper.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChangeLanguageSheet extends StatelessWidget {
  const ChangeLanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.pickYourPreferredLanguage.tr,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.sp),
              child: InkWell(
                onTap: () {
                  Get.find<LocalizationHelper>()
                      .changeLocale(const Locale('ar', 'AR'));
                },
                child: Obx(
                  () => AnimatedContainer(
                    duration: 100.milliseconds,
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                        color: Get.find<LocalizationHelper>()
                                    .appliedLocale
                                    .value ==
                                const Locale('ar', 'AR')
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.sp,
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.directional(
                                end: 0,
                                top: 0,
                                textDirection: TextDirection.rtl,
                                child: AnimatedSlide(
                                  offset: Get.find<LocalizationHelper>()
                                              .appliedLocale
                                              .value ==
                                          const Locale('ar', 'AR')
                                      ? const Offset(0, 0)
                                      : const Offset(-2, 0),
                                  duration: 200.milliseconds,
                                  child: AnimatedOpacity(
                                    opacity: Get.find<LocalizationHelper>()
                                                .appliedLocale
                                                .value ==
                                            const Locale('ar', 'AR')
                                        ? 1
                                        : 0,
                                    duration: 220.milliseconds,
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "اللغة العربية",
                                    style: TextStyle(
                                        color: Get.find<LocalizationHelper>()
                                                    .appliedLocale
                                                    .value ==
                                                const Locale('ar', 'AR')
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.sp),
              child: InkWell(
                onTap: () {
                  Get.find<LocalizationHelper>()
                      .changeLocale(const Locale('en', 'US'));
                },
                child: Obx(
                  () => AnimatedContainer(
                    duration: 100.milliseconds,
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                        color: Get.find<LocalizationHelper>()
                                    .appliedLocale
                                    .value ==
                                const Locale('en', 'US')
                            ? AppColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.sp,
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.directional(
                                end: 0,
                                top: 0,
                                textDirection: TextDirection.ltr,
                                child: AnimatedSlide(
                                  offset: Get.find<LocalizationHelper>()
                                              .appliedLocale
                                              .value ==
                                          const Locale('en', 'US')
                                      ? const Offset(0, 0)
                                      : const Offset(-2, 0),
                                  duration: 200.milliseconds,
                                  child: AnimatedOpacity(
                                    opacity: Get.find<LocalizationHelper>()
                                                .appliedLocale
                                                .value ==
                                            const Locale('en', 'US')
                                        ? 1
                                        : 0,
                                    duration: 220.milliseconds,
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "English",
                                    style: TextStyle(
                                        color: Get.find<LocalizationHelper>()
                                                    .appliedLocale
                                                    .value ==
                                                const Locale('en', 'US')
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
