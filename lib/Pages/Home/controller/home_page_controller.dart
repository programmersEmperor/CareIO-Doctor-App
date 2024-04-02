import 'dart:developer';

import 'package:careio_doctor_version/Models/Degree.dart';
import 'package:careio_doctor_version/Models/DoctorDetails.dart';
import 'package:careio_doctor_version/Models/HomeInfo.dart';
import 'package:careio_doctor_version/Models/Plan.dart';
import 'package:careio_doctor_version/Models/Specialism.dart';
import 'package:careio_doctor_version/Models/Wallet.dart';
import 'package:careio_doctor_version/Models/client.dart';
import 'package:careio_doctor_version/Pages/Home/animations/animation_handler.dart';
import 'package:careio_doctor_version/Pages/Home/custom/map_bottom_sheet.dart';
import 'package:careio_doctor_version/Pages/Home/home_main_page.dart';
import 'package:careio_doctor_version/Pages/Home/my_appoinments_page.dart';
import 'package:careio_doctor_version/Pages/Home/my_health_centers_page.dart';
import 'package:careio_doctor_version/Pages/Notifications/notifications_page.dart';
import 'package:careio_doctor_version/Pages/Profile/profile_page.dart';
import 'package:careio_doctor_version/Services/Api/degrees.dart';
import 'package:careio_doctor_version/Services/Api/home.dart';
import 'package:careio_doctor_version/Services/Api/doctorUser.dart';
import 'package:careio_doctor_version/Services/Api/specializations.dart';
import 'package:careio_doctor_version/Services/Api/wallets.dart';
import 'package:careio_doctor_version/Services/CachingService/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomePageController extends GetxController
    with GetTickerProviderStateMixin {
  RxInt activePage = 4.obs;
  Rx<DoctorDetails> doctorUser = Get.find<UserSession>().doctorUser.obs;
  final List<IconData> icons = [
    Boxicons.bx_buildings,
    Boxicons.bx_calendar,
    Boxicons.bx_bell,
    Boxicons.bx_user,
  ];

  HomeApiService apiService = Get.find<HomeApiService>();
  WalletsApiService walletsApiService = Get.find<WalletsApiService>();
  DoctorUserApiService doctorUserApiService = Get.find<DoctorUserApiService>();

  RxBool get isLoading => apiService.isLoading;
  RxBool get walletIsLoading => walletsApiService.isLoading;

  late HomeAnimationHandler animationHandler;

  List<dynamic> pages = [
    const MyHealthCentersPage(),
    const MyAppointmentsPage(),
    const NotificationsPage(),
    const ProfilePage(),
    const HomeMainPage(),
  ];
  late HomeInfo homeInfo;

  @override
  void onInit() async {
    super.onInit();

    animationHandler = Get.put(HomeAnimationHandler());

    await fetchHomeInfo();
  }

  Future<void> fetchPlans() async {
    var response = await doctorUserApiService.getPlans();
    if (response == null) return;
    debugPrint("Response is ${response.data['result']}");

    List<Plan> plans = [];
    response.data['result'].forEach((e) => plans.add(Plan.fromJson(e)));
    // Get.find<UserSession>().plans = plans;
  }

  void changePage(int index) {
    activePage(index);
    debugPrint(index.toString());
  }

  Future<void> fetchHomeInfo() async {
    var response = await apiService.fetchHomeInfo(body: {'page': 1});
    if (response == null) return;
    debugPrint("Response is ${response.data['result']}");

    homeInfo = HomeInfo.fromJson(response.data['result']);
  }

  Future<void> fetchWallets() async {
    var response = await walletsApiService.fetchWallets();
    log(response.toString());
    if (response == null) return;

    List<Wallet> wallets = [];
    response.data['result'].forEach((e) => wallets.add(Wallet.fromJson(e)));
    Get.find<UserSession>().wallets = wallets;
  }

  void showMapBottomSheet(BuildContext context) {
    AnimationController controller =
        BottomSheet.createAnimationController(this);

    controller.duration = 600.milliseconds;

    controller.reverseDuration = 300.milliseconds;

    controller.drive(CurveTween(curve: Curves.bounceInOut));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              topRight: Radius.circular(15.sp))),
      useSafeArea: true,
      transitionAnimationController: controller,
      constraints: BoxConstraints(maxHeight: 94.h),
      builder: (BuildContext context) {
        return const MapBottomSheet();
      },
    );
  }
}
