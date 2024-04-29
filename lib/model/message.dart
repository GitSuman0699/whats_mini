import 'dart:typed_data';
import 'package:gemini_bot/message%20copy.dart';

class MessageModel {
  const MessageModel({
    this.message,
    required this.sender,
    required this.timeSent,
    required this.isRead,
    required this.messageType,
    this.photo,
  });

  final String? message;
  final Sender? sender;
  final String? timeSent;
  final bool? isRead;
  final MessageType? messageType;
  final Uint8List? photo;

  factory MessageModel.fromJson(Map<String, Object?> json) {
    return MessageModel(
      message: json['message'] as String,
      sender: json['sender'] as Sender,
      timeSent: json['timeSent'] as String,
      isRead: json['isRead'] as bool,
      messageType: json['messageType'] as MessageType,
      photo: json['photo'] as Uint8List,
    );
  }

  static MessageModel copyWith({
    String? message,
    Sender? sender,
    String? timeSent,
    bool? isRead,
    MessageType? messageType,
    Uint8List? photo,
  }) {
    return MessageModel(
      message: message,
      timeSent: timeSent,
      isRead: isRead,
      sender: sender,
      messageType: messageType,
      photo: photo,
    );
  }
}
