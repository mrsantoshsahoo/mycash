import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceHelper {
  static SharedPreferences? _sharedPreference;

  static void init(SharedPreferences preferences) {
    _sharedPreference = preferences;
  }

  static Future<void> forceInit() async {
    _sharedPreference =  await SharedPreferences.getInstance();
  }

  static void delete() {
    _sharedPreference?.clear();
  }

  static Future<String?> getString(String key) async {
    return _sharedPreference?.getString(key);
  }

  static Future<int?> getInt(String key) async {
    return _sharedPreference?.getInt(key);
  }
  static Future<double?> getDouble(String key) async {
    return _sharedPreference?.getDouble(key);
  }

  static Future<Future<bool>?> saveString(String key, String value) async {
    return _sharedPreference?.setString(key, value);
  }
  static Future<Future<bool>?> saveBool(String key, bool value) async {
    return _sharedPreference?.setBool(key, value);
  }

  static Future<Future<bool>?> saveInt(String key, int value) async {
    return _sharedPreference?.setInt(key, value);
  }
  static Future<Future<bool>?> saveDouble(String key, double value) async {
    return _sharedPreference?.setDouble(key, value);
  }

  static Future<bool?> getBool(String key) async {
    return _sharedPreference?.getBool(key);
  }
  static Future<bool?> get isLoggedIn async {
    bool? loggedIn = await getBool("islogin");
    return loggedIn != null && loggedIn;
  }
}