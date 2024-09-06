import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


import '../strings/enum_manager.dart';

class AppSharedPreference {
  static late SharedPreferences _prefs;

  static const _token = '1';
  static const _phoneNumber = '2';
  static const _fireToken = '3';
  static const _lang = '4';
  static const _screenType = '5';
  static const _user = '6';
  static const _isShowIntro = '7';
  static const _resendTime = '8';


  static Future<void> setResendDateTime(int s) async {
    final d = DateTime.now().add(Duration(seconds: s));
    await _prefs.setString(_resendTime, d.toIso8601String());
  }

  static DateTime get getResendDateTime =>
      DateTime.tryParse(_prefs.getString(_resendTime) ?? '') ?? DateTime.now();

  static init(SharedPreferences preferences) async {
    _prefs = preferences;
  }

  static cashToken(String? token) {
    if (token == null) return;
    _prefs.setString(_token, token);
  }

  static String get getToken => _prefs.getString(_token) ?? '';


  static void cashFireToken(String token) {
    _prefs.setString(_fireToken, token);
  }

  static String get getFireToken => _prefs.getString(_fireToken) ?? '';

  static cashPhone(String? phone) async {
    if (phone == null) return;
    await _prefs.setString(_phoneNumber, phone);
  }

  static String get getPhone {
    return _prefs.getString(_phoneNumber) ?? '';
  }

  static Future<void> cashShowIntro() async {
    await _prefs.setBool(_isShowIntro, true);
  }

  static bool get isShowIntro {
    return _prefs.getBool(_isShowIntro) ?? false;
  }

  static Future<void> removePhone() async {
    await _prefs.remove(_phoneNumber);
  }

  static cashStartPage(StartPage type) async {
    await _prefs.setInt(_screenType, type.index);
  }

  static StartPage get getStartPage =>
      StartPage.values[_prefs.getInt(_screenType) ?? 0];

  static Future<void> clear() async => await _prefs.clear();

  static Future<void> logout() async => await _prefs.clear();

  static Future<void> cashLocal(String langCode) async {
    await _prefs.setString(_lang, langCode);
  }

  static String get getLocal => _prefs.getString(_lang) ?? 'en';
}
