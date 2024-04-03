import 'package:careio_doctor_version/Pages/Pharmacies/pharmacy_profile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PharmacyCard extends StatelessWidget {
  final int index;
  const PharmacyCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: InkWell(
        onTap: () => Get.toNamed(PharmacyProfile.id, arguments: [
          {'index': index}
        ]),
        child: SizedBox(
          child: Card(
            elevation: 0,
            color: Colors.white,
            shadowColor: Colors.grey.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 7.sp),
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
                            color: AppColors.scaffoldColor, width: 3.sp),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/hosptial.jpg",
                          ),
                        ),
                      ),
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
                            "Pharmacy name",
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.bold),
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
                              "location",
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
    );
  }
}
