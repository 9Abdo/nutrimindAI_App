import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:nutrimind/core/failure/failure_app.dart';
import 'package:nutrimind/feature/chat/domain/entitiy/chat_bot_entity.dart';

abstract class ChatMessageRepoAbstract {
  Future<Either<FailureApp, ChatBotEntity>> sendMessage(String message);
  Future<Either<FailureApp, ChatBotEntity>> sendImage(
    File image, {
    String? message,
    required String language,
  });
}
