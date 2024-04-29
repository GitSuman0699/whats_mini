import 'package:flutter/material.dart';
import 'package:gemini_bot/chat/pages/chat_room.dart';
import 'package:gemini_bot/constants.dart';

class CustomCard extends StatelessWidget {
  final int index;
  const CustomCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          index == 0
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => ChatRoomPage(
                            isOneOnOne: true,
                          )))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => ChatRoomPage(
                            isOneOnOne: false,
                          )));
        },
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.withOpacity(0.2),
                backgroundImage: AssetImage("assets/img/gemini_logo.jpg"),
              ),
              title: Text(
                index == 0 ? oneToOneChat : chat,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Row(
                children: [
                  Icon(Icons.done_all),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "last message",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              trailing: Text("time"),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 20, left: 80),
            //   child: Divider(
            //     thickness: 1,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
