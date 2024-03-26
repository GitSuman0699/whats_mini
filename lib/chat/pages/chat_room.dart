import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/widgets/chat_room_app_bar.dart';
import 'package:gemini_bot/chat/widgets/chat_room_scaffold.dart';
import 'package:gemini_bot/chat/widgets/input/chat_input_area.dart';
import 'package:gemini_bot/chat/widgets/message_list.dart';
import 'package:gemini_bot/util/share_pref.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  const ChatRoomPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  initializeGemini() {
    Gemini.init(apiKey: Prefs.getString("api_key"));
  }

  @override
  void initState() {
    super.initState();
    initializeGemini();
  }

  @override
  Widget build(BuildContext context) {
    return const ChatRoomScaffold(
      appBar: ChatRoomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: MessageList(),
          ),
          ChatInputArea()
        ],
      ),
    );
  }
}
