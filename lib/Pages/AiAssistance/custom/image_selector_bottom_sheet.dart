import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Constants/circular_icon_button.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ImageSelectorBottomSheet extends StatelessWidget {
  final dynamic uiController;
  const ImageSelectorBottomSheet({super.key, required this.uiController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Visibility(
              visible: uiController.image.value.path.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(top: 20.sp, right: 12.sp, left: 12.sp),
                child: Container(
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    image: DecorationImage(
                      image: FileImage(uiController.getImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: CircularIconButton(
                          onTap: uiController.removeImage,
                          icon: Icons.delete,
                          iconSize: 12.sp,
                          iconColor: Colors.black45,
                          backgroundColor: AppColors.scaffoldColor,
                          height: 45.sp,
                          width: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.sp),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.uploadImage.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.sp),
                        child: Text(
                          AppStrings.uploadImageHint.tr,
                          style:
                              TextStyle(fontSize: 8.sp, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
                CircularIconButton(
                  onTap: () => Get.close(0),
                  icon: Icons.close,
                  iconSize: 12.sp,
                  iconColor: AppColors.primaryColor,
                  backgroundColor: AppColors.secondaryColor,
                  height: 45.sp,
                  width: 20.sp,
                ),
              ],
            ),
          ),
          Obx(
            () => AnimatedCrossFade(
              crossFadeState: uiController.image.value.path.isNotEmpty
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: 500.milliseconds,
              firstCurve: Curves.fastEaseInToSlowEaseOut,
              secondCurve: Curves.fastEaseInToSlowEaseOut,
              reverseDuration: 500.milliseconds,
              secondChild: Padding(
                padding:
                    EdgeInsets.only(bottom: 20.sp, right: 12.sp, left: 12.sp),
                child: MainColoredButton(
                  text: AppStrings.upload.tr,
                  onPress: uiController.addImageToChat,
                ),
              ),
              firstChild: Padding(
                padding:
                    EdgeInsets.only(bottom: 20.sp, right: 12.sp, left: 12.sp),
                child: Column(
                  children: [
                    const Divider(),
                    ListTile(
                      onTap: () =>
                          uiController.uploadTheImage(ImageSource.camera),
                      title: Text(AppStrings.takeImage.tr),
                      subtitle: Text(AppStrings.takeImageHint.tr),
                      titleTextStyle: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                      subtitleTextStyle: TextStyle(
                        fontSize: 9.sp,
                        color: Colors.black54,
                      ),
                      iconColor: AppColors.primaryColor,
                      leading: SizedBox(
                        width: 10.w,
                        height: 10.h,
                        child: Icon(
                          Boxicons.bx_camera,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () =>
                          uiController.uploadTheImage(ImageSource.gallery),
                      title: Text(AppStrings.selectImage.tr),
                      subtitle: Text(AppStrings.selectImageHint.tr),
                      titleTextStyle: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                      subtitleTextStyle: TextStyle(
                        fontSize: 9.sp,
                        color: Colors.black54,
                      ),
                      iconColor: AppColors.primaryColor,
                      leading: SizedBox(
                        width: 10.w,
                        height: 10.h,
                        child: Icon(
                          Boxicons.bx_image_add,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
