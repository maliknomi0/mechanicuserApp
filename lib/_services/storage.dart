import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storageServiceProvider = Provider<Storage>((ref) => Storage());
FlutterSecureStorage storage = const FlutterSecureStorage();

class Storage {
  final _storage = const FlutterSecureStorage();

  static Future<bool> setLogin(dynamic data) async {
    await storage.write(key: 'user', value: jsonEncode(data));
    return true;
  }

  static Future<dynamic> getLogin() async {
    String? value = await storage.read(key: 'user');
    if (value != null) {
      return jsonDecode(value);
    }
    return false;
  }

  static Future<bool> setToken(String token) async {
    await storage.write(key: 'token', value: token);
    return true;
  }

  static Future<String> getToken() async {
    String? value = await storage.read(key: 'token');
    if (value != null) {
      return value;
    }
    return '';
  }

  static Future<bool> logout() async {
    await storage.deleteAll();
    return true;
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await _storage.write(key: 'themeMode', value: mode.toString());
  }

  Future<ThemeMode?> getThemeMode() async {
    final mode = await _storage.read(key: 'themeMode');
    switch (mode) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
