import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind/feature/chat/cubit/chat_bot_state.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/model/chat_bot_model.dart';
import 'package:nutrimind/feature/model/chat_message.dart';
import 'package:nutrimind/feature/model/home_model.dart';
import 'package:nutrimind/feature/services/chat_bot_services.dart';
import 'package:nutrimind/feature/services/firestor_services.dart';
import 'package:nutrimind/feature/services/image_picker_services.dart';
import 'package:nutrimind/feature/services/supbase_services.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final ChatBotServices chatBotServices;
  final HomeCubit homeCubit;

  final ImagePickerService imagePickerService = ImagePickerService();

  final SupabaseStorageService supabaseStorageService =
      SupabaseStorageService();

  ChatBotCubit(this.chatBotServices, this.homeCubit) : super(ChatBotInitial());

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
    try {
      messages.add(
        ChatMessage(text: message, isUser: true, time: DateTime.now()),
      );

      isTyping = true;
      isAnalyzingMeal = false;

      emit(ChatBotLoading());

      final ChatBotModel response = await chatBotServices.sendMessage(message);

      isTyping = false;

      messages.add(
        ChatMessage(text: response.reply, isUser: false, time: DateTime.now()),
      );

      emit(ChatBotSuccess(message: List.from(messages)));
    } catch (e) {
      isTyping = false;
      isAnalyzingMeal = false;

      emit(ChatBotFailure(errMessage: e.toString()));
    }
  }

  Future<void> sendImage(
    File image, {
    String? message,
    required String language,
  }) async {
    try {
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

      final ChatBotModel response = await chatBotServices.sendImage(
        image,
        message: message,
        language: language,
      );

      final String imageUrl = await supabaseStorageService.uploadMealImage(
        image: image,
        uid: user.uid,
      );

      isTyping = false;
      isAnalyzingMeal = false;

      messages.add(
        ChatMessage(nutrition: response, isUser: false, time: DateTime.now()),
      );

      await FirestoreServices().saveMeal(
        uid: user.uid,
        meal: HomeModel(
          id: "",
          image: imageUrl,
          foodName: response.foodName ?? "",
          calories: response.calories ?? 0,
          protein: response.protein ?? 0,
          carbs: response.carbs ?? 0,
          fat: response.fat ?? 0,
          healthScore: response.healthScore ?? 0,
          recommendation: response.recommendation ?? "",
          date: DateTime.now(),
        ),
      );

      homeCubit.loadMeals(user.uid);

      if ((message?.trim().isNotEmpty ?? false) &&
          response.reply.trim().isNotEmpty) {
        messages.add(
          ChatMessage(
            text: response.reply,
            isUser: false,
            time: DateTime.now(),
          ),
        );
      }

      emit(ChatBotSuccess(message: List.from(messages)));
    } catch (e) {
      isTyping = false;
      isAnalyzingMeal = false;

      emit(ChatBotFailure(errMessage: e.toString()));
    }
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
