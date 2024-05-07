import 'dart:io';

import 'package:careio_doctor_version/Pages/Authentication/introduction.dart';
import 'package:careio_doctor_version/Pages/Authentication/login/loginPage.dart';
import 'package:careio_doctor_version/Pages/Authentication/newPassword/newPassword.dart';
import 'package:careio_doctor_version/Pages/Authentication/otp/otp.dart';
import 'package:careio_doctor_version/Pages/Home/home_page.dart';
import 'package:careio_doctor_version/Services/Api/authentication.dart';
import 'package:careio_doctor_version/Services/CachingService/user_session.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:careio_doctor_version/Utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AuthenticationController extends GetxController
    with GetTickerProviderStateMixin {
  final GlobalKey<FormBuilderState> loginFormKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> signupFormKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> newPasswordFormKey =
      GlobalKey<FormBuilderState>();

  final GlobalKey<FormBuilderState> completeSetupFormKey =
      GlobalKey<FormBuilderState>();

  final GlobalKey<FormBuilderState> sendOtpFormKey =
      GlobalKey<FormBuilderState>();
  final apiService = Get.find<AuthenticationApiService>();

  String otpCode = '';
  Rx<XFile> image = XFile('').obs;
  late ImagePicker picker;
  File get getImage => File(image.value.path);
  Map<String, dynamic> formValues = {};
  RxBool get isLoading => apiService.isLoading;

  void removeImage() {
    image.value = XFile('');
  }

  void showImageSelector(BuildContext context) {
    AnimationController controller =
        BottomSheet.createAnimationController(this);
    controller.duration = 500.milliseconds;
    controller.reverseDuration = 300.milliseconds;
    controller.drive(CurveTween(curve: Curves.fastEaseInToSlowEaseOut));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              topRight: Radius.circular(15.sp))),
      useSafeArea: true,
      transitionAnimationController: controller,
      constraints: BoxConstraints(maxHeight: 94.h),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 20.sp, right: 12.sp, left: 12.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(),
              ListTile(
                onTap: () => pickImage(ImageSource.camera),
                title: const Text("Take Image"),
                subtitle: const Text("Take a clear image using camera app"),
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
                onTap: () => pickImage(ImageSource.gallery),
                title: const Text("Select Image"),
                subtitle: const Text("Select a clear image using camera roll"),
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
        );
      },
    );
  }

  void pickImage(ImageSource source) async {
    try {
      picker = ImagePicker();
      var takenImage = await picker.pickImage(
        source: source,
      );
      if (takenImage == null) return;
      image.value = takenImage;
      debugPrint("Path: ${image.value.path}");
      Get.close(0);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool _isFormValid({bool login = false, bool signup = false}) {
    bool valid = false;
    if (login) {
      valid = loginFormKey.currentState?.saveAndValidate() ?? false;
      if (valid) {
        formValues = loginFormKey.currentState!.value;
      }
    }

    if (signup) {
      valid = signupFormKey.currentState?.saveAndValidate() ?? false;
      if (valid) {
        formValues = signupFormKey.currentState!.value;
      }
    }

    return valid;
  }

  Future<void> login() async {
    if (!_isFormValid(login: true)) return;

    final response = await apiService.login(body: formValues);
    if (response == null) return;

    if(response.statusCode == 200){
      if (await Get.find<UserSession>().saveDoctorUser(response.data['result'])) {
        debugPrint(
            'Token  var is ${Get.find<UserSession>().token} and api is ${response.data['result']['token']}');
        if (Get.find<UserSession>().doctorUser.name == "") {
          // Get.toNamed(CompleteSetup.id);
          return;
        }
        Get.offAllNamed(HomePage.id);
      }
    }
    else if (response.statusCode == 203){
      Get.find<UserSession>().token = response.data['result']['temp-token'];
      Get.toNamed(OTPPage.id);
    }
  }

  Future<void> resetPassword() async {
    if (!newPasswordFormKey.currentState!.saveAndValidate()) return;
    if (newPasswordFormKey.currentState!.value['new password'] !=
        newPasswordFormKey.currentState!.value['confirm password']) {
      showSnack(
          title: "password not match",
          description: "Password has to be matched to continue");

      return;
    }
    String password =
        newPasswordFormKey.currentState!.value['confirm password'];
    var response = await apiService.forgetPassword(password: password);
    if (response != null && response.data['result'] is List) {
      Get.offAllNamed(LoginPage.id);
    }
  }

  Future<void> signup() async {
    if (!_isFormValid(signup: true)) return;
    if (formValues['password'] != formValues['confirm Password']) {
      showSnack(title: "Password", description: "Password is not identical");
      return;
    }

    final response = await apiService.signup(body: formValues);
    debugPrint("The response ${response.toString()}");
    if (response == null) return;
    Get.find<UserSession>().token = response.data['result']['temp-token'];
    Get.toNamed(OTPPage.id);
  }

  Future<void> sendOtp() async {
    if (!sendOtpFormKey.currentState!.saveAndValidate()) return;

    formValues = sendOtpFormKey.currentState!.value;
    final response = await apiService.sendOtp(body: formValues);
    if (response == null) return;
    Get.find<UserSession>().token = response.data['result']['temp-token'];
    Get.toNamed(OTPPage.id, arguments: true);
    // Get.toNamed(NewPasswordPage.id);
  }

  Future<void> verifyOtp({bool isReset = false}) async {
    if (otpCode.isEmpty || otpCode.length != 6) {
      showSnack(title: "OTP", description: "OTP must be 6 digit");
      return;
    }

    final response =
        await apiService.verifyOtp(otp: int.parse(otpCode), isReset: isReset);
    if (response == null) return;

    if (response.data['result']['temp-token'] != null) {
      Get.find<UserSession>().token = response.data['result']['temp-token'];
      Get.toNamed(NewPasswordPage.id);
    } else {
      if (await Get.find<UserSession>().saveDoctorUser(response.data['result'])) {
        if (Get.find<UserSession>().doctorUser.name == "") {
          // Get.toNamed(CompleteSetup.id);
          return;
        }
        Get.offAllNamed(HomePage.id);
      }
    }
  }

  Future<void> logOut() async {
    if (await Get.find<UserSession>().logout()) {
      Get.offAll(() => const IntroductionPage());
    }
  }
}
