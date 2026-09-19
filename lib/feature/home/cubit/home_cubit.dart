import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind/feature/home/cubit/home_state.dart';
import 'package:nutrimind/feature/model/change_target.dart';
import 'package:nutrimind/feature/model/home_model.dart';
import 'package:nutrimind/feature/services/firestor_services.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final FirestoreServices firestoreServices = FirestoreServices();

  final List<HomeModel> meals = [];

  int targetCalories = 2200;
  int targetProtein = 95;
  int targetCarbs = 300;
  int targetFat = 70;

  void loadMeals(String uid) {
    emit(HomeLoading());

    firestoreServices
        .getMeals(uid)
        .listen(
          (data) {
            meals
              ..clear()
              ..addAll(data);

            emit(HomeLoaded(List.from(meals)));
          },
          onError: (error) {
            emit(HomeFailure(error.toString()));
          },
        );
  }

  void loadTarget(String uid) {
    firestoreServices
        .getTarget(uid)
        .listen(
          (target) {
            if (target == null) return;

            targetCalories = target.calories;
            targetProtein = target.protein;
            targetCarbs = target.carbs;
            targetFat = target.fat;
          },
          onError: (error) {
            emit(HomeFailure(error.toString()));
          },
        );
  }


  Future<void> deleteMeal({required String uid, required String mealId}) async {
    await firestoreServices.deleteMeal(uid: uid, mealId: mealId);
  }



  int get todayCalories => meals
      .where((e) => _isToday(e.date))
      .fold(0, (sum, e) => sum + e.calories);

  int get todayProtein =>
      meals.where((e) => _isToday(e.date)).fold(0, (sum, e) => sum + e.protein);

  int get todayCarbs =>
      meals.where((e) => _isToday(e.date)).fold(0, (sum, e) => sum + e.carbs);

  int get todayFat =>
      meals.where((e) => _isToday(e.date)).fold(0, (sum, e) => sum + e.fat);

  int get todayMeals => meals.where((e) => _isToday(e.date)).length;

  

  bool _isToday(DateTime date) {
    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

 

  Future<void> updateDailyGoal(ChangeTarget target) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(HomeFailure("User is not logged in"));
      return;
    }

    try {
      await firestoreServices.saveTarget(uId: user.uid, target: target);

      targetCalories = target.calories;
      targetProtein = target.protein;
      targetCarbs = target.carbs;
      targetFat = target.fat;

      emit(Changetarge(changetarget: target));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
