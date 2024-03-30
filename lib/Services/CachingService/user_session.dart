import 'dart:convert';

import 'package:careio_doctor_version/Localization/localization_helper.dart';
import 'package:careio_doctor_version/Models/Degree.dart';
import 'package:careio_doctor_version/Models/DoctorDetails.dart';
import 'package:careio_doctor_version/Models/Plan.dart';
import 'package:careio_doctor_version/Models/Specialism.dart';
import 'package:careio_doctor_version/Models/Wallet.dart';
import 'package:careio_doctor_version/Models/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UserSession {
  static const _doctorBox = 'doctorBox';
  static const _doctorKey = 'doctorKey';
  static const _tokenKey = 'tokenKey';
  static const _localeKey = 'localeKey';
  // static const _openedChatKey = 'openedChatKey';
  String firebaseDeviceToken = '';

  String token = '';
  late DoctorDetails doctorUser;
  List<Wallet> wallets = [];
  List<Specialism> specializations = [];
  List<Degree> degrees = [];
  late Box box;
  bool userOpenedChat = false;

  Future<bool> saveDoctorUser(Map<String, dynamic> data) async {
    box = await Hive.openBox(_doctorBox);
    if (!box.isOpen) return false;

    doctorUser = DoctorDetails.fromJson(data['doctor']);
    await box.put(_doctorKey, jsonEncode(data['doctor']));

    token = data['token'];
    await box.put(_tokenKey, token);
    await box.close();

    debugPrint("token ${data['token']}");
    debugPrint("UserPhone is ${doctorUser.phone}");

    return true;
  }

  Future<void> updateDoctorUser() async {
    box = await Hive.openBox(_doctorBox);
    if (!box.isOpen) return;

    await box.put(_doctorKey, jsonEncode(doctorUser));
    await box.close();
    debugPrint("Doctor name is ${doctorUser.name}");
  }

  Future<bool> getDoctorUser() async {
    box = await Hive.openBox(_doctorBox);
    if (!box.isOpen || box.isEmpty) return false;

    token = await box.get(_tokenKey);
    doctorUser = DoctorDetails.fromJson(jsonDecode(await box.get(_doctorKey)));

    debugPrint("Token is $token");
    debugPrint("Doctor is ${doctorUser.toJson()}");

    await box.close();
    return true;
  }

  Future<bool> logout() async {
    try {
      box = await Hive.openBox(_doctorBox);
      if (!box.isOpen) return false;
      box.clear();
      await box.close();
      return true;
    } catch (e) {
      debugPrint("logout error $e");
      return false;
    }
  }

  void saveLocale(Locale locale) async {
    box = await Hive.openBox(_doctorBox);
    if (!box.isOpen) return;
    await box.put(_localeKey, locale.languageCode);
    debugPrint("Locale ${locale.languageCode} is Saved");
    box.close();
  }

  Future<Locale> getLocale() async {
    box = await Hive.openBox(_doctorBox);
    if (!box.isOpen || box.isEmpty) return Get.deviceLocale!;
    var langCode = await box.get(_localeKey);
    debugPrint("Locale $langCode retrieved from cache");
    return langCode == "ar"
        ? LocalizationHelper.locales[1]
        : LocalizationHelper.locales[0];
  }
}
