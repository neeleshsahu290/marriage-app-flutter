import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swan_match/core/constants/app_constants.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  ///  Bucket name
  static const String bucket = "profile_images";

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
  }

  // ==============================
  // 🔹 Upload single image
  // ==============================

  static Future<String?> uploadImage(
    File file, {
    String folder = "uploads",
  }) async {
    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

      final path = "$folder/$fileName";

      await _client.storage.from(bucket).upload(path, file);

      return _client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      print("Supabase upload error: $e");
      return null;
    }
  }

  // ==============================
  // 🔹 Upload multiple images
  // ==============================

  static Future<List<String>> uploadImages(
    List<File> files, {
    String folder = "uploads",
  }) async {
    List<String> urls = [];

    for (final file in files) {
      final url = await uploadImage(file, folder: folder);
      if (url != null) urls.add(url);
    }

    return urls;
  }

  // ==============================
  // 🔹 Delete image by path
  // ==============================

  static Future<bool> deleteImage(String path) async {
    try {
      await _client.storage.from(bucket).remove([path]);
      return true;
    } catch (e) {
      print("Delete error: $e");
      return false;
    }
  }

  // ==============================
  // 🔹 Get public URL manually
  // ==============================

  static String getPublicUrl(String path) {
    return _client.storage.from(bucket).getPublicUrl(path);
  }

  // ==============================
  // 🔹 Upload with custom name
  // ==============================

  static Future<String?> uploadWithName(
    File file,
    String fileName, {
    String folder = "uploads",
  }) async {
    try {
      final path = "$folder/$fileName";

      await _client.storage.from(bucket).upload(path, file);

      return _client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }
}
