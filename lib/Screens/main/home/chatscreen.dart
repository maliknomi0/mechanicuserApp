import 'package:flutter/material.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/themes/theme_constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(AppIamges.mechanic),
              ),
              SizedBox(width: 10),
              Text(
                "Hammad Miran",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Icon(
              Icons.call,
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  ChatBubble(sender: true, receiver: "Hi how are you..."),
                  ChatBubble(
                      sender: false, receiver: "I am fine dude how are you..."),
                  ChatBubble(sender: true, receiver: "Sounds good"),
                  ChatBubble(
                      sender: false, receiver: "What are you doing now..."),
                  ChatBubble(sender: true, receiver: "Just coding bro"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white24),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Message",
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.file_present_rounded,
                          ),
                          onPressed: () {},
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool sender;
  final String receiver;

  const ChatBubble({super.key, required this.sender, required this.receiver});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: sender ? primaryColor : grayColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          receiver,
          style: TextStyle(color: sender ? whiteColor : blackColor),
        ),
      ),
    );
  }
}
