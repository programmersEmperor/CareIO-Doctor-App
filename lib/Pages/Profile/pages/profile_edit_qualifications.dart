import 'package:cached_network_image/cached_network_image.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/connectivity_widget.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/no_data_widget.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Qualification.dart';
import 'package:careio_doctor_version/Pages/Profile/controller/profile_page_controller.dart';
import 'package:careio_doctor_version/Pages/Profile/custom/custom_list_tile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

class ProfileEditQualifications extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.find<ProfilePageController>();

    return SizedBox(
      child: Stack(
        children: [
          RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh:  () => Future.sync(
                  () => controller.qualificationPagingController.refresh(),
            ),
            child: ConnectivityWidget(
              child: PagedListView<int, Qualification>(
                builderDelegate: PagedChildBuilderDelegate<Qualification>(
                  animateTransitions: true,
                  noItemsFoundIndicatorBuilder: (_)=> Center(
                    child: NoDataWidget(message: "No Added Qualifications Yet!", top: 0),
                  ),
                  firstPageProgressIndicatorBuilder: (_) =>
                      SpinKitFadingCircle(
                        color: AppColors.primaryColor,
                      ),
                  itemBuilder: (context, item, index) => Padding(
                    padding: EdgeInsets.only(bottom: controller.qualificationPagingController.itemList != null && index == controller.qualificationPagingController.itemList!.length -1 ? 80 : 0),
                    child: CustomListTile(
                      title: item.title,
                      subTitle: item.issuer,
                      from: item.date,
                      onEdit: (){
                        controller.editQualificationBottomSheet(item);
                      },
                      onDelete: () async {
                        await controller.removeQualification(qualification: item);
                      },
                    ),
                  ),
                ),
                pagingController: controller.qualificationPagingController,
              ),
            ),
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
                    text: 'Add Qualification',
                    onPress: () {
                      controller.addNewQualificationBottomSheet();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}