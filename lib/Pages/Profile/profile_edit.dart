import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Profile/controller/profile_page_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfileEditPage extends StatelessWidget {
  static const id = "/ProfileEditPage";
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.find<ProfilePageController>();
    controller.initControllers();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                AppStrings.editPersonalInfo.tr,
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                ),
                child: ListView(
                  // physics: const NeverScrollableScrollPhysics(),
                  children: [
                    FormBuilder(
                      key: controller.key,
                      child: Column(
                        children: [
                          Obx(
                            () => Visibility(
                              visible: controller.patient.value.avatar.isEmpty ||
                                  controller.changeImage.isTrue,
                              child: GestureDetector(
                                child: Obx(
                                  () => controller.getImage.path.isEmpty
                                      ? CircleAvatar(
                                          radius: 60,
                                          backgroundColor:
                                              AppColors.secondaryColor,
                                          child: Icon(
                                            Icons.add_a_photo_outlined,
                                            size: 40,
                                            color: AppColors.primaryColor,
                                          ),
                                        )
                                      : Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: 60,
                                              backgroundColor:
                                                  AppColors.secondaryColor,
                                              backgroundImage: FileImage(
                                                  controller.getImage),
                                            ),
                                            GestureDetector(
                                              onTap: controller.removeImage,
                                              child: Container(
                                                  margin: EdgeInsets.all(2.sp),
                                                  padding: EdgeInsets.all(4.sp),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .scaffoldColor,
                                                          width: 2.sp),
                                                      shape: BoxShape.circle,
                                                      color: AppColors
                                                          .primaryColor),
                                                  child: Icon(
                                                    Boxicons.bx_trash_alt,
                                                    size: 15,
                                                    color: AppColors
                                                        .secondaryColor,
                                                  )),
                                            )
                                          ],
                                        ),
                                ),
                                onTap: () =>
                                    controller.showImageSelector(context),
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                                visible: controller.patient.value.avatar.isNotEmpty &&
                                    controller.changeImage.isFalse,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: AppColors.secondaryColor,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              controller.patient.value.avatar),
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
                                )),
                          ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          TextInputField(
                            name: 'name',
                            required: true,
                            controller: controller.name,
                          ),
                          // SizedBox(
                          //   height: 15.sp,
                          // ),
                          // TextInputField(
                          //   name: 'phone',
                          //   required: true,
                          //   inputType: TextInputType.phone,
                          //   controller: controller.phone,
                          // ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          TextInputField(
                            name: 'email',
                            required: false,
                            inputType: TextInputType.emailAddress,
                            controller: controller.email,
                          ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          MainColoredButton(
                            text: AppStrings.saveChanges.tr,
                            fontSize: 12.sp,
                            isLoading: controller.isLoading,
                            onPress: controller.editPatient,
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
      ),
    );
  }
}
