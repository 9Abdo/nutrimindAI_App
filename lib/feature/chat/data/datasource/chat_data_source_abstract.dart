import 'dart:io';

import '../models/chat_bot_model.dart';

abstract class ChatDataSourceAbstract {
  Future<ChatBotModel> sendMessage(String message);
  Future<ChatBotModel> sendImage(
    File image, {
    String? message,
    required String language,
  });
}
