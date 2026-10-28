import 'dart:io';

import 'package:dartz/dartz.dart' show Either;
import '../repo/chat_message_repo_abstract.dart';

import '../../../../core/failure/failure_app.dart' show FailureApp;
import '../entitiy/chat_bot_entity.dart';

class SentImageUsecase {
  final ChatMessageRepoAbstract chatMessageRepoAbstract;

  SentImageUsecase({required this.chatMessageRepoAbstract});
  Future<Either<FailureApp, ChatBotEntity>> invoke(
    File image, {
    String? message,
    required String language,
  }) => chatMessageRepoAbstract.sendImage(
    image,
    language: language,
    message: message,
  );
}
