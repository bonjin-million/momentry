import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeStateNotifier, ThemeMode>((ref) {
  return ThemeStateNotifier();
});

class ThemeStateNotifier extends StateNotifier<ThemeMode> {
  ThemeStateNotifier() : super(ThemeMode.system) {
    init();
  }

  void init() async {
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString('themeMode');
    final mode = ThemeMode.values.firstWhereOrNull((e) => e.name == name);
    setMode(mode ?? ThemeMode.system);
  }

  bool get isDarkMode => state == ThemeMode.dark || state == ThemeMode.system && SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  void setMode(ThemeMode? mode) async {
    if(mode == null) {
      state = ThemeMode.system;
      return;
    }
    state = mode;
    final pref = await SharedPreferences.getInstance();
    await pref.setString('themeMode', mode.name);
  }
}