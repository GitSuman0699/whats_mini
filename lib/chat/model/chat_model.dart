import 'package:gemini_bot/message%20copy.dart';
import 'package:isar/isar.dart';

part 'chat_model.g.dart';

@Collection(inheritance: false)
class ChatModel {
  Id messageId = Isar.autoIncrement;

  String? message;

  @enumerated
  Sender sender = Sender.user;

  @enumerated
  MessageType messageType = MessageType.text;

  bool isRead = true;

  String? photo;

  DateTime sentTime = DateTime.now();
}
