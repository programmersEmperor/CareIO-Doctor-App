import 'package:careio_doctor_version/Components/SharedWidgets/hospital_card.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Pages/Home/controller/appointment_controller.dart';
import 'package:careio_doctor_version/Pages/Home/custom/appointment_state_title_widget.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hospital_profile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:careio_doctor_version/Constants/appointment_enum.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../Components/SharedWidgets/cancel_button.dart';

class AppointmentCard extends StatelessWidget {
  final int index;
  final showDetails = false.obs;
  final Appointment appointment;
  AppointmentCard({
    super.key,
    required this.index,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.sp, left: 10.sp, right: 10.sp),
      child: Card(
        elevation: 15,
        shadowColor: Colors.grey.shade100,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: 15.sp, left: 15.sp, right: 15.sp, bottom: 2.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "${appointment.patientName}",
                        style: TextStyle(
                            fontSize: 11.sp, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.sp),
                        child: Text(
                          appointment.healthCenter.name!,
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      if(appointment.rating != null) ...[
                        Padding(
                          padding: EdgeInsets.only(top: 5.sp),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 12.sp,
                              ),
                              SizedBox(
                                width: 2.sp,
                              ),
                              Text(
                                appointment.rating!.toStringAsFixed(1),
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 10.sp),
                              ),
                            ],
                          ),
                        )
                      ],
                    ],
                  ),
                  Container(
                    height: 32.sp,
                    width: 32.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: appointment.doctor.avatar == null? null : DecorationImage(
                              image: CachedNetworkImageProvider(appointment.healthCenter.avatar!),
                              fit: BoxFit.cover,
                            ),
                      color: AppColors.secondaryColor,
                    ),
                    child: appointment.doctor.avatar == null ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: EdgeInsets.all(3.sp),
                        child: SvgPicture.asset(
                          'assets/svgs/hospital_icon.svg',
                          height: 15.sp,
                          width: 15.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ) : const SizedBox.shrink(),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Boxicons.bxs_calendar,
                            color: AppColors.primaryColor,
                            size: 12.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.sp, left: 2.sp, right: 2.sp),
                            child: Text(
                              appointment.date,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 8.5.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Boxicons.bxs_time,
                            color: AppColors.primaryColor,
                            size: 12.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.sp, left: 2.sp, right: 2.sp),
                            child: Text(
                              appointment.time12,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 8.5.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppointmentStateTitle(appointment: appointment),
                  ],
                ),
              ),
              // Obx(
              //   () => AnimatedSize(
              //     duration: 600.milliseconds,
              //     curve: Curves.linearToEaseOut,
              //     child: Container(
              //       width: 100.w,
              //       padding: EdgeInsets.only(top: 15.sp),
              //       child: showDetails.isFalse
              //           ? null
              //           : Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Padding(
              //                   padding:
              //                   EdgeInsets.only(top: 10.sp, bottom: 10.sp),
              //                   child: Container(
              //                     width: double.infinity,
              //                     padding: EdgeInsets.all(15.sp),
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(15.sp),
              //                       color: Colors.grey.withOpacity(0.1),
              //                     ),
              //                     child: Stack(
              //                       children: [
              //                         PositionedDirectional(
              //                           end: 0,
              //                           child: Opacity(
              //                             opacity: 0.2,
              //                             child: Icon(Icons.person,
              //                               color: AppColors.primaryColor,
              //                               size: 45.sp,
              //                             ),
              //                           ),
              //                         ),
              //                         Column(
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 AutoSizeText(
              //                                   AppStrings.reservationInName.tr,
              //                                   style: TextStyle(
              //                                       fontWeight: FontWeight.bold,
              //                                       color: AppColors.primaryColor,
              //                                       fontSize: 12.sp),
              //                                 ),
              //                               ],
              //                             ),
              //                             SizedBox(
              //                               height: 4.sp,
              //                             ),
              //                             AutoSizeText(
              //                               appointment.patientName,
              //                               style: TextStyle(fontSize: 9.sp),
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
              //                   child: Container(
              //                     width: double.infinity,
              //                     padding: EdgeInsets.all(15.sp),
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(15.sp),
              //                       color: appointment.wallet.isEmpty && appointment.status != AppointmentStatus.completed.index
              //                           ? Colors.orangeAccent.withOpacity(0.5)
              //                           : AppColors.secondaryColor,
              //                     ),
              //                     child: Stack(
              //                       children: [
              //                         PositionedDirectional(
              //                           end: 0,
              //                           child: Opacity(
              //                             opacity: 0.2,
              //                             child: Icon(
              //                               appointment.wallet.isEmpty && appointment.status != AppointmentStatus.completed.index
              //                                   ? Icons.timer
              //                                   : Icons.check,
              //                               color: appointment.wallet.isEmpty && appointment.status != AppointmentStatus.completed.index
              //                                   ? Colors.orange
              //                                   : AppColors.primaryColor,
              //                               size: 55.sp,
              //                             ),
              //                           ),
              //                         ),
              //                         Column(
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 AutoSizeText(
              //                                   AppStrings.price.tr,
              //                                   style: TextStyle(
              //                                       fontWeight: FontWeight.bold,
              //                                       color: appointment.wallet.isEmpty && appointment.status != AppointmentStatus.completed.index
              //                                           ? Colors.orange
              //                                           : AppColors.primaryColor,
              //                                       fontSize: 12.sp),
              //                                 ),
              //                                 SizedBox(
              //                                   width: 70.sp,
              //                                 ),
              //                                 AutoSizeText(
              //                                   appointment.price.toString(),
              //                                   style: TextStyle(
              //                                       fontWeight: FontWeight.bold,
              //                                       color: appointment.wallet.isEmpty && appointment.status != AppointmentStatus.completed.index
              //                                           ? Colors.orange
              //                                           : AppColors.primaryColor,
              //                                       fontSize: 12.sp),
              //                                 ),
              //
              //                               ],
              //                             ),
              //                             SizedBox(
              //                               height: 4.sp,
              //                             ),
              //                             AutoSizeText(
              //                             appointment.status != AppointmentStatus.completed.index
              //                                 ? appointment.wallet.isEmpty
              //                                   ? AppStrings.paymentWillBeInCash.tr
              //                                   : Get.locale.toString() == "ar_AR"
              //                                     ? '${AppStrings.paymentCompletedUsing.tr} ${appointment.wallet} ${AppStrings.wallet.tr}'
              //                                     : '${AppStrings.paymentCompletedUsing.tr} ${AppStrings.wallet.tr} ${appointment.wallet}'
              //                                 : appointment.wallet.isEmpty
              //                                   ? AppStrings.paymentWillBeInCash.tr
              //                                   : Get.locale.toString() == "ar_AR"
              //                                     ? '${AppStrings.paymentCompletedUsing.tr} ${appointment.wallet} ${AppStrings.wallet.tr}'
              //                                     : '${AppStrings.paymentCompletedUsing.tr} ${AppStrings.wallet.tr} ${appointment.wallet}',
              //                               style: TextStyle(fontSize: 9.sp),
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 if(AppointmentStatus.rejected.index == appointment.status && appointment.rejectionMessage != null)...[
              //                   Padding(
              //                     padding:
              //                     EdgeInsets.only(top: 10.sp, bottom: 10.sp),
              //                     child: Container(
              //                       width: double.infinity,
              //                       padding: EdgeInsets.all(15.sp),
              //                       decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(15.sp),
              //                         color: Colors.grey.withOpacity(0.1),
              //                       ),
              //                       child: Stack(
              //                         children: [
              //                           PositionedDirectional(
              //                             end: 0,
              //                             child: Opacity(
              //                               opacity: 0.2,
              //                               child: Icon(Icons.email,
              //                                 color: AppColors.primaryColor,
              //                                 size: 55.sp,
              //                               ),
              //                             ),
              //                           ),
              //                           Column(
              //                             crossAxisAlignment: CrossAxisAlignment.start,
              //                             children: [
              //                               Row(
              //                                 children: [
              //                                   AutoSizeText(
              //                                     "Rejection Reason",
              //                                     style: TextStyle(
              //                                         fontWeight: FontWeight.bold,
              //                                         color: AppColors.primaryColor,
              //                                         fontSize: 12.sp),
              //                                   ),
              //                                 ],
              //                               ),
              //                               SizedBox(
              //                                 height: 4.sp,
              //                               ),
              //                               AutoSizeText(
              //                                 appointment.rejectionMessage!,
              //                                 style: TextStyle(fontSize: 10.sp),
              //                               ),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ],
              //             ),
              //     ),
              //   ),
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: () => showDetails(!showDetails.value),
              //         style: ButtonStyle(
              //             elevation: const MaterialStatePropertyAll(0),
              //             backgroundColor: MaterialStatePropertyAll(
              //                 Theme.of(context).scaffoldBackgroundColor),
              //             shape: MaterialStatePropertyAll(
              //                 RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(10.sp)))),
              //         child: Obx(()=>Text(
              //           showDetails.isTrue ? AppStrings.showLess.tr : AppStrings.showMore.tr,
              //           style: TextStyle(
              //               color: Colors.black54,
              //               fontSize: 8.sp,
              //               fontWeight: FontWeight.w500),
              //         )),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Visibility(
              //       visible: appointment.status != AppointmentStatus.completed.index && appointment.status != AppointmentStatus.canceled.index,
              //       child: Expanded(
              //         child: ElevatedButton(
              //           onPressed: () => Get.find<AppointmentController>()
              //               .confirmRescheduleAppointment(id: appointment.id),
              //           style: ButtonStyle(
              //               elevation: const MaterialStatePropertyAll(0),
              //               backgroundColor: MaterialStatePropertyAll(
              //                   AppColors.primaryColor),
              //               shape: MaterialStatePropertyAll(
              //                   RoundedRectangleBorder(
              //                       borderRadius:
              //                           BorderRadius.circular(10.sp)))),
              //           child: Text(
              //             AppStrings.reschedule.tr,
              //             style: TextStyle(
              //                 fontSize: 8.sp, fontWeight: FontWeight.w800),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Visibility(
              //       visible: appointment.status < 3,
              //       child: const SizedBox(
              //         width: 10,
              //       ),
              //     ),
              //     Visibility(
              //       visible: appointment.status == AppointmentStatus.completed.index && appointment.rating == null,
              //       child: Expanded(
              //         child: ElevatedButton(
              //           onPressed: () => Get.find<AppointmentController>()
              //               .showRatingBottomSheet(
              //                   appointmentId: appointment.id),
              //           style: ButtonStyle(
              //               elevation: const MaterialStatePropertyAll(0),
              //               backgroundColor: MaterialStatePropertyAll(
              //                   AppColors.primaryColor),
              //               shape: MaterialStatePropertyAll(
              //                   RoundedRectangleBorder(
              //                       borderRadius:
              //                           BorderRadius.circular(10.sp)))),
              //           child: Text(
              //             "Rate",
              //             style: TextStyle(
              //                 fontSize: 9.sp, fontWeight: FontWeight.w800),
              //           ),
              //         ),
              //       ),
              //     ),
              //     if(appointment.status <= AppointmentStatus.accepted.index)...[
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       Expanded(
              //         child: CancelButton(
              //           onTap: () => Get.find<AppointmentController>()
              //               .confirmCancelAppointment(id: appointment.id),
              //         ),
              //       ),
              //     ],
              //   ],
              // ),
              SizedBox(
                height: 15.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
