class Qualifications {
  Qualifications({
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

  Qualifications.fromJson(dynamic json) {
    _id = json['id'];
    _place = json['place'];
    _position = json['position'];
    _from = json['from'];
    _to = json['to'];
  }
  int? _id;
  String? _place;
  String? _position;
  String? _from;
  String? _to;

  int? get id => _id;
  String? get place => _place;
  String? get position => _position;
  String? get from => _from;
  String? get to => _to;

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
