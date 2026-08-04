import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind/core/helper/sharhelper.dart';
import 'package:nutrimind/feature/chat/cubit/chat_bot_state.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/model/chat_bot_model.dart';
import 'package:nutrimind/feature/model/chat_message.dart';
import 'package:nutrimind/feature/model/home_model.dart';
import 'package:nutrimind/feature/services/chat_bot_services.dart';
import 'package:nutrimind/feature/services/firestor_services.dart';
import 'package:nutrimind/feature/services/image_picker_services.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final ChatBotServices chatBotServices;
  final HomeCubit homeCubit;
  final ImagePickerService imagePickerService = ImagePickerService();

  ChatBotCubit(this.chatBotServices, this.homeCubit) : super(ChatBotInitial());

  final List<ChatMessage> messages = [];

  File? selectedImage;

  bool isTyping = false;

  //================== Welcome ==================

  void sendWelcomeMessage() {
    if (messages.isNotEmpty) return;

    messages.add(
      ChatMessage(
        text:
            "👋 Hello!\n"
            "How can I help you with your\n"
            "nutrition today?\n",
        isUser: false,
        time: DateTime.now(),
      ),
    );

    emit(ChatBotSuccess(message: List.from(messages)));
  }

  //================== Text ==================

  Future<void> sendMessage(String message) async {
    try {
      messages.add(
        ChatMessage(text: message, isUser: true, time: DateTime.now()),
      );

      isTyping = true;
      emit(ChatBotLoading());

      final ChatBotModel response = await chatBotServices.sendMessage(message);

      isTyping = false;

      messages.add(
        ChatMessage(text: response.reply, isUser: false, time: DateTime.now()),
      );

      emit(ChatBotSuccess(message: List.from(messages)));
    } catch (e) {
      isTyping = false;
      emit(ChatBotFailure(errMessage: e.toString()));
    }
  }

  //================== Image ==================

  Future<void> sendImage(File image, {String? message}) async {
    try {
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
      emit(ChatBotLoading());

      final ChatBotModel response = await chatBotServices.sendImage(
        image,
        message: message,
      );

      isTyping = false;

      messages.add(
        ChatMessage(nutrition: response, isUser: false, time: DateTime.now()),
      );

      final mealId = await FirestoreServices().saveMeal(
        uid: FirebaseAuth.instance.currentUser!.uid,
        meal: HomeModel(
          id: "",
          image: null,
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

      await LocalImageService().saveImage(
        mealId: mealId,
        imagePath: image.path,
      );
      homeCubit.loadMeals(FirebaseAuth.instance.currentUser!.uid);

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
      emit(ChatBotFailure(errMessage: e.toString()));
    }
  }

  //================== Pick Image ==================

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

  //================== Remove Image ==================

  void removeSelectedImage() {
    selectedImage = null;
    emit(ChatBotSuccess(message: List.from(messages)));
  }
}
