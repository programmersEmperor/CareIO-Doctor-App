import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Doctors/controller/doctor_profile_ui_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

typedef SelectableDayPredicate = bool Function(DateTime day);

class CustomDatePicker extends StatelessWidget {
  final Function onDateChange;
  final SelectableDayPredicate selectableDayPredicate;
  const CustomDatePicker({
    super.key,
    required this.onDateChange,
    required this.selectableDayPredicate,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.sp),
      backgroundColor: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.sp, left: 10.sp, right: 10.sp),
            child: Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.blue, // He
                colorScheme: ColorScheme.light(
                    primary: AppColors.primaryColor, secondary: Colors.blue),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.normal),
              ),
              child: CalendarDatePicker(
                selectableDayPredicate: selectableDayPredicate,
                initialDate: null,
                firstDate: DateTime(DateTime.now().year),
                lastDate: DateTime(DateTime.now().year + 50),
                onDateChanged: (date) {
                  onDateChange(date);
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
        ],
      ),
    );
  }
}
