import 'package:flutter/material.dart';
import 'package:gemini_bot/home/custom_card.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    super.key,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (contex, index) => CustomCard(
          index: index,
        ),
      ),
    );
  }
}
