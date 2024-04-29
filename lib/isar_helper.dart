import 'package:gemini_bot/message%20copy.dart';
import 'package:gemini_bot/model/chat_model.dart';
import 'package:gemini_bot/model/multi_chat_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarHelper {
  IsarHelper._privateConstructor();
  static final IsarHelper _instance = IsarHelper._privateConstructor();
  static IsarHelper get instance => _instance;

  Isar? db;

  init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      if (Isar.instanceNames.isEmpty) {
        db = await Isar.open(
          [
            ChatModelSchema,
            MultiChatModelSchema,
          ],
          directory: dir.path,
          inspector: true,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDatabase({
    bool isOneToOne = true,
    required String text,
    String? p,
    Sender sender = Sender.user,
    MessageType messageType = MessageType.text,
  }) async {
    try {
      if (isOneToOne) {
        final message = ChatModel()
          ..message = text
          ..sender = sender
          ..messageType = messageType
          ..photo = p;

        await IsarHelper.instance.db!.writeTxn(
          () async {
            await IsarHelper.instance.db!.chatModels.put(message);
          },
        );
      } else {
        final message = MultiChatModel()
          ..message = text
          ..sender = sender
          ..messageType = messageType;

        await IsarHelper.instance.db!.writeTxn(
          () async {
            await IsarHelper.instance.db!.multiChatModels.put(message);
          },
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
