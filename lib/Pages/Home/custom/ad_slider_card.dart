import 'package:careio_doctor_version/Models/Advertisment.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AdsSliderCard extends StatelessWidget {
  final Advertisement advertisement;
  const AdsSliderCard({
    super.key,
    required this.advertisement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(advertisement.image!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.sp),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 17.h,
              width: 100.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Colors.black38, Colors.transparent],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.sp),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: AutoSizeText(
                      "${advertisement.description}",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
