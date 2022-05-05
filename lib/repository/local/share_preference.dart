import 'package:bloc_platform/repository/local/preference.dart';
import 'package:flutter/foundation.dart';

abstract class SharePreference {
  @protected
  String get packageName;

  @protected
  Preferences? _preferences;
}