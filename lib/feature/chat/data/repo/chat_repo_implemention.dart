import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure_app.dart';
import '../datasource/chat_data_source_abstract.dart';
import '../../domain/entitiy/chat_bot_entity.dart';
import '../../domain/repo/chat_message_repo_abstract.dart';

class ChatRepoImplemention extends ChatMessageRepoAbstract {
  final ChatDataSourceAbstract chatDataSourceAbstract;

  ChatRepoImplemention({required this.chatDataSourceAbstract});
  @override
  Future<Either<FailureApp, ChatBotEntity>> sendImage(
    File image, {
    String? message,
    required String language,
  }) async {
    try {
      final chat = await chatDataSourceAbstract.sendImage(
        image,
        language: language,
        message: message,
      );
      return Right(chat);
    } catch (e) {
      return Left(FailureApp(failureMessage: e.toString()));
    }
  }

  @override
  Future<Either<FailureApp, ChatBotEntity>> sendMessage(String message) async {
    try {
      final chatMessage = await chatDataSourceAbstract.sendMessage(message);
      return Right(chatMessage);
    } catch (e) {
      return Left(FailureApp(failureMessage: e.toString()));
    }
  }
}
