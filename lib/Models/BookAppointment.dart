import 'dart:convert';

BookAppointment bookAppointmentFromJson(String str) =>
    BookAppointment.fromJson(json.decode(str));
String bookAppointmentToJson(BookAppointment data) =>
    json.encode(data.toJson());

class BookAppointment {
  BookAppointment({
    String? name,
    int? doctorId,
    int? clinicId,
    String? date,
    int? walletId,
    int? phone,
    String? paymentCode,
  }) {
    _doctorName = name;
    _doctorId = doctorId;
    _clinicId = clinicId;
    _date = date;
    _walletId = walletId;
    _phone = phone;
    _paymentCode = paymentCode;
  }

  BookAppointment.fromJson(dynamic json) {
    _doctorName = json['name'];
    _doctorId = json['doctorId'];
    _clinicId = json['clinicId'];
    _date = json['date'];
    _walletId = json['walletId'];
    _phone = json['phone'];
    _paymentCode = json['paymentCode'];
  }
  String? _doctorName;
  int? _doctorId;
  int? _clinicId;
  String? _date;
  int? _walletId;
  int? _phone;
  String? _paymentCode;

  String? get doctorName => _doctorName;
  int? get doctorId => _doctorId;
  int? get clinicId => _clinicId;
  String? get date => _date;
  int? get walletId => _walletId;
  int? get phone => _phone;
  String? get paymentCode => _paymentCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _doctorName;
    map['doctorId'] = _doctorId;
    map['clinicId'] = _clinicId;
    map['date'] = _date;
    map['walletId'] = _walletId;
    map['phone'] = _phone;
    map['paymentCode'] = _paymentCode;
    return map;
  }
}
