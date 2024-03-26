import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/model/chat_model.dart';
import 'package:gemini_bot/chat/widgets/bubble/image_bubble.dart';
import 'package:gemini_bot/theme.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatImageBubble extends ConsumerWidget {
  final ChatModel model;
  final bool isDark;
  final bool isMessageSender;
  const ChatImageBubble({
    Key? key,
    required this.model,
    required this.isDark,
    required this.isMessageSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwipeTo(
      offsetDx: 0.16,
      child: ImageBubble(
        isDark: isDark,
        isSender: isMessageSender,
        tail: false,
        color: isDark
            ? kPrimaryColor
            : kPrimaryColor.withOpacity(0.4).withAlpha(120).withGreen(165),
        image: Column(
          children: [
            Image.file(
              height: 300,
              width: MediaQuery.of(context).size.width,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  "This image is no longer available.",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: isDark ? Colors.grey : Colors.grey[600]),
                );
              },
              File(model.photo!),
              fit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 4),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(model.message!),
                ),
              ),
            ),
          ],
        ),
        model: model,
      ),
    );
  }
}
