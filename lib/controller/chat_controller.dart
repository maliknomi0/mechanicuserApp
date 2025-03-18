import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class ChatController {
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, dynamic>> messages =
      []; // Message can be text or image
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();

  // Function: Send Message & Get AI Response
  Future<void> sendMessage(Function updateUI) async {
    String userMessage = messageController.text.trim();
    if (userMessage.isEmpty) return;

    messages.add({"role": "user", "text": userMessage});
    isLoading = true;
    updateUI(); // UI Update Karega

    messageController.clear();

    try {
      final gemini = Gemini.instance;
      final response = await gemini.prompt(parts: [
        Part.text(
            "You are an AI expert in mechanic & vehicle repair. Only answer queries related to this topic."),
        Part.text(userMessage),
      ]);

      messages.add({
        "role": "bot",
        "text": response?.output ??
            "I can only answer mechanic & vehicle repair-related queries."
      });
    } catch (e) {
      messages.add({"role": "bot", "text": "Error: $e"});
    }

    isLoading = false;
    updateUI(); // UI Dobara Update Karega
  }

  // Function: Send Image for Analysis
  Future<void> sendImage(File imageFile, Function updateUI) async {
    messages.add({"role": "user", "image": imageFile});
    isLoading = true;
    updateUI();

    try {
      final gemini = Gemini.instance;
      final bytes = await imageFile.readAsBytes();

      final response = await gemini.textAndImage(
        text: "Analyze this image related to vehicle repairing.",
        images: [bytes],
      );

      messages.add(
          {"role": "bot", "text": response?.output ?? "No response received."});
    } catch (e) {
      messages.add({"role": "bot", "text": "Error analyzing image: $e"});
    }

    isLoading = false;
    updateUI();
  }

  // Function: Pick Image from Gallery or Camera
  Future<void> pickImage(Function updateUI) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      sendImage(File(pickedFile.path), updateUI);
    }
  }

  // Function: Clear Chat History
  void clearChat(Function updateUI) {
    messages.clear();
    updateUI();
  }
}
