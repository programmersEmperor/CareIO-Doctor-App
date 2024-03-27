import 'package:careio_doctor_version/Components/SharedWidgets/back_circle_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/section_title.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:sizer/sizer.dart';

class MedicineProfile extends StatelessWidget {
  static const id = "/MedicineProfile";
  const MedicineProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overflow) {
          overflow.disallowIndicator();
          return true;
        },
        child: Stack(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                  elevation: 10.sp,
                                  shadowColor: Colors.blueGrey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.sp)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.sp),
                                    child: Image.asset(
                                      "assets/images/hosptial.jpg",
                                      fit: BoxFit.cover,
                                      height: 90.sp,
                                      width: 90.sp,
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
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 20.sp,
                                          ),
                                          AutoSizeText(
                                            "Medicine name",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 20.sp,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.sp,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Chip(
                                            avatar: Icon(
                                              Boxicons.bx_globe,
                                              color: AppColors.primaryColor,
                                              size: 15.sp,
                                            ),
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                            label: Text(
                                              "Made in Germany",
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                          SizedBox(
                                            width: 5.sp,
                                          ),
                                          Chip(
                                            avatar: Icon(
                                              Icons.person_outlined,
                                              color: AppColors.primaryColor,
                                              size: 15.sp,
                                            ),
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                            label: Text(
                                              "Headache",
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.sp,
                                ),
                                const SectionTitle(title: "Scientific name"),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0.sp),
                                  child: Container(
                                      width: 100.w,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Scientific name " * 3,
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.black54),
                                      )),
                                ),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                const SectionTitle(title: "Agent"),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0.sp),
                                  child: Container(
                                      width: 100.w,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Agent " * 3,
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.black54),
                                      )),
                                ),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                const SectionTitle(title: "Description"),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0.sp),
                                  child: Container(
                                    width: 100.w,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "Description " * 30,
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                const SectionTitle(title: "How to use"),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0.sp),
                                  child: Container(
                                    width: 100.w,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppColors.secondaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "Description " * 30,
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
