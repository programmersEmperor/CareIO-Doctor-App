import 'dart:convert';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;


Notification notificationFromJson(String str) =>
    Notification.fromJson(json.decode(str));
String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  Notification({
    int? id,
    String? titleAr,
    String? titleEn,
    String? bodyAr,
    String? bodyEn,
    String? createdAt,
    bool? isRead,
  }) {
    _id = id;
    _titleAr = titleAr;
    _titleEn = titleEn;
    _bodyAr = bodyAr;
    _bodyEn = bodyEn;
    _createdAt = createdAt;
    _isRead = isRead;
  }

  Notification.fromJson(dynamic json) {
    _id = json['id'];
    _titleAr = json['titleAr'];
    _titleEn = json['titleEn'];
    _bodyAr = json['bodyAr'];
    _bodyEn = json['bodyEn'];
    _createdAt = json['createdAt'];
    _isRead = json['isRead'] == 1;
  }
  int? _id;
  String? _titleAr;
  String? _titleEn;
  String? _bodyAr;
  String? _bodyEn;
  String? _createdAt;
  bool? _isRead;

  int? get id => _id;
  String? get title => Get.locale.toString() == 'ar_AR' ? _titleAr: _titleEn;
  String? get body => Get.locale.toString() == 'ar_AR' ? _bodyAr: _bodyEn;
  String? get createdAt => _createdAt == null
      ? null
      : Get.locale.toString() == 'ar_AR'
        ? timeago.format(DateTime.parse(_createdAt!), locale: 'ar')
        : timeago.format(DateTime.parse(_createdAt!), locale: 'en');

  bool get isRead => _isRead ?? false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['titleAr'] = _titleAr;
    map['titleEn'] = _titleEn;
    map['bodyAr'] = _bodyAr;
    map['bodyEn'] = _bodyEn;
    map['createdAt'] = _createdAt;
    map['isRead'] = _isRead;
    return map;
  }
}
