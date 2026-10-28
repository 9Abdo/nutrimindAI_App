import 'package:nutrimind/feature/chat/domain/entitiy/chat_bot_entity.dart';

class ChatBotModel extends ChatBotEntity {
  ChatBotModel({
    super.foodName,
    super.calories,
    super.protein,
    super.carbs,
    super.fat,
    super.healthScore,
    super.recommendation,
    required super.reply,
  });

  factory ChatBotModel.fromJson(Map<String, dynamic> json) {
    return ChatBotModel(
      foodName: json["foodName"],
      calories: json["calories"],
      protein: json["protein"],
      carbs: json["carbs"],
      fat: json["fat"],
      healthScore: json["healthScore"],
      recommendation: json["recommendation"],
      reply: json["reply"] ?? json["message"] ?? "",
    );
  }
}
