import 'package:pokemon_explorer/generated/l10n.dart';
import 'package:pokemon_explorer/res/app_res.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AppConfigRepository {
  late SharedPreferences prefs;
  late String userType;
  late String userId;

  void _setUserType(String? userType) async {
    if (userType != null) {
      this.userType = userType;
      await prefs.setString(Constants.kUserType, userType);
    }
  }

  void _setUserId(String? userId) async {
    if (userId != null) {
      this.userId = userId;
      await prefs.setString(Constants.kUserId, userId);
    }
  }

  void setUserData({String? userId, String? userType}) {
    _setUserId(userId);
    _setUserType(userType);
  }

// locale section
  Locale _locale = const Locale('en');
  static const String _languageKey = 'language-key';
  bool _isEnglish = false;
  bool _isRTL = true;

  bool get isEnglish => _isEnglish;

  bool get isRTL => _isRTL;
  late bool _isFirstLaunch;

  Locale get locale => _locale;

  bool get isFirstLaunch => _isFirstLaunch;

  void setLocale(String locale) async {
    _locale = Locale(locale);
    await S.load(Locale(locale));
    _isEnglish = _locale.languageCode == 'en';
    _isRTL = Bidi.isRtlLanguage(_locale.languageCode);
    prefs.setString(_languageKey, locale);
  }

  // initiliaze all requirements
  Future<void> initializeApp() async {
    prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(_languageKey);
    // DEFAULT LANGUAGE CODE
    _locale = Locale(languageCode ?? 'en');
    _isEnglish = _locale.languageCode == 'en';
    _isRTL = Bidi.isRtlLanguage(_locale.languageCode);
    _isFirstLaunch = prefs.getBool(Constants.firstLaunchKey) ?? true;
    userType = prefs.getString(Constants.kUserType) ?? '';
    userId = prefs.getString(Constants.kUserId) ?? Constants.kUserId;
  }

  void setFirstLaunchToFalse() async {
    prefs.setBool(Constants.firstLaunchKey, false);
  }
}
