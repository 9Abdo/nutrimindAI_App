

import 'package:nutrimind/feature/model/chat_message.dart';

abstract class ChatBotState {}

class ChatBotInitial extends ChatBotState {}

class ChatBotLoading extends ChatBotState {}

class ChatBotSuccess extends ChatBotState {
  final List<ChatMessage> message;

  ChatBotSuccess({required this.message});
}

class ChatBotFailure extends ChatBotState {
  final String errMessage;

  ChatBotFailure({required this.errMessage});
}
