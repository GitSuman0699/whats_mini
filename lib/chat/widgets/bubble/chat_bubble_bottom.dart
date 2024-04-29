// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gemini_bot/model/chat_model.dart';
import 'package:gemini_bot/functions.dart';
import 'package:gemini_bot/message%20copy.dart';
import 'package:gemini_bot/model/multi_chat_model.dart';

class ChatBubbleBottom extends StatelessWidget {
  final ChatModel? model;
  final MultiChatModel? multiChatModel;
  final bool isDark;
  const ChatBubbleBottom({
    Key? key,
    this.model,
    required this.isDark,
    this.multiChatModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontColor = isDark ? Colors.grey.shade400 : Colors.grey.shade700;
    const double fontSize = 12;
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          convert24to12(dateTime: model?.sentTime ?? multiChatModel!.sentTime),
          style: TextStyle(
            fontSize: fontSize,
            color: fontColor,
          ),
        ),
        const SizedBox(width: 5),
        if (model?.isRead ?? multiChatModel!.isRead) ...{
          const SizedBox(height: 5),
          (model?.sender ?? multiChatModel!.sender) == Sender.bot
              ? const SizedBox.shrink()
              : const Icon(
                  Icons.done_all,
                  size: 18,
                  color: Colors.blue,
                ),
        } else ...{
          const SizedBox(height: 5),
          const Icon(
            Icons.done_all,
            size: 18,
            color: Colors.grey,
          ),
        }
      ],
    );
  }
}
