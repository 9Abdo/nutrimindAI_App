class ChatBotEntity {
  final String? foodName;
  final int? calories;
  final int? protein;
  final int? carbs;
  final int? fat;
  final int? healthScore;
  final String? recommendation;
  final String reply;

  ChatBotEntity({
    this.foodName,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.healthScore,
    this.recommendation,
    required this.reply,
  });
}
