class ChatBotModel {
  final String? foodName;
  final int? calories;
  final int? protein;
  final int? carbs;
  final int? fat;
  final int? healthScore;
  final String? recommendation;
  final String reply;

  ChatBotModel({
    this.foodName,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.healthScore,
    this.recommendation,
    required this.reply,
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
