import 'package:careio_doctor_version/Pages/Authentication/forgetPassword/forget_password_page.dart';
import 'package:careio_doctor_version/Pages/Authentication/login/loginPage.dart';
import 'package:careio_doctor_version/Pages/Authentication/newPassword/newPassword.dart';
import 'package:careio_doctor_version/Pages/Authentication/otp/otp.dart';
import 'package:careio_doctor_version/Pages/Authentication/signup/signupPage.dart';
import 'package:careio_doctor_version/Pages/Clinics/clinic_profile.dart';
import 'package:careio_doctor_version/Pages/Home/home_page.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hopitals_page.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hospital_profile.dart';
import 'package:careio_doctor_version/Pages/Pharmacies/medicine_profile.dart';
import 'package:careio_doctor_version/Pages/Pharmacies/pharmacies_page.dart';
import 'package:careio_doctor_version/Pages/Pharmacies/pharmacy_profile.dart';
import 'package:careio_doctor_version/Pages/Profile/profile_edit.dart';
import 'package:careio_doctor_version/Pages/Profile/profile_page.dart';
import 'package:careio_doctor_version/Pages/Profile/settings.dart';
import 'package:careio_doctor_version/Pages/Search/specific_search_page.dart';
import 'package:careio_doctor_version/Pages/doctors/doctor_profile.dart';
import 'package:careio_doctor_version/Pages/doctors/doctors_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> allRoutes = [
    GetPage(name: DoctorsPage.id, page: () => const DoctorsPage()),
    GetPage(name: HomePage.id, page: () => const HomePage()),
    GetPage(name: LoginPage.id, page: () => const LoginPage()),
    GetPage(name: ProfileEditPage.id, page: () => const ProfileEditPage()),
    GetPage(name: MedicineProfile.id, page: () => const MedicineProfile()),
    GetPage(
        name: ForgetPasswordPage.id, page: () => const ForgetPasswordPage()),
    GetPage(name: OTPPage.id, page: () => const OTPPage()),
    GetPage(
      name: DoctorProfile.id,
      page: () => DoctorProfile(
        index: Get.arguments[0]['index'],
      ),
    ),
    GetPage(name: SignupPage.id, page: () => const SignupPage()),
    GetPage(name: HospitalsPage.id, page: () => const HospitalsPage()),
    GetPage(
      name: PharmacyProfile.id,
      page: () => PharmacyProfile(
        index: Get.arguments[0]['index'],
      ),
    ),
    GetPage(
      name: HospitalProfile.id,
      page: () => HospitalProfile(
        index: Get.arguments[0]['index'],
      ),
    ),
    GetPage(
      name: ClinicProfile.id,
      page: () => const ClinicProfile(),
    ),
    GetPage(
      name: ProfilePage.id,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: PharmaciesPage.id,
      page: () => const PharmaciesPage(),
    ),
    GetPage(
      name: SpecificSearchPage.id,
      page: () => const SpecificSearchPage(),
    ),
    GetPage(
      name: NewPasswordPage.id,
      page: () => const NewPasswordPage(),
    ),
    GetPage(
      name: SettingsPage.id,
      page: () => const SettingsPage(),
    ),
  ];
}
