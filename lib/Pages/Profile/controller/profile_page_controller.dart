import 'dart:convert';
import 'dart:io';

import 'package:careio_doctor_version/Models/Degree.dart';
import 'package:careio_doctor_version/Models/DoctorDetails.dart';
import 'package:careio_doctor_version/Models/Experience.dart';
import 'package:careio_doctor_version/Models/Plan.dart';
import 'package:careio_doctor_version/Models/Qualification.dart';
import 'package:careio_doctor_version/Models/Specialism.dart';
import 'package:careio_doctor_version/Models/client.dart';
import 'package:careio_doctor_version/Pages/Home/controller/home_page_controller.dart';
import 'package:careio_doctor_version/Pages/Home/home_main_page.dart';
import 'package:careio_doctor_version/Pages/Profile/custom/change_language_sheet.dart';
import 'package:careio_doctor_version/Pages/Profile/custom/experience_form_sheet.dart';
import 'package:careio_doctor_version/Pages/Profile/custom/logout_bottom_sheet.dart';
import 'package:careio_doctor_version/Pages/Profile/custom/qualification_form_sheet.dart';
import 'package:careio_doctor_version/Pages/Profile/profile_edit.dart';
import 'package:careio_doctor_version/Pages/Profile/profile_page.dart';
import 'package:careio_doctor_version/Services/Api/degrees.dart';
import 'package:careio_doctor_version/Services/Api/experiences.dart';
import 'package:careio_doctor_version/Services/Api/doctorUser.dart';
import 'package:careio_doctor_version/Services/Api/qualifications.dart';
import 'package:careio_doctor_version/Services/Api/specializations.dart';
import 'package:careio_doctor_version/Services/CachingService/user_session.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:careio_doctor_version/Utils/bottom_sheet_handle.dart';
import 'package:careio_doctor_version/Utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageController extends GetxController
    with GetTickerProviderStateMixin {
  Rx<DoctorDetails> doctorUser = Get.find<UserSession>().doctorUser.obs;
  final DoctorUserApiService _apiService = Get.find<DoctorUserApiService>();
  final SpecializationApiService specializationApiService = Get.find<SpecializationApiService>();
  final DegreesApiService degreeApiService = Get.find<DegreesApiService>();
  final ExperiencesApiService _experienceApiService = Get.find<ExperiencesApiService>();
  final QualificationsApiService _qualificationApiService = Get.find<QualificationsApiService>();
  final GlobalKey<FormBuilderState> userInfoFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> experienceFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> qualificationFormKey = GlobalKey<FormBuilderState>();

  late final TabController tabController;
  RxBool isPersonalInfoButtonLoading = false.obs;
  RxBool isPersonalInfoLoading = false.obs;
  RxBool get experienceIsLoading => _experienceApiService.isLoading;
  RxBool get qualificationIsLoading => _qualificationApiService.isLoading;

  RxBool changeImage = false.obs;

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController description = TextEditingController();
  late List<DropdownMenuItem> degrees;
  late List<DropdownMenuItem> specialisms;

  RxnInt updatedSpecialism = RxnInt(null);
  RxnInt updatedDegree = RxnInt(null);

  TextEditingController experiencePosition = TextEditingController();
  TextEditingController experiencePlace = TextEditingController();
  TextEditingController experienceFromDate = TextEditingController();
  TextEditingController experienceToDate = TextEditingController();

  TextEditingController qualificationTitle = TextEditingController();
  TextEditingController qualificationIssuer = TextEditingController();
  TextEditingController qualificationDate = TextEditingController();

  final PagingController<int, Experience> experiencePagingController = PagingController(firstPageKey: 1);
  final PagingController<int, Qualification> qualificationPagingController = PagingController(firstPageKey: 1);

  Rx<XFile> image = XFile('').obs;
  late ImagePicker picker;
  File get getImage => File(image.value.path);

  @override
  void onInit() async{
    tabController = TabController(length: 3, vsync: this);

    experiencePagingController.addPageRequestListener((pageKey) {
      fetchExperiences(pageKey: pageKey);
    });
    experiencePagingController.refresh();

    qualificationPagingController.addPageRequestListener((pageKey) {
      fetchQualifications(pageKey: pageKey);
    });
    qualificationPagingController.refresh();

    isPersonalInfoLoading(true);
    if(Get.find<UserSession>().specializations.isEmpty) await fetchSpecializations();
    specialisms = Get.find<UserSession>().specializations.map((Specialism specialism) => DropdownMenuItem(child: Text(specialism.name), value: specialism.id)).toList();

    if(Get.find<UserSession>().degrees.isEmpty) await fetchDegrees();
    degrees = Get.find<UserSession>().degrees.map((Degree degree) => DropdownMenuItem(child: Text(degree.name), value: degree.id)).toList();
    isPersonalInfoLoading(false);

    super.onInit();
  }

  Future<void> fetchSpecializations() async {
    var response = await specializationApiService.fetchSpecializations();
    if (response == null) return;

    List<Specialism> specializations = [];
    response.data['result'].forEach((e) => specializations.add(Specialism.fromJson(e)));
    Get.find<UserSession>().specializations = specializations;
  }

  Future<void> fetchDegrees() async {
    var response = await degreeApiService.fetchDegrees();
    if (response == null) return;

    List<Degree> degrees = [];
    response.data['result'].forEach((e) => degrees.add(Degree.fromJson(e)));
    Get.find<UserSession>().degrees = degrees;
  }

  void removeImage() {
    changeImage(true);
    image.value = XFile('');
  }

  void initControllers() {
    name.text = doctorUser.value.name ?? "";
    phone.text = doctorUser.value.phone ?? "";
    description.text = doctorUser.value.description ?? "";
  }

  void editDoctorUser() async {
    try{
      if (!userInfoFormKey.currentState!.saveAndValidate() || isPersonalInfoButtonLoading.isTrue) {
        return;
      }

      isPersonalInfoButtonLoading(true);
      var response = await _apiService.update(
        name: name.text,
        avatar: getImage,
        phone: phone.text,
        specialismId: updatedSpecialism.value ?? doctorUser.value.specialism.id,
        degreeId: updatedDegree.value ?? doctorUser.value.degree.id,
        description: description.text,
        removeAvatar: changeImage.isTrue && image.value.path.isEmpty
      );
      isPersonalInfoButtonLoading(false);

      if (response == null) return;
      var decodedResponse = json.decode(response.toString());
      await Get.find<UserSession>().saveDoctorUser({'doctor': decodedResponse['result']});

      refreshDoctorUserDataInOtherPages();

      showSnack(
          title: "Profile Updated",
          description: "Your data has been updated successfully");
    }
    catch(e){
      isPersonalInfoButtonLoading(false);
      showSnack(
          title: "Error",
          description: "$e");
    }
  }

  void showImageSelector(BuildContext context) {
    AnimationController controller =
        BottomSheet.createAnimationController(this);
    controller.duration = 500.milliseconds;
    controller.reverseDuration = 300.milliseconds;
    controller.drive(CurveTween(curve: Curves.fastEaseInToSlowEaseOut));
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
        return Padding(
          padding: EdgeInsets.only(bottom: 20.sp, right: 12.sp, left: 12.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(),
              ListTile(
                onTap: () => pickImage(ImageSource.camera),
                title: const Text("Take Image"),
                subtitle: const Text("Take a clear image using camera app"),
                titleTextStyle: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
                subtitleTextStyle: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.black54,
                ),
                iconColor: AppColors.primaryColor,
                leading: SizedBox(
                  width: 10.w,
                  height: 10.h,
                  child: Icon(
                    Boxicons.bx_camera,
                    size: 20.sp,
                  ),
                ),
              ),
              ListTile(
                onTap: () => pickImage(ImageSource.gallery),
                title: const Text("Select Image"),
                subtitle: const Text("Select a clear image using camera roll"),
                titleTextStyle: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
                subtitleTextStyle: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.black54,
                ),
                iconColor: AppColors.primaryColor,
                leading: SizedBox(
                  width: 10.w,
                  height: 10.h,
                  child: Icon(
                    Boxicons.bx_image_add,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickImage(ImageSource source) async {
    try {
      picker = ImagePicker();
      var takenImage = await picker.pickImage(
        source: source,
      );
      if (takenImage == null) return;
      image.value = takenImage;
      debugPrint("Path: ${image.value.path}");
      Get.close(0);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showLogoutBottomSheet() {
    Get.put(BottomSheetController())
        .showBottomSheet(const LogoutBottomSheet(), 100.h);
  }

  void showEditProfileBottomSheet(){
    Get.put(BottomSheetController()).showBottomSheet(const ProfileEditPage(), 100.h);
  }

  void changeLanguageBottomSheet() {
    Get.put(BottomSheetController())
        .showBottomSheet(const ChangeLanguageSheet(), 100.h);
  }

  void addNewExperienceBottomSheet(){
    experiencePosition.clear();
    experiencePlace.clear();
    experienceToDate.clear();
    experienceFromDate.clear();
    Get.put(BottomSheetController()).showBottomSheet(ExperienceFormSheet(onTap: () async {
          try{
            if(!experienceFormKey.currentState!.saveAndValidate()) return;

            var response = await _experienceApiService.createExperience(body: {
              "place": experiencePlace.text,
              "position": experiencePosition.text,
              "from": experienceFromDate.text,
              "to": experienceToDate.text,
            });
            if (response == null) return;
            Get.close(1);
            experiencePagingController.refresh();
          }
          catch(e){
            throw e;
          }
        },
    ), 100.h);
  }

  void editExperienceBottomSheet(Experience experience){
    experiencePosition.text = experience.position;
    experiencePlace.text = experience.place;
    experienceFromDate.text = experience.from;
    experienceToDate.text = experience.to;
    Get.put(BottomSheetController()).showBottomSheet(ExperienceFormSheet(isNew: false, onTap: () async {
      try{
        if(!experienceFormKey.currentState!.saveAndValidate()) return;

        var response = await _experienceApiService.editExperience(
            id: experience.id,
            body: {
          "place": experiencePlace.text,
          "position": experiencePosition.text,
          "from": experienceFromDate.text,
          "to": experienceToDate.text,
        });
        if (response == null) return;
        Get.close(1);
        experiencePagingController.refresh();
      }
      catch(e){
        throw e;
      }
    }), 100.h);
  }

  void addNewQualificationBottomSheet(){
    qualificationTitle.clear();
    qualificationIssuer.clear();
    qualificationDate.clear();
    Get.put(BottomSheetController()).showBottomSheet(QualificationFormSheet(onTap: () async {
      try{
        if(!qualificationFormKey.currentState!.saveAndValidate()) return;

        var response = await _qualificationApiService.createQualifications(body: {
          "title": qualificationTitle.text,
          "issuer": qualificationIssuer.text,
          "date": qualificationDate.text,
        });
        if (response == null) return;
        Get.close(1);
        qualificationPagingController.refresh();
      }
      catch(e){
        throw e;
      }
    }), 100.h);
  }

  void editQualificationBottomSheet(Qualification qualification){
    qualificationTitle.text = qualification.title;
    qualificationIssuer.text = qualification.issuer;
    qualificationDate.text = qualification.date;
    Get.put(BottomSheetController()).showBottomSheet(QualificationFormSheet(isNew: false, onTap: () async {
      try{
        if(!qualificationFormKey.currentState!.saveAndValidate()) return;
        var response = await _qualificationApiService.editQualifications(
            id: qualification.id,
            body: {
            "title": qualificationTitle.text,
            "issuer": qualificationIssuer.text,
            "date": qualificationDate.text,
          });
        if (response == null) return;
        Get.close(1);
        qualificationPagingController.refresh();
      }
      catch(e){
        throw e;
      }
    }), 100.h);
  }

  Future<void> fetchExperiences({required int pageKey}) async {
    try{
      final List<Experience> experiences =[];
      experienceIsLoading(true);
      var response = await _experienceApiService.fetchExperiences(params: {'page': pageKey });
      experienceIsLoading(false);
      if (response == null) return;
      debugPrint("experiences: ${response.data['result']['data']}");
      for (var experience in response.data['result']['data']) {
        experiences.add(Experience.fromJson(experience));
      }

      if(response.data['result']['meta']['last_page'] <= pageKey){
        experiencePagingController.appendLastPage(experiences);
      }
      else{
        experiencePagingController.appendPage(experiences, pageKey+1);
      }
    }catch(e){
      experienceIsLoading(false);
      debugPrint("Error in experience is $e");
      experiencePagingController.error = e;
    }
  }

  Future<void> createExperience({required Experience experience}) async {
    try{
      await _experienceApiService.createExperience(body: experience.toJson());
    }
    catch (e){
      throw e;
    }
  }

  Future<void> editExperience({required Experience experience}) async {
    try{
      await _experienceApiService.editExperience(id: experience.id, body: experience.toJson());
    }
    catch (e){
      throw e;
    }
  }

  Future<void> removeExperience({required Experience experience}) async {
    try{
      await _experienceApiService.removeExperience(id: experience.id);
      experiencePagingController.refresh();
    }
    catch (e){
      throw e;
    }
  }

  Future<void> fetchQualifications({required int pageKey}) async {
    try{
      final List<Qualification> qualifications =[];
      qualificationIsLoading(true);
      var response = await _qualificationApiService.fetchQualifications(params: {'page': pageKey });
      qualificationIsLoading(false);
      if (response == null) return;
      debugPrint("qualifications: ${response.data['result']['data']}");
      for (var qualification in response.data['result']['data']) {
        qualifications.add(Qualification.fromJson(qualification));
      }

      if(response.data['result']['meta']['last_page'] <= pageKey){
        qualificationPagingController.appendLastPage(qualifications);
      }
      else{
        qualificationPagingController.appendPage(qualifications, pageKey+1);
      }
    }catch(e){
      qualificationIsLoading(false);
      debugPrint("Error in qualification is $e");
      qualificationPagingController.error = e;
    }
  }

  Future<void> createQualification({required Qualification qualification}) async {
    try{
      await _qualificationApiService.createQualifications(body: qualification.toJson());
    }
    catch (e){
      throw e;
    }
  }

  Future<void> editQualification({required Qualification qualification}) async {
    try{
      await _qualificationApiService.editQualifications(id: qualification.id, body: qualification.toJson());
    }
    catch (e){
      throw e;
    }
  }

  Future<void> removeQualification({required Qualification qualification}) async {
    try{
      await _qualificationApiService.removeQualifications(id: qualification.id);
      qualificationPagingController.refresh();
    }
    catch (e){
      throw e;
    }
  }

  void refreshDoctorUserDataInOtherPages(){
    Get.find<HomePageController>().doctorUser.value = Get.find<UserSession>().doctorUser;
    Get.find<HomePageController>().doctorUser.refresh();

    Get.find<ProfilePageController>().doctorUser.value = Get.find<UserSession>().doctorUser;
    Get.find<ProfilePageController>().doctorUser.refresh();
  }

  Future<void> refreshDoctorUserData() async {
    try{

      var response = await _apiService.getDoctorUserData();
      if(response.statusCode != 200) return;
      final doctorUserData = {"doctor": response.data['result']};
      await Get.find<UserSession>().saveDoctorUser(doctorUserData);

      refreshDoctorUserDataInOtherPages();
    }
    catch(e){
      showSnack(title: "Error", description: e.toString());
    }
  }

  void openWhatsapp() async {
    String contact = "+967774569423";
    String message = Get.locale.toString() == 'ar_Ar' ? 'مربحا! احتاج الى مساعدة' : 'Hi, I need some help';
    var androidUrl = "whatsapp://send?phone=$contact&text=$message";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse(message)}";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{
      showSnack(title: "Error", description: "Whatsapp is not installed");
    }
  }

}
