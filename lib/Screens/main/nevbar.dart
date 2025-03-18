import 'package:flutter/material.dart';
import 'package:repair/Screens/main/Chatbot/ChatBotScreen.dart';
import 'package:repair/Screens/main/home/HomeScreen.dart';
import 'package:repair/Screens/main/profile/profile.dart';
import 'package:repair/Screens/main/pumpmap/pumpScreen.dart';
import 'package:repair/Screens/main/videos/vidoes.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/themes/theme_constants.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    pumpmapScreen(),
    ChatBotScreen(),
    VideosScreen(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color inactiveIconColor = inactiveTextFieldColor;
    Color activeIconColor = lightPrimaryColor;

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isDarkMode ? darkBackgroundColor : lightBackgroundColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(blurRadius: 0.1, color: inactiveTextFieldColor),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(
                  AppIamges.homeIcon, 0, activeIconColor, inactiveIconColor),
              _buildNavItem(
                  AppIamges.pumpIcon, 1, activeIconColor, inactiveIconColor),
              _buildNavItem(
                  AppIamges.chatbotIcon, 2, activeIconColor, inactiveIconColor),
              _buildNavItem(
                  AppIamges.videoIcon, 3, activeIconColor, inactiveIconColor),
              _buildNavItem(
                  AppIamges.profileIcon, 4, activeIconColor, inactiveIconColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      String icon, int index, Color activeIconColor, Color inactiveIconColor) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                icon,
                color: isSelected ? activeIconColor : inactiveIconColor,
                height: isSelected ? 28 : 26,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: isSelected ? 6 : 0,
            width: isSelected ? 6 : 0,
            decoration: BoxDecoration(
              color: isSelected ? activeIconColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
