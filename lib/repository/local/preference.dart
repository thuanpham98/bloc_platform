import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Preferences {
  static SharedPreferences? _preferences;
  static FlutterSecureStorage? _securityPreferences;

  Preferences._() {
    initPreferences();
  }
  static Preferences get instance => Preferences._();

  @mustCallSuper
  Future<void> initPreferences() async {
    scheduleMicrotask(() async {
      _preferences ??= await SharedPreferences.getInstance();
      _securityPreferences ??= const FlutterSecureStorage();
    });
  }

  Future<String?> getSecuStringKey(String key) async {
    final ret = _securityPreferences?.read(key: key);
    return Future.value(ret);
  }

  Future<void> deleteSecuKeyValue(String key) async {
    return await _securityPreferences?.delete(key: key);
  }

  Future<void> deleteAllSecu() async {
    return await _securityPreferences?.deleteAll();
  }

  Future<void> setSecuStringKey(String key, String value) async {
    return _securityPreferences?.write(key: key, value: value);
  }

  dynamic getKey<T>(String key) {
    final preferences = _preferences;
    if (preferences == null) {
      throw ArgumentError.notNull("call initPreferences before use");
    }
    if (T == String) {
      return preferences.getString(key);
    }
    if (T == bool) {
      return preferences.getBool(key);
    }
    if (T == double) {
      return preferences.getDouble(key);
    }
    if (T == int) {
      return preferences.getInt(key);
    }
    if (T == List<String>) {
      return preferences.getStringList(key);
    }
    if (T == Map) {
      final value = preferences.getString(key) ?? "{}";
      return jsonDecode(value);
    }
    throw FormatException("Not supported", T.runtimeType);
  }

  void setKey<T>(String key, T value) {
    final preferences = _preferences;
    if (preferences == null) {
      throw ArgumentError.notNull("call initPreferences before use");
    }
    if (value is String) {
      preferences.setString(key, value);
    } else if (value is bool) {
      preferences.setBool(key, value);
    } else if (value is double) {
      preferences.setDouble(key, value);
    } else if (value is int) {
      preferences.setInt(key, value);
    } else if (value is List<String>) {
      preferences.setStringList(key, value);
    } else if (value is Map) {
      final _value = jsonEncode(value);
      preferences.setString(key, _value);
    } else {
      throw FormatException("Not supported", T.runtimeType);
    }
  }
}
