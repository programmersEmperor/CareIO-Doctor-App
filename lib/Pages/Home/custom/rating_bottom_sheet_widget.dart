import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Pages/Home/controller/appointment_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RatingWidget extends StatelessWidget {
  final int appointmentId;
  const RatingWidget({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    AppointmentController controller = Get.find<AppointmentController>();
    int rating = 1;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(15.sp),
          topStart: Radius.circular(15.sp),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.sp),
            child: Text(
              "Rate your appointment",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
          ),
          RatingBar.builder(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            glow: true,
            glowColor: AppColors.primaryColor,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: AppColors.primaryColor,
            ),
            onRatingUpdate: (value) {
              rating = int.parse(value.toString().split('.').first);
            },
          ),
          Padding(
            padding: EdgeInsets.all(15.sp),
            child: MainColoredButton(
              isLoading: controller.ratingLoading,
              text: "Save",
              onPress: () {
                controller.rateAppointment(
                    appointmentId: appointmentId, rating: rating);
              },
            ),
          )
        ],
      ),
    );
  }
}
