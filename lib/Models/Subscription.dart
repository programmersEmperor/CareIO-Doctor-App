/// id : 1
/// nameAr : "المجانية"
/// nameEn : "Free"

class Subscription {
  Subscription({
    required int id,
    required String nameAr,
    required String nameEn,
  }) {
    _id = id;
    _nameAr = nameAr;
    _nameEn = nameEn;
  }

  Subscription.fromJson(dynamic json) {
    _id = json['id'];
    _nameAr = json['nameAr'];
    _nameEn = json['nameEn'];
  }
  late int _id;
  late String _nameAr;
  late String _nameEn;
  Subscription copyWith({
    required int id,
    required String nameAr,
    required String nameEn,
  }) =>
      Subscription(
        id: id ?? _id,
        nameAr: nameAr ?? _nameAr,
        nameEn: nameEn ?? _nameEn,
      );
  int get id => _id;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nameAr'] = _nameAr;
    map['nameEn'] = _nameEn;
    return map;
  }
}
