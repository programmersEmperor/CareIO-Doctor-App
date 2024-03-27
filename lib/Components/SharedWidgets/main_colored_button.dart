import 'package:careio_doctor_version/Services/connectivityService/connectivity_service.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MainColoredButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final double? elevation;
  final double fontSize;
  RxBool? isLoading = false.obs;
  MainColoredButton({
    super.key,
    required this.text,
    this.onPress,
    this.elevation,
    this.isLoading,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isLoading == false.obs ||
                Get.find<ConnectivityHandler>().isOnline.isTrue
            ? onPress
            : () => {},
        style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(
            Size(100.w, 6.h),
          ),
          elevation:
              MaterialStatePropertyAll(onPress == null ? 0 : elevation ?? 15),
          shadowColor: MaterialStatePropertyAll(AppColors.primaryColor),
          backgroundColor: MaterialStatePropertyAll(
              onPress == null ? Colors.black26 : AppColors.primaryColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
          ),
        ),
        child: Obx(
          () => (isLoading ?? false.obs).isTrue
              ? const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 20.0,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: fontSize),
                ),
        ));
  }
}
