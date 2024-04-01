import 'package:careio_doctor_version/Components/SharedWidgets/text_input_field.dart';
import 'package:careio_doctor_version/Models/Wallet.dart';
import 'package:careio_doctor_version/Pages/Booking/book_appointment_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PaymentMethodCard extends StatelessWidget {
  final Wallet wallet;
  final RxBool selected;
  final Function onTap;
  final bool isExpandable;
  const PaymentMethodCard({
    super.key,
    required this.wallet,
    required this.selected,
    required this.isExpandable,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.sp),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Obx(
          () => AnimatedContainer(
            duration: GetNumUtils(100).milliseconds,
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
                color: wallet.selected.isTrue
                    ? AppColors.primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(10.sp)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          image: wallet.logo != null
                              ? DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      wallet.logo ?? ""))
                              : null),
                      height: 30.sp,
                      width: 30.sp,
                      child:wallet.logo == null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Icon(
                            Icons.money_outlined,
                            size: 22.sp,
                            color: selected.value ? Colors.white : AppColors.primaryColor,
                          )
                      )
                          : const SizedBox.shrink()
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          PositionedDirectional(
                            end: 0,
                            bottom: 0,
                            top: 0,
                            child: AnimatedSlide(
                              offset: wallet.selected.isTrue
                                  ? const Offset(0, 0)
                                  : const Offset(-2, 0),
                              duration: GetNumUtils(200).milliseconds,
                              child: AnimatedOpacity(
                                opacity: wallet.selected.isTrue ? 1 : 0,
                                duration: GetNumUtils(220).milliseconds,
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                wallet.name,
                                style: TextStyle(
                                    color: wallet.selected.isTrue
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if(isExpandable)...[
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: selected.isTrue
                        ? Padding(
                      padding: EdgeInsets.only(top: 10.sp),
                      child: FormBuilder(
                          key: Get.find<BookAppointmentController>().key,
                          child: Column(
                            children: [
                              Text(
                                "Please fill the fields with required details to complete the process successfully",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.white,
                                ),
                              ).animate().fade().slideY(
                                  curve: Curves.ease,
                                  duration: GetNumUtils(400).milliseconds),
                              SizedBox(
                                height: 2.h,
                              ),
                              TextInputField(
                                backgroundColor: Colors.white,
                                inputType: TextInputType.phone,
                                enableLabel: false,
                                name: 'phone',
                                required: isExpandable,
                              ).animate().fade().slideY(
                                  curve: Curves.ease,
                                  duration: GetNumUtils(500).milliseconds),
                              SizedBox(
                                height: 1.h,
                              ),
                              TextInputField(
                                backgroundColor: Colors.white,
                                name: 'code',
                                inputType: TextInputType.number,
                                required: isExpandable,
                                enableLabel: false,
                              ).animate().fade().slideY(
                                  curve: Curves.ease,
                                  duration: GetNumUtils(600).milliseconds),
                            ],
                          )),
                    )
                        : const SizedBox(),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
