import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimind/core/helper/sharhelper.dart';
import 'package:nutrimind/feature/model/home_model.dart';

class FirestoreServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //==================== Save User ====================

  Future<void> saveUser({
    required String uid,
    required String fullname,
    required String email,
  }) async {
    await firestore.collection("users").doc(uid).set({
      "fullname": fullname,
      "email": email,
      "createdAt": Timestamp.now(),
    });
  }

  //==================== Get User ====================

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) {
    return firestore.collection("users").doc(uid).snapshots();
  }

  //==================== Save Meal ====================

  Future<String> saveMeal({
    required String uid,
    required HomeModel meal,
  }) async {
    final doc = await firestore
        .collection("users")
        .doc(uid)
        .collection("history")
        .add({
          "foodName": meal.foodName,
          "calories": meal.calories,
          "protein": meal.protein,
          "carbs": meal.carbs,
          "fat": meal.fat,
          "healthScore": meal.healthScore,
          "recommendation": meal.recommendation,
          "date": Timestamp.fromDate(meal.date),
        });

    return doc.id;
  }

  //==================== Get Meals ====================

  Stream<List<HomeModel>> getMeals(String uid) {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("history")
        .orderBy("date", descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          List<HomeModel> meals = [];

          for (var doc in snapshot.docs) {
            final data = doc.data();

            final imagePath = await LocalImageService().getImage(doc.id);

            meals.add(
              HomeModel(
                id: doc.id,
                image: imagePath != null ? File(imagePath) : null,
                foodName: data["foodName"],
                calories: data["calories"],
                protein: data["protein"],
                carbs: data["carbs"],
                fat: data["fat"],
                healthScore: data["healthScore"],
                recommendation: data["recommendation"],
                date: (data["date"] as Timestamp).toDate(),
              ),
            );
          }

          return meals;
        });
  }

  //==================== Delete Meal ====================

  Future<void> deleteMeal({required String uid, required String mealId}) async {
    await firestore
        .collection("users")
        .doc(uid)
        .collection("history")
        .doc(mealId)
        .delete();
  }
}
