import 'package:flutter/material.dart';
import 'package:repair/themes/theme_constants.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, dynamic>> faqCategories = [
    {
      "category": "Booking & Appointments",
      "questions": [
        {
          "question": "How do I book a notary service?",
          "answer":
              "Go to the 'Services' tab, select Notary Service, choose your provider, and follow the booking steps."
        }
      ]
    },
    {
      "category": "Payments & Refunds",
      "questions": [
        {
          "question": "What payment methods do you accept?",
          "answer": "We accept credit/debit cards, PayPal, and bank transfers."
        }
      ]
    },
    {
      "category": "Legal Service Guidelines",
      "questions": [
        {
          "question": "Are online legal consultations legally valid?",
          "answer":
              "Yes, online legal consultations are valid in most jurisdictions, but it's best to check local regulations."
        }
      ]
    },
    {
      "category": "Account & Profile Management",
      "questions": [
        {
          "question": "How do I update my contact details?",
          "answer": "Go to your profile settings and edit your contact details."
        }
      ]
    },
  ];

  Map<String, bool> expandedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frequently Asked Questions"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: faqCategories.length,
                itemBuilder: (context, index) {
                  return _buildCategory(faqCategories[index]);
                },
              ),
            ),
            SizedBox(height: 20),
            _buildContactUsButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(Map<String, dynamic> category) {
    bool isExpanded = expandedCategories[category["category"]] ?? false;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              expandedCategories[category["category"]] = !isExpanded;
            });
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category["category"],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Column(
            children: category["questions"].map<Widget>((questionData) {
              return _buildQuestionTile(questionData);
            }).toList(),
          ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildQuestionTile(Map<String, String> questionData) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionData["question"]!,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          SizedBox(height: 6),
          Text(
            questionData["answer"]!,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildContactUsButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: Text(
            "Still need help? Contact Us",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
