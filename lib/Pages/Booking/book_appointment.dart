import 'package:careio_doctor_version/Components/SharedWidgets/custom_datepicker.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/payment_method_card.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Constants/circular_icon_button.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/DoctorDetails.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Booking/book_appointment_controller.dart';
import 'package:careio_doctor_version/Pages/Booking/custom/book_timeslot_chip.dart';
import 'package:careio_doctor_version/Pages/Doctors/controller/doctor_profile_ui_controller.dart';
import 'package:careio_doctor_version/Pages/Doctors/custom/clinic_selection_card.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BookAppointment extends StatelessWidget {
  final DoctorDetails doctor;
  const BookAppointment({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    BookAppointmentController controller = Get.find<BookAppointmentController>();
    controller.selectClinic(doctor.healthCenters!.first.clinics.first, doctor);
    // controller.selectedClinicId.value = doctor.healthCenters!.first.clinics.first.id!;
    // controller.getTimes(id: doctor.id!, clinicId: doctor.healthCenters!.first.clinics.first.id!);
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: ListView(
          padding: EdgeInsets.all(20.sp),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32.sp,
                  width: 32.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: doctor.avatar == null? null : DecorationImage(
                      image: CachedNetworkImageProvider(doctor.avatar!),
                      fit: BoxFit.cover,
                    ),
                    color: AppColors.secondaryColor,
                  ),
                  child: doctor.avatar == null ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.all(3.sp),
                      child: SvgPicture.asset(
                        'assets/svgs/doctor_icon.svg',
                        height: 15.sp,
                        width: 15.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ) : const SizedBox.shrink(),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        AppStrings.bookFor.tr,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        height: 2.sp,
                      ),
                      AutoSizeText(
                        doctor.name ?? "",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                CircularIconButton(
                    onTap: Get.back,
                    height: 30.sp,
                    width: 20.sp,
                    iconSize: 15.sp,
                    icon: Icons.close,
                    backgroundColor: AppColors.secondaryColor,
                    iconColor: AppColors.primaryColor),
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
            AutoSizeText(
              AppStrings.chooseClinic.tr,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Obx(() => ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: doctor.healthCenters.map((healthCenter) => Column (
                  children: healthCenter.clinics.map((clinic) => ClinicSelectionCard(
                      healthCenter: healthCenter,
                      clinic: clinic,
                      isSelected: clinic.id == controller.selectedClinicId.value,
                      onTap: ()=> controller.selectClinic(clinic, doctor)
                  )).toList()
              )
              ).toList(),
            )),
            SizedBox(
              height: 15.sp,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(15.sp),
              ),

              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.watch_later_outlined,
                      size: 160.sp,
                      color: AppColors.primaryColor.withOpacity(0.1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(17.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          AppStrings.availableTimes.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => AutoSizeText(
                                  controller.day.value,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 1.sp),
                                      borderRadius: BorderRadius.circular(8.sp),
                                    ),
                                  ),
                                  maximumSize: MaterialStatePropertyAll(Size(25.w, 4.h)),
                                  minimumSize: MaterialStatePropertyAll(Size(25.w, 4.h)),
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.zero)),
                              onPressed: () {
                                Get.dialog(
                                  CustomDatePicker(
                                    selectableDayPredicate: (date){
                                      if(date.isBefore(DateTime.now().toLocal())){
                                        return false;
                                      }

                                      final List<HealthCenter> healthCenters = Get.find<DoctorProfileUiController>().filterHealthCentersByDay(healthCenters: doctor.healthCenters, day: date.weekday);
                                      return healthCenters.isNotEmpty;
                                    },
                                    onDateChange: (date) {
                                      controller.handleDayTitle(date: date);
                                      controller.getTimes(
                                          day: date,
                                          id: doctor.id!,
                                          clinicId: controller.selectedClinicId.value
                                      );

                                      Get.close(0);
                                    },
                                  ),
                                  useSafeArea: false,
                                );
                              },
                              child: Text(
                                AppStrings.anotherDate.tr,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Obx(
                          () => controller.isLoading.isTrue
                              ? Center(
                                  child: SpinKitFadingCircle(
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : controller.times.isEmpty
                                ? Center(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15),
                                        child: Text(AppStrings.notAvailableOnThisDay.tr, style: TextStyle(fontSize: 8.sp),)
                                    ),
                                  )
                                : Wrap(
                            key: const ValueKey<int>(5),
                            spacing: 7.sp,
                            children: [
                              for (var i = 0;
                              i < controller.times.length;
                              i++) ...[
                                BookTimeSlot(
                                  time: controller.times[i],
                                  onTapTime: (time) =>
                                      controller.onTapTime(time),
                                  isSelected:
                                  (controller.selectedTime.value ==
                                      controller.times[i])
                                      .obs,
                                ),
                              ]
                            ],
                          ).animate().fade(duration: const Duration(milliseconds: 500)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  AppStrings.choosePaymentMethod.tr,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                ),
                Obx(() =>
                    Visibility(
                      visible: controller.selectedClinicPrice.value != null,
                      child: AutoSizeText(
                        "${controller.selectedClinicPrice.value.toString()} ${AppStrings.rial.tr}",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                ),
              ],
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.wallets.length,
              itemBuilder: (BuildContext context, int index) =>
                  PaymentMethodCard(
                wallet: controller.wallets[index],
                selected: controller.wallets[index].selected,
                isExpandable: controller.wallets[index].id != -1,
                onTap: () => controller.selectWallet(index),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  AutoSizeText(
                    AppStrings.reservationInName.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextInputField(
                          name: 'name',
                          controller: controller.nameController,
                          required: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: AppStrings.bookingOne.tr,
                  style: TextStyle(color: Colors.black26, fontSize: 8.5.sp),
                  children: [
                    TextSpan(
                        text: AppStrings.privacyAndPolicy.tr,
                        style: TextStyle(color: AppColors.primaryColor),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                    TextSpan(
                      text: AppStrings.and.tr,
                      onEnter: (e) {
                        debugPrint('test');
                      },
                    ),
                    TextSpan(
                        text: AppStrings.termsAndServices.tr,
                        style: TextStyle(color: AppColors.primaryColor),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ],
                ),
              ),
            ),
            MainColoredButton(
              text: AppStrings.confirmBook.tr,
              isLoading: controller.bookLoading,
              onPress: () => controller.bookAppointment(
                  doctorId: doctor.id!,
                  clinicId: controller.selectedClinicId.value
              ),
            )
          ],
        ),
      ),
    );
  }
}
