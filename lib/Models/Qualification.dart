class Qualification {
  Qualification({
    required int id,
    required String title,
    required String source,
    required String date,
  }) {
    _id = id;
    _title = title;
    _source = source;
    _date = date;
  }

  Qualification.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _source = json['source'];
    _date = json['date'];
  }
  int? _id;
  String? _title;
  String? _source;
  String? _date;

  int? get id => _id;
  String? get title => _title;
  String? get source => _source;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['source'] = _source;
    map['date'] = _date;
    return map;
  }
}
