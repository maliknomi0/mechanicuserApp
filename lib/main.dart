import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair/_Configs/routes.dart';

import 'providers/theme_provider.dart';
import 'themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: "AIzaSyB7qEXGCPl51V7Vh-r54lVq7GJl5YNshXQ");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'repair',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.lightTheme,
      themeMode: themeMode,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
