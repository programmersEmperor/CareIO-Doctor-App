import 'package:careio_doctor_version/Localization/localization_helper.dart';
import 'package:careio_doctor_version/Pages/Authentication/controllers/authentication_controller.dart';
import 'package:careio_doctor_version/Pages/Booking/book_appointment_controller.dart';
import 'package:careio_doctor_version/Pages/Notifications/notification_controller.dart';
import 'package:careio_doctor_version/Services/Api/appointment.dart';
import 'package:careio_doctor_version/Services/Api/authentication.dart';
import 'package:careio_doctor_version/Services/Api/book_appintment.dart';
import 'package:careio_doctor_version/Services/Api/degrees.dart';
import 'package:careio_doctor_version/Services/Api/doctors.dart';
import 'package:careio_doctor_version/Services/Api/experiences.dart';
import 'package:careio_doctor_version/Services/Api/home.dart';
import 'package:careio_doctor_version/Services/Api/hospitals.dart';
import 'package:careio_doctor_version/Services/Api/my_health_centers.dart';
import 'package:careio_doctor_version/Services/Api/notification.dart';
import 'package:careio_doctor_version/Services/Api/patient.dart';
import 'package:careio_doctor_version/Services/Api/qualifications.dart';
import 'package:careio_doctor_version/Services/Api/specializations.dart';
import 'package:careio_doctor_version/Services/Api/wallets.dart';
import 'package:careio_doctor_version/Services/connectivityService/connectivity_service.dart';
import 'package:get/get.dart';

class BindingService extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityHandler());
    Get.lazyPut(() => AuthenticationApiService(), fenix: true);
    Get.lazyPut(() => AuthenticationController(), fenix: true);
    Get.lazyPut(() => PatientApiService(), fenix: true);
    Get.put(AppointmentApiService(), permanent: true);
    Get.lazyPut(() => DoctorsApiService(), fenix: true);
    Get.lazyPut(() => HospitalApiService(), fenix: true);
    Get.lazyPut(() => NotificationApiService(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => HomeApiService(), fenix: true);
    Get.lazyPut(() => MyHealthCenters(), fenix: true);
    Get.lazyPut(() => BookAppointmentApiService(), fenix: true);
    Get.lazyPut(() => WalletsApiService(), fenix: true);
    Get.lazyPut(() => ExperiencesApiService(), fenix: true);
    Get.lazyPut(() => QualificationsApiService(), fenix: true);
    Get.lazyPut(() => BookAppointmentController(), fenix: true);
    Get.put(SpecializationApiService() , permanent: true);
    Get.put(DegreesApiService() , permanent: true);
    Get.put(LocalizationHelper());
  }
}
