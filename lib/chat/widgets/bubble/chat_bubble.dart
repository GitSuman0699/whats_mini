import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/model/chat_model.dart';
import 'package:gemini_bot/chat/widgets/bubble/chat_bubble_bottom.dart';
import 'package:gemini_bot/functions.dart';
import 'package:gemini_bot/message%20copy.dart';
import 'package:gemini_bot/model/multi_chat_model.dart';
import 'package:gemini_bot/theme.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatBubble extends ConsumerWidget {
  final bool isSenderMessage;
  final ChatModel? model;
  final MultiChatModel? multiChatModel;

  final Widget? child;
  const ChatBubble({
    Key? key,
    required this.isSenderMessage,
    this.child,
    this.model,
    this.multiChatModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkEnabled = ref.watch(themeNotifierProvider) == Brightness.dark;

    final darkBubbleColor =
        isSenderMessage ? kSenderMessageColorDark : kReceiverMessageColorDark;
    final lightBubbleColor =
        isSenderMessage ? kSenderMessageColorLight : Colors.white;
    final alignment = isSenderMessage ? Alignment.topRight : Alignment.topLeft;
    final nip = isSenderMessage ? BubbleNip.rightTop : BubbleNip.leftTop;

    final margin = isSenderMessage
        ? const BubbleEdges.only(top: 5, left: 50, right: 10, bottom: 10)
        : const BubbleEdges.only(top: 5, right: 50, left: 10, bottom: 10);
    return SwipeTo(
      offsetDx: 0.16,
      animationDuration: const Duration(milliseconds: 85),
      child: InkWell(
        onLongPress: () {
          copyText(model?.message?.trim() ?? multiChatModel!.message!.trim(),
              context);
        },
        child: Bubble(
          margin: margin,
          alignment: alignment,
          radius: const Radius.circular(12),
          padding: const BubbleEdges.only(left: 8, right: 8, top: 3, bottom: 6),
          nip: nip,
          showNip: true,
          borderWidth: 0.7,
          borderColor:
              isDarkEnabled ? Colors.grey.shade800 : Colors.grey.shade400,
          color: isDarkEnabled ? darkBubbleColor : lightBubbleColor,
          borderUp: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
              minWidth: 75,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      (model?.sender ?? multiChatModel!.sender) == Sender.bot
                          ? Markdown(
                              padding: const EdgeInsets.all(0),
                              data: model?.message ?? multiChatModel!.message!,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            )
                          : Text(model?.message ?? multiChatModel!.message!),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ChatBubbleBottom(
                    model: model,
                    multiChatModel: multiChatModel,
                    isDark: isDarkEnabled,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
