import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/controller/chat_controller.dart';
import 'package:gemini_bot/chat/widgets/bubble/chat_bubble.dart';
import 'package:gemini_bot/chat/widgets/bubble/chat_image_bubble.dart';
import 'package:gemini_bot/message%20copy.dart';
import 'package:gemini_bot/theme.dart';

class MessageList extends ConsumerStatefulWidget {
  const MessageList({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends ConsumerState<MessageList> {
  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    // scroll.addListener(() {
    //   if (scroll.position.pixels == scroll.position.minScrollExtent) {
    //     print("yes");
    //     if (ref.read(chatProvider.notifier).page <=
    //         ref.read(chatProvider.notifier).totalPage) {
    //       ref.read(chatProvider.notifier).page++;
    //       ref.watch(chatProvider.notifier).getMessages();
    //     } else {
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(SnackBar(content: Text('No more messages')));
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider) == Brightness.dark;
    final message = ref.watch(chatProvider);

    return message.when(
      error: (error, stackTrace) => ErrorWidget(error),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text('Start your conversation'),
          );
        }
        // if (ref.read(chatProvider.notifier).page == 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scroll.hasClients) {
            scroll.animateTo(
              scroll.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.fastEaseInToSlowEaseOut,
            );
          }
        });
        // }

        return SingleChildScrollView(
          controller: scroll,
          child: ListView.builder(
            reverse: true,
            itemCount: data.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return switch (data[index].messageType) {
                MessageType.image => ChatImageBubble(
                    model: data[index],
                    isDark: isDark,
                    isMessageSender:
                        data[index].sender == Sender.user ? true : false,
                  ),
                _ => ChatBubble(
                    isSenderMessage:
                        data[index].sender == Sender.user ? true : false,
                    model: data[index],
                  ),
              };
            },
          ),
        );
      },
    );
  }
}
