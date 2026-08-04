import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalImageService {
  static const String key = "meal_images";

  //================ Save =================

  Future<void> saveImage({
    required String mealId,
    required String imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(key);

    Map<String, dynamic> images =
        data == null ? {} : jsonDecode(data);

    images[mealId] = imagePath;

    await prefs.setString(key, jsonEncode(images));
  }

  //================ Get =================

  Future<String?> getImage(String mealId) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(key);

    if (data == null) return null;

    final Map<String, dynamic> images = jsonDecode(data);

    return images[mealId];
  }

  //================ Delete =================

  Future<void> removeImage(String mealId) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(key);

    if (data == null) return;

    Map<String, dynamic> images = jsonDecode(data);

    images.remove(mealId);

    await prefs.setString(key, jsonEncode(images));
  }

  //================ Clear =================

  Future<void> clearImages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}