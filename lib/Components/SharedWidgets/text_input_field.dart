import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TextInputField extends StatelessWidget {
  final String name;
  final TextInputType inputType;
  final bool password;
  final bool enableLabel;
  final bool required;
  final Color backgroundColor;
  final TextEditingController? controller;
  final bool isEnabled;
  final Widget? prefix;
  final int maxLines;

  const TextInputField(
      {super.key,
        required this.name,
        this.required = false,
        this.inputType = TextInputType.text,
        this.password = false,
        this.backgroundColor = CupertinoColors.systemGrey5,
        this.enableLabel = true,
        this.controller,
        this.isEnabled = true,
        this.prefix,
        this.maxLines = 1,
      });

  @override
  Widget build(BuildContext context) {
    bool isValid(TextInputType textInputType) {
      return inputType == textInputType;
    }

    RxBool showPassword = password.obs;

    return SizedBox(
      child: Obx(
        () => FormBuilderTextField(
          enabled: isEnabled,
          name: name.trim(),
          maxLines: maxLines,
          controller: controller,
          obscureText: showPassword.value,
          maxLength: inputType == TextInputType.phone ? 9 : null,
          cursorRadius: const Radius.circular(10),
          cursorColor: AppColors.primaryColor,
          keyboardType: inputType,
          validator: FormBuilderValidators.compose([
            if (isValid(TextInputType.emailAddress)) ...[
              FormBuilderValidators.email(
                  errorText: "AppStrings.emailFormatIsNotCorrect.tr"),
            ],
            if (required)
              FormBuilderValidators.required(errorText: "requiredField".tr),
            if (isValid(TextInputType.phone))
              FormBuilderValidators.minLength(
                9,
                errorText: "invalidPhone".tr,
              ),
            if (isValid(TextInputType.phone))
              FormBuilderValidators.maxLength(9, errorText: "invalidPhone".tr),
            if (isValid(TextInputType.phone))
              (val) {
                if (inputType == TextInputType.phone && val![0] == "7") {
                  if (val[1] != "0" &&
                      val[1] != "3" &&
                      val[1] != "1" &&
                      val[1] != "7" &&
                      val[1] != "8") {
                    return "invalidPhone".tr;
                  }
                } else {
                  return "invalidPhone".tr;
                }
                return null;
              },
            if (password)
              FormBuilderValidators.minLength(8,
                  errorText: "passwordMessage".tr),
          ]),
          style: TextStyle(fontSize: 9.sp, color: Colors.black54),
          decoration: InputDecoration(
            counter: const SizedBox(),
            isDense: true,
            prefix: prefix,
            suffixIcon: password
                ? SizedBox(
                    height: 5.h,
                    child: GestureDetector(
                      onTap: () {
                        showPassword(!showPassword.value);
                      },
                      child: const Icon(
                        Icons.remove_red_eye,
                        size: 15,
                      ),
                    ),
                  )
                : const SizedBox(),
            suffixIconColor: Colors.grey,
            floatingLabelStyle:
                TextStyle(color: AppColors.primaryColor, fontSize: 13.sp),
            hintText: name.tr,
            hintStyle: TextStyle(fontSize: 10.sp, color: Colors.grey),
            fillColor: backgroundColor,
            filled: true,
            focusColor: AppColors.primaryColor,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: const BorderSide(color: Colors.redAccent)),
            labelText: enableLabel ? name.capitalize : null,
            errorStyle: TextStyle(
              fontSize: 10.sp,
            ),
            labelStyle: TextStyle(
              fontSize: 10.sp,
              color: Colors.black45,
            ),
            // contentPadding:
            //     EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
              borderSide: const BorderSide(color: CupertinoColors.systemGrey5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
              borderSide: const BorderSide(color: CupertinoColors.systemGrey5),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.primaryColor)),
          ),
        ),
      ),
    );
  }
}
