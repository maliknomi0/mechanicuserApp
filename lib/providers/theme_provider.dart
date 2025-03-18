import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair/_services/storage.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(ref),
);

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref ref;

  ThemeNotifier(this.ref) : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final theme = await ref.read(storageServiceProvider).getThemeMode();
    state = theme ?? ThemeMode.system;
  }

  void updateTheme(ThemeMode mode) {
    state = mode;
    ref.read(storageServiceProvider).saveThemeMode(mode);
  }
}
