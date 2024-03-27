import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Pages/AiAssistance/chatbot_page.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(15.sp)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            children: [
              Expanded(
                child: MainColoredButton(
                    text: "Save location",
                    onPress: () {
                      Get.close(0);
                      Get.toNamed(ChatBotPage.id);
                    }),
              ),
              SizedBox(
                width: 10.sp,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    maximumSize: MaterialStatePropertyAll(
                      Size(20.w, 6.h),
                    ),
                    minimumSize: MaterialStatePropertyAll(
                      Size(12.w, 6.h),
                    ),
                    padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                    elevation: const MaterialStatePropertyAll(15),
                    shadowColor:
                        MaterialStatePropertyAll(AppColors.primaryColor),
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.primaryColor),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                  ),
                  child: Icon(
                    Icons.my_location,
                    size: 17.sp,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
