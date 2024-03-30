import 'package:careio_doctor_version/Components/SharedWidgets/custom_datepicker.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Localization/localization_helper.dart';
import 'package:careio_doctor_version/Models/Experience.dart';
import 'package:careio_doctor_version/Models/Qualification.dart';
import 'package:careio_doctor_version/Pages/Profile/controller/profile_page_controller.dart';
import 'package:careio_doctor_version/Pages/Profile/custom/custom_list_tile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:careio_doctor_version/Utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class QualificationFormSheet extends StatelessWidget {
  final bool isNew;
  final FutureCallBack onTap;
  final RxBool isLoading = false.obs;
  QualificationFormSheet({super.key, required this.onTap, this.isNew = true});

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
                isNew ? "Add New Qualification" : "Edit Qualification",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20.sp,
              ),
              FormBuilder(
                key: controller.qualificationFormKey,
                child: Column(
                  children: [
                    TextInputField(
                      name: 'Title',
                      required: true,
                      controller: controller.qualificationTitle,
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    TextInputField(
                      name: 'Source',
                      required: true,
                      controller: controller.qualificationIssuer,
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
                                initialDate: isNew ? null : DateTime.parse(controller.qualificationDate.text),
                                selectableDayPredicate: (date) => date.isAfter(DateTime.now().toLocal()) == false,
                                firstDate: DateTime(DateTime.now().year - 40),
                                lastDate: DateTime.now(),
                                onDateChange: (date) {
                                  controller.qualificationDate.text = DateFormat('yyyy-MM-dd').format(date).toString();
                                  Get.close(1);
                                },
                              ),
                              useSafeArea: false,
                            );
                          },
                          child: TextInputField(
                            name: 'Date',
                            required: true,
                            controller: controller.qualificationDate,
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
                      text: isNew? "Create Qualification" : "Save Changes",
                      fontSize: 12.sp,
                      isLoading: isLoading,
                      onPress: () async{
                        try{
                          if(isLoading.isTrue) return;

                          isLoading(true);
                          await onTap();
                          isLoading(false);
                        }
                        catch(e){
                          isLoading(false);
                          showSnack(
                              title: AppStrings.cannotCompleteOperation,
                              description: "$e");
                        }
                      },
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
