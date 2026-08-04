import 'dart:io';

import 'package:nutrimind/feature/model/chat_bot_model.dart';

class ChatMessage {
  final String? text;
  final File? image;
  final ChatBotModel? nutrition;
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