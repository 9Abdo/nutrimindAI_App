import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState {
  final ThemeMode themeMode;
  const ThemeState({required this.themeMode});

  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class ThemeCubit extends Cubit<ThemeState> {
  static const String _prefKey = 'app_theme_mode';

  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.light)) {
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMode = prefs.getString(_prefKey);
      if (savedMode == 'dark') {
        emit(const ThemeState(themeMode: ThemeMode.dark));
      } else if (savedMode == 'system') {
        emit(const ThemeState(themeMode: ThemeMode.system));
      } else {
        emit(const ThemeState(themeMode: ThemeMode.light));
      }
    } catch (_) {
      emit(const ThemeState(themeMode: ThemeMode.light));
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(ThemeState(themeMode: mode));
    try {
      final prefs = await SharedPreferences.getInstance();
      String value = 'light';
      if (mode == ThemeMode.dark) value = 'dark';
      if (mode == ThemeMode.system) value = 'system';
      await prefs.setString(_prefKey, value);
    } catch (_) {}
  }

  Future<void> toggleTheme() async {
    if (state.themeMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      await setThemeMode(ThemeMode.dark);
    }
  }
}
