import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name;
  ChatScreen({required this.chatWithUsername, required this.name});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
    );
  }
}
