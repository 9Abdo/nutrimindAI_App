import 'package:dartz/dartz.dart';
import 'package:nutrimind/feature/chat/domain/repo/chat_message_repo_abstract.dart';

import '../../../../core/failure/failure_app.dart' show FailureApp;
import '../entitiy/chat_bot_entity.dart';

class SendTextUseCase {
  final ChatMessageRepoAbstract chatMessageRepoAbstract;

  SendTextUseCase({required this.chatMessageRepoAbstract});
  Future<Either<FailureApp, ChatBotEntity>> invoke(String message) =>
      chatMessageRepoAbstract.sendMessage(message);
}
