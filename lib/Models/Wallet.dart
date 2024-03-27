import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));
String walletToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
  Wallet({
    int? id,
    String? nameAr,
    String? nameEn,
    String? logo,
  }) {
    _id = id;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _logo = logo;
  }

  Wallet.fromJson(dynamic json) {
    _id = json['id'];
    _nameAr = json['nameAr'];
    _nameEn = json['nameEn'];
    _logo = json['logo'];
  }
  int? _id;
  String? _nameAr;
  String? _nameEn;
  String? _logo;
  RxBool _selected = false.obs;

  int? get id => _id;
  String? get nameAr => _nameAr;
  String? get nameEn => _nameEn;
  String? get logo => _logo;
  RxBool get selected => _selected;
  String get name => Get.locale == const Locale('en', 'US') ? _nameEn ?? "" : _nameAr ?? "";

  set selected(RxBool value) {
    _selected = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nameAr'] = _nameAr;
    map['nameEn'] = _nameEn;
    map['logo'] = _logo;
    return map;
  }
}
