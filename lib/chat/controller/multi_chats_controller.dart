import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/controller/chat_controller.dart';
import 'package:gemini_bot/dialog_components.dart';
import 'package:gemini_bot/gemini_service/gemini_service.dart';
import 'package:gemini_bot/home/home_controller.dart';
import 'package:gemini_bot/isar_helper.dart';
import 'package:gemini_bot/message%20copy.dart';
import 'package:gemini_bot/model/multi_chat_model.dart';
import 'package:isar/isar.dart';

final multiChatsProvider =
    StateNotifierProvider<MultiChats, AsyncValue<List<MultiChatModel>>>((ref) {
  return MultiChats();
});

class MultiChats extends StateNotifier<AsyncValue<List<MultiChatModel>>> {
  final gemini = GeminiService.instance.gemini;
  List<Content> contentList = [];
  MultiChats() : super(AsyncValue.loading()) {
    getChatMessages();
  }

  getChatMessages() async {
    try {
      final data =
          await IsarHelper.instance.db!.multiChatModels.where().findAll();

      if (data.isNotEmpty && contentList.isEmpty) {
        for (var element in data) {
          contentList.add(
            Content(
              parts: [
                Parts(
                  text: element.message,
                )
              ],
              role: element.sender == Sender.user ? "user" : "model",
            ),
          );
        }
      }

      state = AsyncValue.data(data);
    } catch (e) {
      rethrow;
    }
  }

  updateUserMessage({
    required String text,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    if (text.isNotEmpty) {
      final message = MultiChatModel()
        ..message = text
        ..sender = Sender.user
        ..messageType = MessageType.text;

      await IsarHelper.instance.db!.writeTxn(
        () async {
          await IsarHelper.instance.db!.multiChatModels.put(message);
        },
      );
      contentList.add(
        Content(
          parts: [
            Parts(
              text: text,
            )
          ],
          role: "user",
        ),
      );
      ref.watch(multiChatsProvider.notifier).getChatMessages();

      await getGeminiResponse(context: context, ref: ref);
    } else {
      DialogComponents.snackBar(context, "Please Write Something");
    }
  }

  getGeminiResponse(
      {required BuildContext context, required WidgetRef ref}) async {
    try {
      ref.read(isLoadingProvider.notifier).update((state) => true);

      await gemini.chat(contentList).then((value) async {
        final result = value?.content?.parts?.last.text;
        if (result != null) {
          final sendBotData = MultiChatModel()
            ..message = result.trim()
            ..sender = Sender.bot
            ..messageType = MessageType.text;

          await IsarHelper.instance.db!.writeTxn(
            () async {
              await IsarHelper.instance.db!.multiChatModels.put(sendBotData);
            },
          );

          contentList.add(
            Content(
              parts: [
                Parts(
                  text: result,
                )
              ],
              role: "model",
            ),
          );

          ref.watch(multiChatsProvider.notifier).getChatMessages();
          ref.invalidate(lastMessageProvider);
        } else {
          DialogComponents.snackBar(
              context, "Bot Didn't Responded, Try Something Else!");
          ref.read(isLoadingProvider.notifier).update((state) => false);
          ref.invalidate(lastMessageProvider);
        }

        ref.read(isLoadingProvider.notifier).update((state) => false);
      });
    } catch (e) {
      ref.read(isLoadingProvider.notifier).update((state) => false);
      // ignore: use_build_context_synchronously
      DialogComponents.snackBar(context, "Something Went Wrong, Try Again");
      ref.invalidate(lastMessageProvider);
      rethrow;
    }
  }

  newChat(WidgetRef ref) async {
    IsarHelper.instance.db!.writeTxn(
      () async {
        await IsarHelper.instance.db!.multiChatModels
            .filter()
            .isReadEqualTo(true)
            .deleteAll();
        contentList.clear();
        ref.watch(multiChatsProvider.notifier).getChatMessages();
        ref.invalidate(lastMessageProvider);
      },
    );
  }
}
