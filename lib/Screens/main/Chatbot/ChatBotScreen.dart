import 'package:flutter/material.dart';
import 'package:repair/controller/chat_controller.dart';
import 'package:repair/themes/theme_constants.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final ChatController chatController = ChatController();

  // UI Update Function
  void updateUI() {
    setState(() {});
  }

  // Clear Chat Confirmation Dialog
  void _confirmClearChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Clear Chat"),
        content: Text("Are you sure you want to clear the chat history?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              chatController.clearChat(updateUI);
              Navigator.pop(context);
            },
            child: Text("Clear", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mechanic Chatbot"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: _confirmClearChat,
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: chatController.messages.length,
              itemBuilder: (context, index) {
                final message = chatController.messages[index];
                bool isUser = message["role"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isUser ? 12 : 0),
                        topRight: Radius.circular(isUser ? 0 : 12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: blackColor.withOpacity(.3),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: message.containsKey("image")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(message["image"], width: 200),
                          )
                        : Text(
                            message["text"] ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              color: isUser ? blackColor : blackColor,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),

          // Typing Indicator
          if (chatController.isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    "Chatbot is typing...",
                    style: TextStyle(
                      fontSize: 14,
                      color: grayColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(width: 8),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),

          // Message Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.image,
                  ),
                  onPressed: () => chatController.pickImage(updateUI),
                ),
                Expanded(
                  child: TextField(
                    controller: chatController.messageController,
                    decoration: InputDecoration(
                      hintText: "Ask about vehicle repair...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () => chatController.sendMessage(updateUI),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
