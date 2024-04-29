import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/controller/chat_controller.dart';
import 'package:gemini_bot/dialog_components.dart';
import 'package:gemini_bot/isar_helper.dart';
import 'package:gemini_bot/message%20copy.dart';
import 'package:gemini_bot/model/multi_chat_model.dart';
import 'package:gemini_bot/repository/multi_chat_repository.dart';
import 'package:isar/isar.dart';

final multiChatProvider =
    AsyncNotifierProvider.autoDispose<MultiChat, List<MultiChatModel>>(() {
  return MultiChat();
});

class MultiChat extends AutoDisposeAsyncNotifier<List<MultiChatModel>> {
  List<Content> contentList = [];

  @override
  FutureOr<List<MultiChatModel>> build() {
    return getMultiChat();
  }

  Future<List<MultiChatModel>> getMultiChat() async {
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

      return data;
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
      await IsarHelper.instance.updateDatabase(text: text, isOneToOne: false);
      ref.invalidate(multiChatProvider);
      await getGeminiResponse(context: context);
    } else {
      DialogComponents.snackBar(context, "Please Write Something");
    }
  }

  getGeminiResponse({required BuildContext context}) async {
    ref.read(isLoadingProvider.notifier).update((state) => true);
    final botResponse = await MultiChatRepository.instance
        .getMultiChatResponse(content: contentList);
    if (botResponse != null) {
      contentList.add(
        Content(
          parts: [
            Parts(
              text: botResponse,
            )
          ],
          role: "model",
        ),
      );
      await IsarHelper.instance.updateDatabase(
        text: botResponse,
        isOneToOne: false,
        sender: Sender.bot,
      );
      ref.invalidate(multiChatProvider);
      ref.read(isLoadingProvider.notifier).update((state) => false);
    } else {
      DialogComponents.snackBar(
          context, "Bot Didn't Responded, Try Something Else!");
      ref.read(isLoadingProvider.notifier).update((state) => false);
    }
    ref.read(isLoadingProvider.notifier).update((state) => false);
  }
}
