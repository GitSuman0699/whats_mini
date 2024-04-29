// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/controller/chat_controller.dart';
import 'package:gemini_bot/chat/controller/chats_controller.dart';
import 'package:gemini_bot/constants.dart';
import 'package:gemini_bot/dialog_components.dart';
import 'package:gemini_bot/theme.dart';

class ChatRoomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool isOneOnOne;
  const ChatRoomAppBar({
    Key? key,
    required this.isOneOnOne,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: true,
      leadingWidth: 20.0,
      title: _OneToOneChatAppBar(
        roomAvatar: "assets/img/gemini_logo.jpg",
        roomName: isOneOnOne ? oneToOneChat : chat,
      ),
      actions: [
        InkWell(
          onTap: () async {
            AlertAction? action = await DialogComponents.confirmDialog(
                context, '''Are you sure?\nYou want to clear chat''');

            if (action == AlertAction.ok) {
              ref.read(chatProvider1.notifier).newChat(ref);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              label: Text("New Chat"),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _OneToOneChatAppBar extends ConsumerWidget {
  final String roomAvatar;
  final String roomName;
  const _OneToOneChatAppBar({
    required this.roomAvatar,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.2),
            backgroundImage: AssetImage(roomAvatar),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              roomName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: themeNotifier == Brightness.light
                    ? kLightTextFieldBgColor
                    : kUnselectedLabelColor,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              ref.watch(isLoadingProvider) ? "Typing..." : "Online",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: themeNotifier == Brightness.light
                    ? kLightTextFieldBgColor
                    : kUnselectedLabelColor,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}

// class _GroupChatAppBar extends StatelessWidget {
//   final String roomAvatar;
//   final String roomName;
//   const _GroupChatAppBar({
//     Key? key,
//     required this.roomAvatar,
//     required this.roomName,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(right: 15.0),
//           child: CircleAvatar(
//             backgroundColor: Colors.grey.withOpacity(0.2),
//             backgroundImage: NetworkImage(roomAvatar),
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(roomName),
//             const Padding(
//               padding: EdgeInsets.only(left: 2.0, top: 5),
//               child: Text(
//                 "Tap here for group info",
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
