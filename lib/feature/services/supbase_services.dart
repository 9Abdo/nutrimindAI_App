import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient supabase = Supabase.instance.client;

  static const String bucketName = 'meal-images';

  Future<String> uploadMealImage({
    required File image,
    required String uid,
  }) async {
    final extension = image.path.split('.').last.toLowerCase();

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.$extension';

    final filePath = 'users/$uid/meals/$fileName';

    await supabase.storage.from(bucketName).upload(
      filePath,
      image,
      fileOptions: const FileOptions(
        cacheControl: '3600',
        upsert: false,
      ),
    );

    final imageUrl = supabase.storage
        .from(bucketName)
        .getPublicUrl(filePath);

    return imageUrl;
  }
   Future<String> uploadProfileImage({
    required File image,
    required String uid,
  }) async {
    final extension = image.path.split('.').last.toLowerCase();

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.$extension';

    final filePath = 'users/$uid/images/$fileName';

    await supabase.storage.from(bucketName).upload(
      filePath,
      image,
      fileOptions: const FileOptions(
        cacheControl: '3600',
        upsert: false,
      ),
    );

    final imageUrl = supabase.storage
        .from(bucketName)
        .getPublicUrl(filePath);

    return imageUrl;
  }
}