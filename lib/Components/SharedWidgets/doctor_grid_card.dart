import 'package:careio_doctor_version/Pages/doctors/doctor_profile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';

class DoctorGridCard extends StatelessWidget {
  final int index;
  const DoctorGridCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(DoctorProfile.id, arguments: [
        {'index': index.toString()}
      ]),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width * 0.39,
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                        tag: "doc$index",
                        child: Image.asset(
                          'assets/images/person.jpg',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.31,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                    child: AutoSizeText(
                      "Dr haitham Hussien",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      overflowReplacement: Marquee(
                        text: "Dr haitham Hussein",
                        blankSpace: 20.0,
                        accelerationCurve: Curves.easeOut,
                        velocity: 50.0,
                        startPadding: 2.0,
                        showFadingOnlyWhenScrolling: true,
                        startAfter: 5.seconds,
                        fadingEdgeEndFraction: 0.5,
                        fadingEdgeStartFraction: 0.5,
                        pauseAfterRound: 5.seconds,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.sp),
                    child: Text(
                      "Specialization",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 8.sp,
                          color: Colors.black45),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
