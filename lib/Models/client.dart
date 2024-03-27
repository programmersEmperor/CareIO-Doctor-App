import 'package:careio_doctor_version/Models/Plan.dart';

class Patient {
  String name;
  final String phone;
  String email;
  String avatar;
  final Plan subscription;
  final int messageBalance;
  final int appointmentWaiting;
  final int appointmentBooked;

  Patient.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"] ?? "",
        phone = map["phone"],
        email = map["email"] ?? "",
        avatar = map["avatar"] ?? "",
        subscription = Plan.fromJson(map["subscription"]),
        messageBalance = map["messageBalance"] ?? 0,
        appointmentWaiting = map["appointmentWating"] ?? 0,
        appointmentBooked = map["appointmentBooked"] ?? 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['avatar'] = avatar;
    data['subscription'] = subscription.toJson();
    data['messageBalance'] = messageBalance;
    data['appointmentWaiting'] = appointmentWaiting;
    data['appointmentBooked'] = appointmentBooked;
    return data;
  }
}
