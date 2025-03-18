import 'package:flutter/material.dart';

import '../themes/theme_constants.dart';

class AppBarButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;

  const AppBarButton({
    super.key,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Default padding for the button
      child: GestureDetector(
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        child: Container(
          height: 35, // Set a smaller fixed height
          width: 35, // Set a smaller fixed width
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // Circular button
            color: lightPrimaryColor,
          ),
          child: Icon(
            icon ??
                Icons.arrow_back, // Default to arrow_back if no icon is passed
            color: whiteColor, // Icon color
            size: 16, // Smaller icon size to match the button
          ),
        ),
      ),
    );
  }
}
