import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/controller/chat_controller.dart';
import 'package:gemini_bot/dialog_components.dart';
import 'package:gemini_bot/gemini_service/gemini_service.dart';
import 'package:gemini_bot/isar_helper.dart';
import 'package:gemini_bot/message%20copy.dart';
import 'package:gemini_bot/model/chat_model.dart';
import 'package:isar/isar.dart';

final chatProvider1 =
    AsyncNotifierProvider.autoDispose<Chat, List<ChatModel>>(() {
  return Chat();
});

class Chat extends AutoDisposeAsyncNotifier<List<ChatModel>> {
  final gemini = GeminiService.instance.gemini;
  // int page = 1;
  @override
  FutureOr<List<ChatModel>> build() {
    return getMessages();
  }

  Future<List<ChatModel>> getMessages() async {
    final data = await IsarHelper.instance.db!.chatModels
        .where()
        .sortBySentTimeDesc()
        .findAll();

    return data;
  }

  updateUserMessage({
    required String text,
    required Uint8List? photo,
    required String? p,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    if (text.isNotEmpty && photo != null) {
      final sendUserData = ChatModel()
        ..message = text
        ..sender = Sender.user
        ..messageType = MessageType.image
        ..photo = p;

      await IsarHelper.instance.db!.writeTxn(
        () async {
          await IsarHelper.instance.db!.chatModels.put(sendUserData);
        },
      );

      // page = 1;

      // messageList = [];

      ref.invalidate(chatProvider1);

      // state = [...state, sendUserData];

      await getTextAndImageGeminiResponse(
        text: text,
        photo: photo,
        ref: ref,
        context: context,
      );
    } else if (text.isNotEmpty) {
      final sendUserData = ChatModel()
        ..message = text
        ..sender = Sender.user
        ..messageType = MessageType.text;

      await IsarHelper.instance.db!.writeTxn(
        () async {
          await IsarHelper.instance.db!.chatModels.put(sendUserData);
        },
      );

      // page = 1;

      // messageList = [];

      ref.invalidate(chatProvider1);

      // state = [...state, sendUserData];

      await getTextOnlyGeminiResponse(
        text: text,
        ref: ref,
        context: context,
      );
    } else {
      DialogComponents.snackBar(context, "Please Write Something");
    }
  }

  getTextOnlyGeminiResponse({
    required String text,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      ref.read(isLoadingProvider.notifier).update((state) => true);

      await gemini.text(text).then((value) async {
        final result = value?.content?.parts?.last.text;

        if (result != null) {
          final sendBotData = ChatModel()
            ..message = result.trim()
            ..sender = Sender.bot
            ..messageType = MessageType.text;

          await IsarHelper.instance.db!.writeTxn(
            () async {
              await IsarHelper.instance.db!.chatModels.put(sendBotData);
            },
          );

          // page = 1;

          // messageList = [];

          ref.invalidate(chatProvider1);

          // state = [...state, sendBotData];
        } else {
          DialogComponents.snackBar(
              context, "Bot Didn't Responded, Try Something Else!");
          ref.read(isLoadingProvider.notifier).update((state) => false);
        }

        ref.read(isLoadingProvider.notifier).update((state) => false);
      });
    } catch (e) {
      ref.read(isLoadingProvider.notifier).update((state) => false);
      // ignore: use_build_context_synchronously
      DialogComponents.snackBar(context, "Something Went Wrong, Try Again");
      rethrow;
    }
  }

  getTextAndImageGeminiResponse({
    required String text,
    required Uint8List? photo,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    ref.read(isLoadingProvider.notifier).update((state) => true);

    try {
      await gemini
          .textAndImage(text: text, images: [photo!]).then((value) async {
        final result = value?.content?.parts?.last.text;

        if (result != null) {
          final sendBotData = ChatModel()
            ..message = result.trim()
            ..sender = Sender.bot
            ..messageType = MessageType.text;

          await IsarHelper.instance.db!.writeTxn(
            () async {
              await IsarHelper.instance.db!.chatModels.put(sendBotData);
            },
          );

          // page = 1;

          // messageList = [];

          ref.invalidate(chatProvider1);

          // state = [...state, sendBotData];
        } else {
          DialogComponents.snackBar(
              context, "Bot Didn't Responded, Try Something Else!");
          ref.read(isLoadingProvider.notifier).update((state) => false);
        }

        ref.read(isLoadingProvider.notifier).update((state) => false);
      });
    } catch (e) {
      ref.read(isLoadingProvider.notifier).update((state) => false);
      // ignore: use_build_context_synchronously
      DialogComponents.snackBar(context, "Something Went Wrong, Try Again");
      rethrow;
    }
  }

  newChat(WidgetRef ref) async {
    IsarHelper.instance.db!.writeTxn(
      () async {
        await IsarHelper.instance.db!.chatModels
            .filter()
            .isReadEqualTo(true)
            .deleteAll();
        ref.invalidate(chatProvider1);
      },
    );
  }
}
