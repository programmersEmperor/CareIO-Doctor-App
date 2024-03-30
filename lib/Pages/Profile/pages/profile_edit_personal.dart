import 'package:cached_network_image/cached_network_image.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/drop_down_input.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Profile/controller/profile_page_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfileEditPersonal extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.find<ProfilePageController>();

    return Padding(
      padding: EdgeInsets.only(top: 25.sp, left: 25.sp, right: 25.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: FormBuilder(
                  key: controller.userInfoFormKey,
                  child: Obx(()=> controller.isPersonalInfoLoading.isTrue
                      ? Container(
                        height: 50.h,
                        alignment: Alignment.center,
                        child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                        ),
                      )
                      : Column(
                    children: [
                      Obx(
                            () => Visibility(
                          visible: controller.doctorUser.value.avatar == null || controller.doctorUser.value.avatar!.isEmpty || controller.changeImage.isTrue,
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
                            visible: controller.doctorUser.value.avatar != null && controller.doctorUser.value.avatar!.isNotEmpty &&
                                controller.changeImage.isFalse,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: AppColors.secondaryColor,
                                  backgroundImage:
                                  CachedNetworkImageProvider(
                                      controller.doctorUser.value.avatar??""),
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
                        name: 'Name',
                        required: true,
                        controller: controller.name,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Obx(()=>DropDownInput(
                        name: 'specialism',
                        hintText: "Specialism",
                        items: controller.specialisms,
                        initialValue: controller.doctorUser.value.specialism!.id,
                        onChanged: (item){
                          controller.updatedSpecialism(item);
                        },
                      )),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Obx(()=> DropDownInput(
                            name: 'degree',
                            hintText: "Degree",
                            items: controller.degrees,
                            initialValue: controller.doctorUser.value.degree!.id,
                            onChanged: (item){
                              controller.updatedDegree(item);
                            },
                          )),
                      SizedBox(
                        height: 15.sp,
                      ),
                      TextInputField(
                        name: 'Description',
                        required: false,
                        maxLines: 5,
                        enableLabel: false,
                        controller: controller.description,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      MainColoredButton(
                        text: AppStrings.saveChanges.tr,
                        fontSize: 12.sp,
                        isLoading: controller.isButtonLoading,
                        onPress: controller.editDoctorUser,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                    ],
                  ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}