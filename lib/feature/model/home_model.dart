import 'dart:io';


class HomeModel {
  final String? id;
  final File? image;
  final String foodName;
  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final int healthScore;
  final String recommendation;
  final DateTime date;

  HomeModel({
    this.id,
    
    required this.image,
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.healthScore,
    required this.recommendation,
    required this.date,
  });
}
