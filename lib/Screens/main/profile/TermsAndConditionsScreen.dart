import 'package:flutter/material.dart';
import 'package:repair/themes/theme_constants.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  TermsAndConditionsScreen({super.key});
  final List<Map<String, dynamic>> termsAndConditions = [
    {
      "lastUpdate": "27 / 03 / 2023", // Dynamic last update date
      "topText":
          "Welcome to Sertify, a digital platform connecting users with legal and notary service providers in the UAE. By using our app, you agree to the following terms and conditions. Please read them carefully before proceeding.",
      "bulletPoints": [
        "You must provide accurate and up-to-date information when registering and using the app.",
        "Misuse of services, including fraudulent requests or false information, is strictly prohibited.",
        "Client information must be kept confidential and secure in compliance with UAE regulations.",
      ],
      "endText":
          "\nUsers can book services via the app and make payments using Credit/Debit Cards, Apple Pay, or Google Pay.\nPayments are processed securely, and Sertify does not store sensitive financial details.",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final termsData = termsAndConditions[0]; // Accessing first index data

    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLastUpdateCard(termsData["lastUpdate"]),
              const SizedBox(height: 15),

              // Dynamic Top Text
              Text(
                termsData["topText"],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 12),

              // Dynamic Bullet Points
              for (String point in termsData["bulletPoints"])
                _buildBulletPoint(point),

              // Dynamic End Text
              Text(
                termsData["endText"],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dynamic Last Update Date Card
  Widget _buildLastUpdateCard(String lastUpdate) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Last Update : ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              lastUpdate,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bullet Point List Item
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(Icons.circle, size: 6, color: primaryColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
