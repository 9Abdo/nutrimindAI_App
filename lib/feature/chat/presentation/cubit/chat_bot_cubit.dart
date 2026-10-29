import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/send_text_use_case.dart';
import '../../domain/usecase/sent_image_usecase.dart';
import 'chat_bot_state.dart';
import '../../../home/cubit/home_cubit.dart';

import '../../data/models/chat_message.dart';
import '../../../model/home_model.dart';

import '../../../services/firestor_services.dart';
import '../../../services/image_picker_services.dart';
import '../../../services/supbase_services.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final SendTextUseCase sendTextUseCase;
  final SentImageUsecase sentImageUsecase;
  final HomeCubit homeCubit;

  final ImagePickerService imagePickerService = ImagePickerService();

  final SupabaseStorageService supabaseStorageService =
      SupabaseStorageService();

  ChatBotCubit(
    this.homeCubit, {
    required this.sendTextUseCase,
    required this.sentImageUsecase,
  }) : super(ChatBotInitial());

  final List<ChatMessage> messages = [];

  File? selectedImage;

  bool isTyping = false;

  bool isAnalyzingMeal = false;

  void sendWelcomeMessage() {
    if (messages.isNotEmpty) return;

    messages.add(
      ChatMessage(
        text: "chat.welcome".tr(),
        isUser: false,
        time: DateTime.now(),
      ),
    );

    emit(ChatBotSuccess(message: List.from(messages)));
  }

  void refreshWelcomeMessage() {
    if (messages.isEmpty) {
      sendWelcomeMessage();
      return;
    }

    final welcomeMessage = ChatMessage(
      text: "chat.welcome".tr(),
      isUser: false,
      time: messages.first.time,
    );

    messages[0] = welcomeMessage;

    emit(ChatBotSuccess(message: List.from(messages)));
  }

  Future<void> sendMessage(String message) async {
    messages.add(
      ChatMessage(text: message, isUser: true, time: DateTime.now()),
    );

    isTyping = true;
    isAnalyzingMeal = false;

    emit(ChatBotLoading());

    final response = await sendTextUseCase.invoke(message);
    response.fold(
      (failure) {
        isTyping = false;
        isAnalyzingMeal = false;

        emit(ChatBotFailure(errMessage: failure.failureMessage));
      },
      (chatresponse) {
        isTyping = false;

        messages.add(
          ChatMessage(
            text: chatresponse.reply,
            isUser: false,
            time: DateTime.now(),
          ),
        );

        emit(ChatBotSuccess(message: List.from(messages)));
      },
    );
  }

  Future<void> sendImage(
    File image, {
    String? message,
    required String language,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User is not logged in");
    }

    messages.add(
      ChatMessage(
        image: image,
        text: message,
        isUser: true,
        time: DateTime.now(),
      ),
    );

    selectedImage = null;

    isTyping = true;
    isAnalyzingMeal = true;

    emit(ChatBotLoading());

    final response = await sentImageUsecase.invoke(
      image,
      message: message,
      language: language,
    );

    await response.fold<Future<void>>(
      (failure) async {
        isTyping = false;
        isAnalyzingMeal = false;
        log('API Failure: ${failure.failureMessage}');

        emit(ChatBotFailure(errMessage: failure.failureMessage));
      },
      (responseResult) async {
        messages.add(
          ChatMessage(
            nutrition: responseResult,
            isUser: false,
            time: DateTime.now(),
          ),
        );
        if (responseResult.reply.trim().isNotEmpty == true) {
          messages.add(
            ChatMessage(
              text: responseResult.reply,
              isUser: false,
              time: DateTime.now(),
            ),
          );
        }

        isTyping = false;
        isAnalyzingMeal = false;

        emit(ChatBotSuccess(message: List.from(messages)));

        try {
          final String imageUrl = await supabaseStorageService.uploadMealImage(
            image: image,
            uid: user.uid,
          );

          await FirestoreServices().saveMeal(
            uid: user.uid,
            meal: HomeModel(
              id: "",
              image: imageUrl,
              foodName: responseResult.foodName ?? "",
              calories: responseResult.calories ?? 0,
              protein: responseResult.protein ?? 0,
              carbs: responseResult.carbs ?? 0,
              fat: responseResult.fat ?? 0,
              healthScore: responseResult.healthScore ?? 0,
              recommendation: responseResult.recommendation ?? "",
              date: DateTime.now(),
            ),
          );

          homeCubit.loadMeals(user.uid);
        } catch (e, stackTrace) {
          log('Failed to save meal: $e', stackTrace: stackTrace);
        }
      },
    );
  }

  Future<void> pickImageFromGallery() async {
    final File? image = await imagePickerService.pickFromGallery();

    if (image == null) return;

    selectedImage = image;

    emit(ChatBotSuccess(message: List.from(messages)));
  }

  Future<void> pickImageFromCamera() async {
    final File? image = await imagePickerService.pickFromCamera();

    if (image == null) return;

    selectedImage = image;

    emit(ChatBotSuccess(message: List.from(messages)));
  }

  void removeSelectedImage() {
    selectedImage = null;

    emit(ChatBotSuccess(message: List.from(messages)));
  }
}
