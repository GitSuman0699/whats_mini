import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_bot/chat/pages/chat_room.dart';
import 'package:gemini_bot/constants.dart';
import 'package:gemini_bot/functions.dart';
import 'package:gemini_bot/home/home_controller.dart';

class CustomCard extends StatelessWidget {
  final int index;
  final HomeModel? home;
  const CustomCard({super.key, required this.index, this.home});

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
                    ),
                  ),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contex) => ChatRoomPage(
                      isOneOnOne: false,
                    ),
                  ),
                );
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
                  // Visibility(
                  //   visible: home != null &&  ,
                  //   child: Icon(
                  //     Icons.done_all,
                  //     size: 16,
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 3,
                  // ),
                  Expanded(
                    child: Text(
                      index == 0
                          ? home?.oneToOne?.message ?? "Start now"
                          : home?.chat?.message ?? "Start now",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: index == 0
                  ? home?.oneToOne != null
                      ? Text(convert24to12(dateTime: home!.oneToOne!.sentTime))
                      : Text("")
                  : home?.chat != null
                      ? Text(convert24to12(dateTime: home!.chat!.sentTime))
                      : Text(""),
            )
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
