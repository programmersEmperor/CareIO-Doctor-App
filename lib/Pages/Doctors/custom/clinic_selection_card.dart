import 'package:careio_doctor_version/Models/Clinic.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';

class ClinicSelectionCard extends StatelessWidget{
  final HealthCenter healthCenter;
  final Clinic clinic;
  final bool isSelected;
  final Function onTap;
  const ClinicSelectionCard({super.key, required this.healthCenter, required this.clinic, required this.isSelected, required this.onTap});


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: 15.sp),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: AnimatedContainer(
          duration: GetNumUtils(100).milliseconds,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
              color: isSelected
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
                        image: healthCenter.avatar != null
                            ? DecorationImage(
                            image: CachedNetworkImageProvider(
                                healthCenter.avatar ?? ""))
                            : const DecorationImage(
                          image: AssetImage("assets/images/hosptial.jpg"),
                          fit: BoxFit.cover,
                        )),
                    height: 30.sp,
                    width: 30.sp,
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
                            offset: isSelected
                                ? const Offset(0, 0)
                                : const Offset(-2, 0),
                            duration: GetNumUtils(200).milliseconds,
                            child: AnimatedOpacity(
                              opacity: isSelected ? 1 : 0,
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
                              healthCenter.name!,
                              style: TextStyle(
                                  color: isSelected
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
            ],
          ),
        ),
      ),
    );
  }
}