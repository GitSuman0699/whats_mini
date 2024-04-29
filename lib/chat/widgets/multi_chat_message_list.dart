import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/controller/chat_controller.dart';
import 'package:gemini_bot/chat/controller/chats_controller.dart';
import 'package:gemini_bot/chat/controller/multi_chat_controller.dart';
import 'package:gemini_bot/chat/widgets/bubble/chat_bubble.dart';
import 'package:gemini_bot/chat/widgets/bubble/chat_image_bubble.dart';
import 'package:gemini_bot/message%20copy.dart';
import 'package:gemini_bot/theme.dart';

class MultiChatMessageList extends ConsumerStatefulWidget {
  const MultiChatMessageList({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiChatChatMessagesState();
}

class _MultiChatChatMessagesState extends ConsumerState<MultiChatMessageList> {
  final ScrollController scroll = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   scroll.addListener(() {
  //     if (scroll.position.pixels == scroll.position.minScrollExtent) {
  //       print("yes");
  //       if (ref.read(chatProvider1.notifier).page <=
  //           ref.read(chatProvider1.notifier).totalPage) {
  //         // ref.read(chatProvider1.notifier).page++;
  //         ref.invalidate(chatProvider1)();
  //       }
  //     }
  //   });
  // }

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider) == Brightness.dark;
    final message = ref.watch(multiChatProvider);

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
              duration: const Duration(milliseconds: 50),
              curve: Curves.fastEaseInToSlowEaseOut,
            );
          }
        });
        // }

        return SingleChildScrollView(
          controller: scroll,
          child: ListView.builder(
            // reverse: true,
            itemCount: data.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatBubble(
                isSenderMessage:
                    data[index].sender == Sender.user ? true : false,
                multiChatModel: data[index],
              );
            },
          ),
        );
      },
    );
  }
}
