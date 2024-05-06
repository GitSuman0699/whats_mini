import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/isar_helper.dart';
import 'package:gemini_bot/model/chat_model.dart';
import 'package:gemini_bot/model/multi_chat_model.dart';
import 'package:isar/isar.dart';

final lastMessageProvider = FutureProvider.autoDispose((ref) async {
  final chat = await IsarHelper.instance.db!.multiChatModels
      .where()
      .sortBySentTimeDesc()
      .findFirst();
  final oneToOne = await IsarHelper.instance.db!.chatModels
      .where()
      .sortBySentTimeDesc()
      .findFirst();
  return HomeModel(
    chat: chat,
    oneToOne: oneToOne,
  );
});

class HomeModel {
  final MultiChatModel? chat;
  final ChatModel? oneToOne;
  const HomeModel({this.chat, this.oneToOne});
}
