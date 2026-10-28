import 'dart:io';

import 'package:nutrimind/feature/chat/domain/entitiy/chat_bot_entity.dart';

class ChatMessage {
  final String? text;
  final File? image;
  final ChatBotEntity? nutrition;
  final bool isUser;
  final DateTime time;

  ChatMessage({
    this.text,
    this.image,
    this.nutrition,
    required this.isUser,
    required this.time,
  });
}
