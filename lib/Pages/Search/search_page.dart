import 'package:careio_doctor_version/Constants/custom_search_bar.dart';
import 'package:careio_doctor_version/Pages/Search/custom/search_term_chip.dart';
import 'package:careio_doctor_version/Pages/doctors/doctor_profile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: Text(
            "Searching",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: const CustomSearchBar(
            title: "type anything",
            showFilter: false,
            controller: GetxController,
            isDoctor: false,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
          child: Text(
            "Latest search terms",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.sp,
          ),
          child: Wrap(
            spacing: 7.sp,
            runSpacing: 7.sp,
            children: const [
              LatestSearchTermsChip(),
              LatestSearchTermsChip(),
              LatestSearchTermsChip(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
          child: Text(
            "Nearby doctors",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 55.sp),
          child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: InkWell(
                onTap: () => Get.toNamed(
                  DoctorProfile.id,
                  arguments: [
                    {'index': index.toString()}
                  ],
                ),
                child: SizedBox(
                  child: Card(
                    elevation: 0.sp,
                    color: Colors.white,
                    shadowColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.sp, vertical: 7.sp),
                      child: Row(
                        children: [
                          Hero(
                            tag: "doc$index",
                            child: Container(
                              height: 50.sp,
                              width: 50.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      width: 3.sp),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/person.jpg",
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0.sp, right: 5.0.sp, top: 0.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Doctor name",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.5.sp),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 10.sp,
                                        ),
                                        Text(
                                          "3.4 (134 Review)",
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 8.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.5.sp),
                                    child: Text(
                                      "Specialization ",
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: CircleAvatar(
                                backgroundColor: AppColors.scaffoldColor,
                                radius: 12.sp,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 10.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
