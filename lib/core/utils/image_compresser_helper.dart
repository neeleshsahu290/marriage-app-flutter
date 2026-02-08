import 'dart:developer';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageCompressHelper {
  static const int _targetSize = 200 * 1024;

  static Future<File?> compressFile(File file) async {
    try {
      final dir = await getTemporaryDirectory();

      int quality = 90;
      File? result;

      while (quality >= 40) {
        final targetPath = p.join(
          dir.path,
          "${DateTime.now().millisecondsSinceEpoch}_${p.basenameWithoutExtension(file.path)}.jpg",
        );

        final compressed = await FlutterImageCompress.compressAndGetFile(
          file.path,
          targetPath,

          // Quality reduction
          quality: quality,

          //  Resize big images first
          minWidth: 1280,
          minHeight: 1280,

          //  Convert ANY format
          format: CompressFormat.jpeg,
        );

        if (compressed == null) break;

        final compressedFile = File(compressed.path);
        final size = await compressedFile.length();

        result = compressedFile;

        //  Target size reached
        if (size <= 200 * 1024) {
          return compressedFile;
        }

        quality -= 5;
      }

      // Return best effort if couldn't reach target size
      return result;
    } catch (e) {
      log("Image compression error: $e");
      return null;
    }
  }

  static Future<List<File>> compressFiles(List<File> files) async {
    List<File> result = [];

    for (final file in files) {
      final compressed = await compressFile(file);
      if (compressed != null) result.add(compressed);
    }

    return result;
  }
}
