import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimind/feature/model/change_target.dart';
import 'package:nutrimind/feature/model/home_model.dart';
import 'package:nutrimind/feature/model/user_modal.dart';

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
      "profileImage": null,
      "createdAt": Timestamp.now(),
    });
  }

  Future<void> updatefullname(String fullName, String uid) async {
    await firestore.collection("users").doc(uid).update({"fullname": fullName});
  }

  Future<void> updateProfileImage({
    required String uid,
    required String imageUrl,
  }) async {
    await firestore.collection("users").doc(uid).update({
      "profileImage": imageUrl,
    });
  }


  Stream<UserModel?> getUser(String uid) {
    return firestore.collection("users").doc(uid).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }

      final data = snapshot.data();

      if (data == null) {
        return null;
      }

      return UserModel.fromFirestore(data, snapshot.id);
    });
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
          "image": meal.image,
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
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();

            return HomeModel(
              id: doc.id,
              image: data["image"] as String?,
              foodName: data["foodName"] ?? "",
              calories: (data["calories"] ?? 0) as int,
              protein: (data["protein"] ?? 0) as int,
              carbs: (data["carbs"] ?? 0) as int,
              fat: (data["fat"] ?? 0) as int,
              healthScore: (data["healthScore"] ?? 0) as int,
              recommendation: data["recommendation"] ?? "",
              date: (data["date"] as Timestamp).toDate(),
            );
          }).toList();
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

  Future<void> saveTarget({
    required String uId,
    required ChangeTarget target,
  }) async {
    await firestore.collection("users").doc(uId).set({
      "target": {
        "calories": target.calories,
        "protein": target.protein,
        "carbs": target.carbs,
        "fat": target.fat,
      },
    }, SetOptions(merge: true));
  }

  Stream<ChangeTarget?> getTarget(String uid) {
    return firestore.collection("users").doc(uid).snapshots().map((snapshot) {
      final data = snapshot.data();

      if (data == null) {
        return null;
      }

      final targetData = data["target"] as Map<String, dynamic>?;

      if (targetData == null) {
        return null;
      }

      return ChangeTarget(
        calories: (targetData["calories"] ?? 2200) as int,
        protein: (targetData["protein"] ?? 95) as int,
        carbs: (targetData["carbs"] ?? 300) as int,
        fat: (targetData["fat"] ?? 70) as int,
      );
    });
  }
}
