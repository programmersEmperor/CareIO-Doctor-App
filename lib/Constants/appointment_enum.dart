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
  upcoming([AppointmentStatus.pending, AppointmentStatus.confirmed, AppointmentStatus.accepted]),
  completed([AppointmentStatus.completed, AppointmentStatus.unattended]),
  canceled([AppointmentStatus.rejected, AppointmentStatus.canceled]);

  final List<AppointmentStatus> value;
  const AppointmentTypes(this.value);
}


