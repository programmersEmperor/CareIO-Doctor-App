import 'package:careio_doctor_version/Localization/app_strings.dart';

enum AppointmentStatus {
  pending(AppStrings.pending),
  confirmed(AppStrings.confirmed),
  accepted(AppStrings.accepted),
  rejected(AppStrings.rejected),
  canceled(AppStrings.canceled),
  completed(AppStrings.completed),
  unattended(AppStrings.unattended);

  final String value;
  const AppointmentStatus(this.value);
}

enum AppointmentTypes {
  upcoming([AppointmentStatus.pending, AppointmentStatus.confirmed, AppointmentStatus.accepted],  AppStrings.upcoming),
  completed([AppointmentStatus.completed, AppointmentStatus.unattended], AppStrings.completed),
  canceled([AppointmentStatus.rejected, AppointmentStatus.canceled], AppStrings.canceled);

  final List<AppointmentStatus> value;
  final String label;
  const AppointmentTypes(this.value, this.label);
}


