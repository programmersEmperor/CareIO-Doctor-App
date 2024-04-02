import 'package:careio_doctor_version/Components/SharedWidgets/back_circle_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/connectivity_widget.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Clinics/clinic_profile.dart';
import 'package:careio_doctor_version/Pages/Doctors/custom/doctor_statics_divider.dart';
import 'package:careio_doctor_version/Pages/Home/custom/category_grid_element.dart';
import 'package:careio_doctor_version/Pages/Hospitals/custom/top_requested_doctors_card.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hopitals_page.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hospitals_ui_controller.dart';
import 'package:careio_doctor_version/Pages/doctors/custom/doctor_statics.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_animations/carousel_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HospitalProfile extends StatelessWidget {
  static const id = "/hospitalProfile";
  final String index;
  const HospitalProfile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    HospitalsUiController controller = Get.put(HospitalsUiController());
    controller.showHealthCenter(Get.arguments[0]['index']);

    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overflow) {
          overflow.disallowIndicator();
          return true;
        },
        child: ConnectivityWidget(
          child: Obx(
            () => controller.profileLoading.isTrue
                ? Center(
                    child: SpinKitFadingCircle(
                      color: AppColors.primaryColor,
                    ),
                  )
                : Stack(
                    children: [
                      CustomScrollView(
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            toolbarHeight: 30.sp,
                            systemOverlayStyle: SystemUiOverlayStyle(
                              statusBarColor: AppColors.primaryColor,
                              statusBarIconBrightness: Brightness.light,
                            ),
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BackCircleButton(),
                              ],
                            ),
                            backgroundColor: AppColors.primaryColor,
                            expandedHeight: 60.sp,
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 50.sp,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Card(
                                            elevation: 10.sp,
                                            shadowColor: Colors.blueGrey,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.sp)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.sp),
                                              child: Hero(
                                                tag:
                                                    "hospital${controller.healthCenter.id}",
                                                child: controller.healthCenter
                                                            .avatar !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            '${controller.healthCenter.avatar}',
                                                        fit: BoxFit.cover,
                                                        height: 90.sp,
                                                        width: 90.sp,
                                                      )
                                                    : Image.asset(
                                                        "assets/images/hosptial.jpg",
                                                        fit: BoxFit.cover,
                                                        height: 90.sp,
                                                        width: 90.sp,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4.sp),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    if(controller.healthCenter.rating != null)...[
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 15.sp,
                                                      ),
                                                      Text(
                                                        controller.healthCenter.rating!.toStringAsFixed(1),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 9.sp,
                                                        ),
                                                      ),
                                                    ],
                                                    SizedBox(
                                                      width: 20.sp,
                                                    ),
                                                    AutoSizeText(
                                                      "${controller.healthCenter.name}",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 20.sp,
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            5.sp),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.sp)),
                                                        child: Icon(
                                                          Boxicons
                                                              .bxs_phone_call,
                                                          color: Colors.white,
                                                          size: 15.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4.sp,
                                                ),
                                                Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.location_pin,
                                                      size: 10.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 2.sp,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "${controller.healthCenter.address}",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color:
                                                            Colors.black38),
                                                      ),
                                                    )
                                                  ],
                                                ),),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors.secondaryColor,
                                                        borderRadius: BorderRadius.circular(5.sp)
                                                      ),
                                                      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                                      child: Text(
                                                          controller.healthCenter.type!.value.tr,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if(controller.healthCenter.completedAppointment > 0)...[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 50.sp, right: 50.sp, top: 15.sp),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10.sp),
                                      decoration: BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          borderRadius:
                                          BorderRadius.circular(10.sp)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                AppStrings.totalBooking.tr,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.sp,
                                              ),
                                              Text(
                                                controller.healthCenter.completedAppointment.toString(),
                                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold ),
                                              ),
                                            ],
                                          ),
                                          // const DoctorStaticsDivider(),
                                          // DoctorStatics(
                                          //   title: AppStrings.totalBooking.tr,
                                          //   info: '230 patient',
                                          // ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if(controller.healthCenter.doctor.isNotEmpty)...[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.sp,
                                            left: 10.sp,
                                            right: 10.sp),
                                        child: AutoSizeText(
                                          AppStrings.topDoctors.tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 10.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 180,
                                        child: Swiper(
                                          itemCount: controller.healthCenter.doctor.length,
                                          autoplayDelay: 6000,
                                          duration: 3000,
                                          autoplay: true,
                                          itemBuilder: (_, index) =>
                                              TopRequestedDoctorsCard(
                                                doctor: controller.healthCenter.doctor[index],
                                              ),
                                        ),
                                      ),
                                    ],
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.sp,
                                        right: 10.sp,
                                        top: 10.sp,
                                        bottom: 80.sp,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if(controller.healthCenter.clinics.isNotEmpty)...[
                                            AutoSizeText(
                                              AppStrings.clinics.tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 10.sp),
                                            ),
                                            GridView.builder(
                                              itemCount: controller
                                                  .healthCenter.clinics.length,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.sp),
                                              physics:
                                              const NeverScrollableScrollPhysics(),
                                              itemBuilder: (_, index) =>
                                                  CategoryGridElement(
                                                    title: controller.healthCenter
                                                        .clinics[index].name ??
                                                        "",
                                                    desc: AppStrings
                                                        .findYourHospital.tr,
                                                    onTap: () => Get.toNamed(ClinicProfile.id, arguments: [{
                                                      'clinic' : controller.healthCenter.clinics[index]
                                                    }]),
                                                    iconPath:
                                                    "assets/svgs/hospital_icon.svg",
                                                  ),
                                              gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                              ),
                                              shrinkWrap: true,
                                            ),
                                          ],
                                          Padding(
                                            padding:
                                            EdgeInsets.only(top: 18.sp),
                                            child: AutoSizeText(
                                              AppStrings.location.tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 10.sp),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(top: 18.sp),
                                            child: SizedBox(
                                              width: 100.w,
                                              height: 25.h,
                                              child: Card(
                                                color: Colors.white,
                                                elevation: 15.sp,
                                                shadowColor: AppColors
                                                    .secondaryColor
                                                    .withOpacity(0.4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15.sp),
                                                ),
                                                child: Center(
                                                  child: InteractiveViewer(
                                                    child: Image.asset(
                                                      'assets/images/map.jpg',
                                                      fit: BoxFit.cover,
                                                      height: 300,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                            width: 90.w,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: MainColoredButton(
                                text: AppStrings.bookNow.tr,
                                onPress: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
