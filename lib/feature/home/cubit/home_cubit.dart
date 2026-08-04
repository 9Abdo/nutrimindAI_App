import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind/core/helper/sharhelper.dart';
import 'package:nutrimind/feature/home/cubit/home_state.dart';
import 'package:nutrimind/feature/model/home_model.dart';
import 'package:nutrimind/feature/services/firestor_services.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final FirestoreServices firestoreServices = FirestoreServices();

  final List<HomeModel> meals = [];

  //==================== Load Meals ====================

  void loadMeals(String uid) {
    emit(HomeLoading());

    firestoreServices.getMeals(uid).listen((data) async {
      final List<HomeModel> updatedMeals = [];

      for (final meal in data) {
        final imagePath = await LocalImageService().getImage(meal.id!);

        updatedMeals.add(
          HomeModel(
            id: meal.id,
            image: imagePath != null ? File(imagePath) : null,
            foodName: meal.foodName,
            calories: meal.calories,
            protein: meal.protein,
            carbs: meal.carbs,
            fat: meal.fat,
            healthScore: meal.healthScore,
            recommendation: meal.recommendation,
            date: meal.date,
          ),
        );
      }

      meals
        ..clear()
        ..addAll(updatedMeals);

      emit(HomeLoaded(updatedMeals));
    });
  }

  //==================== Delete Meal ====================

  Future<void> deleteMeal({
    required String uid,
    required String mealId,
  }) async {
    await firestoreServices.deleteMeal(
      uid: uid,
      mealId: mealId,
    );

    await LocalImageService().removeImage(mealId);
  }

  //==================== Today's Statistics ====================

  int get todayCalories => meals
      .where((e) => _isToday(e.date))
      .fold(0, (sum, e) => sum + e.calories);

  int get todayProtein => meals
      .where((e) => _isToday(e.date))
      .fold(0, (sum, e) => sum + e.protein);

  int get todayCarbs => meals
      .where((e) => _isToday(e.date))
      .fold(0, (sum, e) => sum + e.carbs);

  int get todayFat => meals
      .where((e) => _isToday(e.date))
      .fold(0, (sum, e) => sum + e.fat);

  int get todayMeals =>
      meals.where((e) => _isToday(e.date)).length;

  bool _isToday(DateTime date) {
    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}