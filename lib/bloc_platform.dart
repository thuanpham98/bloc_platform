library bloc_platform;

import 'package:bloc_platform/repository/repository.dart';
import 'package:bloc_platform/session/session.dart';

/// [Bloc].
abstract class Bloc {
  Session? session;
  Repository? repository;
  Future<void> init();
  Future<void> dispose();
}