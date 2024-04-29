import 'package:gemini_bot/message%20copy.dart';
import 'package:isar/isar.dart';

part 'multi_chat_model.g.dart';

@Collection(inheritance: false)
class MultiChatModel {
  Id messageId = Isar.autoIncrement;

  String? message;

  @enumerated
  Sender sender = Sender.user;

  @enumerated
  MessageType messageType = MessageType.text;

  bool isRead = true;

  DateTime sentTime = DateTime.now();
}
