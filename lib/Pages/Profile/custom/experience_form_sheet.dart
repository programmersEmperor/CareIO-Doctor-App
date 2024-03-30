import 'package:careio_doctor_version/Components/SharedWidgets/custom_datepicker.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Localization/localization_helper.dart';
import 'package:careio_doctor_version/Models/Experience.dart';
import 'package:careio_doctor_version/Pages/Profile/controller/profile_page_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ExperienceFormSheet extends StatelessWidget {
  final Experience? experience;
  final Function(Experience) onTap;
  const ExperienceFormSheet({super.key, this.experience, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.find<ProfilePageController>();

    return SingleChildScrollView(
      child: Container(
        width: 100.w,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                experience == null ? "Add New Experience" : "Edit New Experience",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20.sp,
              ),
              FormBuilder(
                key: controller.experienceFormKey,
                child: Column(
                  children: [
                    TextInputField(
                      name: 'Position',
                      required: true,
                      controller: controller.experiencePosition,
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    TextInputField(
                      name: 'Place',
                      required: true,
                      controller: controller.experiencePlace,
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Get.dialog(
                              CustomDatePicker(
                                selectableDayPredicate: (date) => date.isAfter(DateTime.now().toLocal()) == false,
                                firstDate: DateTime(DateTime.now().year - 40),
                                lastDate: DateTime.now(),
                                onDateChange: (date) {
                                  controller.experienceFromDate.text = DateFormat('yyyy-MM-dd').format(date).toString();
                                  Get.close(0);
                                },
                              ),
                              useSafeArea: false,
                            );
                          },
                          child: TextInputField(
                            name: 'From',
                            required: true,
                            controller: controller.experienceFromDate,
                            isEnabled: false,
                            prefix: SizedBox(
                              child: const Icon(
                                Icons.calendar_month_rounded,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                        child: Text("-", textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Get.dialog(
                              CustomDatePicker(
                                selectableDayPredicate: (date) => date.isAfter(DateTime.now().toLocal()) == false,
                                firstDate: DateTime(DateTime.now().year - 40),
                                lastDate: DateTime.now(),
                                onDateChange: (date) {
                                  controller.experienceToDate.text = DateFormat('yyyy-MM-dd').format(date).toString();
                                  Get.close(0);
                                },
                              ),
                              useSafeArea: false,
                            );
                          },
                          child: TextInputField(
                            name: 'To',
                            required: true,
                            controller: controller.experienceToDate,
                            isEnabled: false,
                            prefix: SizedBox(
                              child: const Icon(
                                Icons.calendar_month_rounded,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    MainColoredButton(
                      text: "Create Experience",
                      fontSize: 12.sp,
                      isLoading: controller.isButtonLoading,
                      onPress: (){},
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
      ),
    );
  }
}
