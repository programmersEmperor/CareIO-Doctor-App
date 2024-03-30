import 'package:intl/intl.dart';

class Qualification {
  Qualification({
    required int id,
    required String title,
    required String issuer,
    required String date,
  }) {
    _id = id;
    _title = title;
    _issuer = issuer;
    _date = date;
  }

  Qualification.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _issuer = json['issuer'];
    _date = json['date'];
  }
  late int _id;
  late String _title;
  late String _issuer;
  late String _date;

  int get id => _id;
  String get title => _title;
  String get issuer => _issuer;
  String get date => DateFormat('yyyy-MM-dd').format(DateTime.parse(_date)).toString();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['issuer'] = _issuer;
    map['date'] = _date;
    return map;
  }
}
