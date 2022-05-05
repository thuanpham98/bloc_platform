import 'package:bloc_platform/repository/local/share_preference.dart';
import 'package:bloc_platform/repository/remote/remote.dart';
import 'package:flutter/foundation.dart';

abstract class Repository{
  @protected
  Remote? remote;

  @protected
  SharePreference? sharePreference;
}