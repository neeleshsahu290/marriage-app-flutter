import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swan_match/core/theme/app_colors.dart';

class PhotosWidget extends StatefulWidget {
  final List<dynamic>? photos; // can be File or String(url)
  final ValueChanged<List<dynamic>>? onChanged;

  const PhotosWidget({
    super.key,
    required this.photos,
    required this.onChanged,
  });

  static const int maxPhotos = 6;

  @override
  State<PhotosWidget> createState() => _PhotosWidgetState();
}

class _PhotosWidgetState extends State<PhotosWidget> {
  final List<dynamic> photos = [];

  Future<void> _pickImage(BuildContext context, int index) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    final file = File(picked.path);

    setState(() {
      if (index < photos.length) {
        photos[index] = file;
      } else {
        photos.add(file);
      }
    });

    widget.onChanged?.call(List<dynamic>.from(photos));
  }

  void _removeImage(int index) {
    setState(() {
      photos.removeAt(index);
    });

    widget.onChanged?.call(List<dynamic>.from(photos));
  }

  @override
  void initState() {
    super.initState();
    if (widget.photos != null) {
      photos.addAll(widget.photos!);
    }
  }

  Widget _buildImage(dynamic photo) {
    if (photo is File) {
      return Image.file(
        photo,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }

    if (photo is String && photo.isNotEmpty) {
      return Image.network(
        photo,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image, color: Colors.grey),
      );
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: PhotosWidget.maxPhotos,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final hasPhoto = index < photos.length;

        return GestureDetector(
          onTap: () => _pickImage(context, index),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: hasPhoto
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _buildImage(photos[index]),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                    size: 28,
                  ),
          ),
        );
      },
    );
  }
}
