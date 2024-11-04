import 'package:flutter/foundation.dart';
import 'package:flutter_declarative_exception_handling/detailed_exception.dart';

class AppState {
  ValueNotifier<DetailedException?> detailedException =
      ValueNotifier<DetailedException?>(null);

  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();
}
