import 'package:careio_doctor_version/Components/SharedWidgets/main_category_appbar.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/section_title.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/top_rated_pharmacy_card.dart';
import 'package:careio_doctor_version/Constants/custom_search_bar.dart';
import 'package:careio_doctor_version/Pages/Pharmacies/controller/pharmacies_page_controller.dart';
import 'package:careio_doctor_version/Pages/Pharmacies/custom/pharmacy_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PharmaciesPage extends StatelessWidget {
  static const id = "/PharmaciesPage";
  const PharmaciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    PharmaciesPageController controller = Get.put(PharmaciesPageController());
    return Scaffold(
      appBar: mainCategoryAppBar(controller, 'Pharmacies'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              title: 'Type medicine or pharmacy name ',
              controller: controller,
              isDoctor: false,
            ),
            SizedBox(
              height: 10.sp,
            ),
            const SectionTitle(
              title: "Top Rated Pharmacies",
            ),
            SizedBox(
              height: 4.sp,
            ),
            SizedBox(
              height: 28.h,
              child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => SizedBox(
                        width: 10.sp,
                      ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (_, index) => TopRatedPharmacyCard(
                        index: index,
                      )),
            ),
            SizedBox(
              height: 15.sp,
            ),
            const SectionTitle(
              title: "Pharmacies around you",
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (_, index) => PharmacyCard(index: index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
