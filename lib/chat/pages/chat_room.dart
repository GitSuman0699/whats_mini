import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/widgets/chat_room_app_bar.dart';
import 'package:gemini_bot/chat/widgets/chat_room_scaffold.dart';
import 'package:gemini_bot/chat/widgets/input/chat_input_area.dart';
import 'package:gemini_bot/chat/widgets/message_list.dart';
import 'package:gemini_bot/chat/widgets/multi_chat_message_list.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  final bool isOneOnOne;
  const ChatRoomPage({
    super.key,
    required this.isOneOnOne,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChatRoomScaffold(
      appBar: ChatRoomAppBar(
        isOneOnOne: widget.isOneOnOne,
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.isOneOnOne ? MessageList() : MultiChatMessageList(),
          ),
          ChatInputArea(
            isOneOnOne: widget.isOneOnOne,
          )
        ],
      ),
    );
  }
}
