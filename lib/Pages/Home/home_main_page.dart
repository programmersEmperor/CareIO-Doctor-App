import 'package:careio_doctor_version/Components/SharedWidgets/hospital_card.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/refresh_indicator_widget.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/section_title.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Doctors/custom/doctor_grid_widget.dart';
import 'package:careio_doctor_version/Pages/Home/controller/home_page_controller.dart';
import 'package:careio_doctor_version/Pages/Home/custom/ad_slider_card.dart';
import 'package:careio_doctor_version/Pages/Home/custom/ai_home_card.dart';
import 'package:careio_doctor_version/Pages/Home/custom/category_grid_element.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hopitals_page.dart';
import 'package:careio_doctor_version/Pages/doctors/doctors_page.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:carousel_animations/carousel_animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.find<HomePageController>();
    return RefreshWidget(
      onRefresh: controller.fetchHomeInfo,
      isLoading: controller.isLoading,
      child: ListView(
        padding: const EdgeInsets.only(top: 5),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            width: double.infinity,
            height: 20.h,
            child: Obx(
              () => controller.isLoading.isTrue
                  ? const SizedBox()
                  : Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        if (index > 0) {
                          return AdsSliderCard(
                            advertisement: controller.homeInfo.ads[index - 1],
                          );
                        } else {
                          return const AiHomeCard();
                        }
                      },
                      itemCount: 1 + controller.homeInfo.ads.length,
                      autoplay: true,
                      outer: true,
                      loop: true,
                      autoplayDelay: 6000,
                      duration: 3000,
                      pagination: const SwiperPagination(
                          builder: SwiperPagination.rect),
                    ),
            ),
          ),
          SizedBox(
            height: 14.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CategoryGridElement(
                      title: AppStrings.doctors.tr,
                      desc: "Find your best doctor",
                      onTap: () => Get.toNamed(DoctorsPage.id),
                      iconPath: "assets/svgs/doctor_icon.svg",
                    ),
                  ),
                  Expanded(
                    child: CategoryGridElement(
                      title: AppStrings.healthCenters.tr,
                      desc: "Find your best Hospital",
                      onTap: () => Get.toNamed(HospitalsPage.id),
                      iconPath: "assets/svgs/hospital_icon.svg",
                    ),
                  ),
                  // Expanded(
                  //   child: CategoryGridElement(
                  //     title: AppStrings.pharmacies.tr,
                  //     desc: "Explore medicine of your need",
                  //     onTap: () => Get.toNamed(PharmaciesPage.id),
                  //     iconPath: "assets/svgs/hospital_icon.svg",
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle(
                  title: AppStrings.topDoctors.tr,
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(DoctorsPage.id);
                  },
                  child: Text(
                    AppStrings.viewAll.tr,
                    style: TextStyle(
                        color: AppColors.primaryColor, fontSize: 9.sp),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Obx(
                () => controller.isLoading.isTrue
                    ? const SizedBox()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: controller.homeInfo.doctors.length,
                        itemBuilder: (_, index) => DoctorGridWidget(
                          doctor: controller.homeInfo.doctors[index],
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle(title: AppStrings.topHospitals.tr),
                TextButton(
                    onPressed: () {
                      Get.toNamed(HospitalsPage.id);
                    },
                    child: Text(
                      AppStrings.viewAll.tr,
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 9.sp),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 5, right: 5),
            child: Obx(
              () => controller.isLoading.isTrue
                  ? const SizedBox()
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.homeInfo.healthCenters.length,
                      itemBuilder: (_, index) => HospitalCard(
                        healthCenter: controller.homeInfo.healthCenters[index],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
