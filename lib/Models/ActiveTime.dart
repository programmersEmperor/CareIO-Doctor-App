import 'package:intl/intl.dart';

class ActiveTimes {
  ActiveTimes({
    int? id,
    int? day,
    String? from,
    String? to,
  }) {
    _id = id;
    _day = day;
    _from = from;
    _to = to;
  }

  ActiveTimes.fromJson(dynamic json) {
    _id = json['id'];
    _day = json['day'];
    _from = json['from'];
    _to = json['to'];
  }
  int? _id;
  int? _day;
  String? _from;
  String? _to;

  int? get id => _id;
  int? get day => _day;
  String? get from => _from;
  String? get to => _to;

  String time12(String? time) {
    if (time == null) return "";

    DateTime dateTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("h:mm a").format(dateTime);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['day'] = _day;
    map['from'] = _from;
    map['to'] = _to;
    return map;
  }
}
