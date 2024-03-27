import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Constants/circular_icon_button.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Search/custom/clinic_chip.dart';
import 'package:careio_doctor_version/Pages/Search/custom/rating_chip.dart';
import 'package:careio_doctor_version/Services/CachingService/user_session.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FilterBottomSheet extends StatelessWidget {
  final Function(int?, int?, bool?) onTapFilter;
  final Function() onTapClearFilter;
  final bool isDoctor;
  const FilterBottomSheet(
      {super.key,
      required this.isDoctor,
      required this.onTapFilter,
      required this.onTapClearFilter});

  @override
  Widget build(BuildContext context) {
    int rating = 0;
    int clinicId = 0;
    var selectedIdIndex = RxInt(-1);
    var selectedRatingIndex = RxInt(-1);

    RxBool showNearby = false.obs;
    RxBool showRatingBy = false.obs;
    return SizedBox(
      width: 100.w,
      child:
          ListView(padding: EdgeInsets.all(20.sp), shrinkWrap: true, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.searchFilter.tr,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp),
            ),
            CircularIconButton(
              onTap: Get.back,
              height: 30.sp,
              width: 20.sp,
              iconSize: 15.sp,
              icon: Icons.close,
              backgroundColor: AppColors.secondaryColor,
              iconColor: AppColors.primaryColor,
            ),
          ],
        ),
        Visibility(
          visible: !isDoctor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: InkWell(
              onTap: () {
                showNearby(!showNearby.value);
              },
              child: Container(
                height: 7.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppStrings.showNearBy.tr,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Obx(
                        () => Checkbox(
                          value: showNearby.value,
                          activeColor: AppColors.primaryColor,
                          overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.sp)),
                          onChanged: (newValue) {
                            showNearby(!showNearby.value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
          if(isDoctor)...[
            SizedBox(
              height: 10.sp,
            ),
            Text(
              AppStrings.byClinic.tr,
              style: TextStyle(fontSize: 12.sp),
            ),
            Wrap(
              key: const ValueKey<int>(5),
              spacing: 7.sp,
              children: [
                for (var i = 0;
                i < Get.find<UserSession>().specializations.length;
                i++) ...[
                  Obx(
                        () => ClinicChip(
                      isSelected: (selectedIdIndex.value == i).obs,
                      title: Get.find<UserSession>().specializations[i].name,
                      onTap: () {
                        selectedIdIndex(i);
                        clinicId = Get.find<UserSession>().specializations[i].id;
                      },
                    ),
                  ),
                ]
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
          ],
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: InkWell(
                onTap: () {
                  showRatingBy(!showRatingBy.value);
                },
                child: Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            AppStrings.orderByRating.tr,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Obx(
                              () => Checkbox(
                            value: showRatingBy.value,
                            activeColor: AppColors.primaryColor,
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.sp)),
                            onChanged: (newValue) {
                              showRatingBy(!showRatingBy.value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

        // Text(
        //   "By rating",
        //   style: TextStyle(fontSize: 12.sp),
        // ),
        // SizedBox(
        //   height: 8.h,
        //   child: ListView.builder(
        //     itemCount: 5,
        //     shrinkWrap: true,
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (_, index) => Obx(
        //       () => RatingChip(
        //         title: "+${index + 1}",
        //         onTap: () {
        //           selectedRatingIndex(index);
        //           rating = index + 1;
        //         },
        //         isSelected: (selectedRatingIndex.value == index).obs,
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 10.sp,
        ),
        Row(
          children: [
            Expanded(
              child: MainColoredButton(
                text: AppStrings.seeResult.tr,
                onPress: () {
                  onTapFilter(
                    showRatingBy.isTrue? 1: 0,
                    clinicId != 0 ? clinicId : null,
                    showNearby.isTrue ? showNearby.value : null,
                  );
                },
              ),
            ),
            SizedBox(
              width: 10.sp,
            ),
            Expanded(
              child: MainColoredButton(
                text: AppStrings.clearFilter.tr,
                onPress: () {
                  onTapClearFilter();
                },
              ),
            ),
          ],
        )
      ]),
    );
  }
}
