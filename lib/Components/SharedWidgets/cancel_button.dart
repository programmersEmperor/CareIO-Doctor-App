import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor:
              MaterialStatePropertyAll(Colors.red.withOpacity(0.2)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp)))),
      child: Text(
        AppStrings.cancel.tr,
        style: TextStyle(
            color: Colors.red, fontSize: 8.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
