import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/home/custom_card.dart';
import 'package:gemini_bot/home/home_controller.dart';

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
      body: Consumer(
        builder: (context, ref, child) {
          final home = ref.watch(lastMessageProvider);
          return home.when(
            error: (error, stackTrace) => ErrorWidget(error),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
            data: (data) => ListView.builder(
              itemCount: 2,
              itemBuilder: (contex, index) => CustomCard(
                index: index,
                home: data,
              ),
            ),
          );
        },
      ),
    );
  }
}
