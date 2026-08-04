import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nutrimind/feature/model/chat_bot_model.dart';

class ChatBotServices {
  final Dio dio;

  ChatBotServices({required this.dio});

  Future<ChatBotModel> sendMessage(String message) async {
    final Response response = await dio.post(
      "https://abdosabry999.app.n8n.cloud/webhook/chat",
      data: {"message": message},
    );
    log("Status Code: ${response.statusCode}");
    log("Response Data: ${response.data}");
    return ChatBotModel.fromJson(response.data);
  }

  Future<ChatBotModel> sendImage(File image, {String? message}) async {
    FormData formData = FormData.fromMap({
      "message": message ?? "Analyze this food",
      "image": await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });

    final Response response = await dio.post(
      "https://abdosabry999.app.n8n.cloud/webhook/chat",
      data: formData,
    );
    log("Status Code: ${response.statusCode}");
    log("Response Data: ${response.data}");
    return ChatBotModel.fromJson(response.data);
  }
}
