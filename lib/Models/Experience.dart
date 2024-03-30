import 'package:intl/intl.dart';

class Experience {
  Experience({
    required int id,
    required String place,
    required String position,
    required String from,
    required String to,
  }) {
    _id = id;
    _place = place;
    _position = position;
    _from = from;
    _to = to;
  }

  Experience.fromJson(dynamic json) {
    _id = json['id'];
    _place = json['palce'];
    _position = json['position'];
    _from = json['from'];
    _to = json['to'];
  }
  late int _id;
  late String _place;
  late String _position;
  late String _from;
  late String _to;

  int get id => _id;
  String get place => _place;
  String get position => _position;
  String get from => DateFormat('yyyy-MM-dd').format(DateTime.parse(_from)).toString();
  String get to => DateFormat('yyyy-MM-dd').format(DateTime.parse(_to)).toString();


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['place'] = _place;
    map['position'] = _position;
    map['from'] = _from;
    map['to'] = _to;
    return map;
  }
}
