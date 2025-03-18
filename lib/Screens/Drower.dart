import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair/_services/storage.dart';
import 'package:repair/config.dart';

import '../global/globle.dart';
import '../providers/theme_provider.dart';
import '../themes/theme_constants.dart';

class ThemeDrawer extends ConsumerStatefulWidget {
  const ThemeDrawer({super.key});

  @override
  ConsumerState<ThemeDrawer> createState() => _ThemeDrawerState();
}

class _ThemeDrawerState extends ConsumerState<ThemeDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.read(themeProvider.notifier);
    final currentThemeMode = ref.watch(themeProvider);

    return Drawer(
      child: Column(
        children: [
          // Header with user info
          UserAccountsDrawerHeader(
            accountName: Text(
              userSD?["user"]['name'] ?? 'Guest',
              style: const TextStyle(fontSize: 18),
            ),
            accountEmail: Text(
              userSD?["user"]['email'] ?? 'Not available',
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: whiteColor,
              child: Image.network(
                fit: BoxFit.cover,
                '${Configs.baseUrl}${userSD?["user"]["profileImage"] ?? ''}',
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Choose Theme'),
            subtitle: DropdownButton<ThemeMode>(
              value: currentThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  themeNotifier.updateTheme(value);
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              // Perform logout
              await Storage.logout(); // Clear storage
              userSD = null; // Clear global user data
              if (context.mounted) {
                Navigator.pushReplacementNamed(
                    context, '/login'); // Navigate to login
              }
            },
          ),
        ],
      ),
    );
  }
}
