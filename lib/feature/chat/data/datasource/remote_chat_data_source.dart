import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nutrimind/feature/chat/data/datasource/chat_data_source_abstract.dart';
import 'package:nutrimind/feature/chat/data/models/chat_bot_model.dart';

import '../../../../core/constant/const_api.dart';

class RemoteChatDataSource implements ChatDataSourceAbstract {
  final Dio dio;

  RemoteChatDataSource({required this.dio});
  @override
  Future<ChatBotModel> sendImage(
    File image, {
    String? message,
    required String language,
  }) async {
    final FormData formData = FormData.fromMap({
      "message": message ?? "",

      "language": language,

      "image": await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });

    final Response response = await dio.post(ConstApi.chatApi, data: formData);

    log("Status Code: ${response.statusCode}");
    log("Response Data: ${response.data}");

    return ChatBotModel.fromJson(response.data);
  }

  @override
  Future<ChatBotModel> sendMessage(String message)async {
    final Response response = await dio.post(
      ConstApi.chatApi,
      data: {"message": message},
    );

    log("Status Code: ${response.statusCode}");
    log("Response Data: ${response.data}");

    return ChatBotModel.fromJson(response.data);
  }
}
