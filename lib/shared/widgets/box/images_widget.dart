import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swan_match/core/theme/app_colors.dart';

class PhotosWidget extends StatefulWidget {
  final List<File>? photos;
  final ValueChanged<List<File>>? onChanged;

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
  final List<File> photos = [];

  Future<void> _pickImage(BuildContext context, int index) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;
    photos.add(File(picked.path));
    setState(() {});

    final updated = List<File>.from(photos);

    if (index < updated.length) {
      updated[index] = File(picked.path);
    } else {
      updated.add(File(picked.path));
    }
    widget.onChanged?.call(updated);
  }

  void _removeImage(int index) {
    final updated = List<File>.from(photos)..removeAt(index);
    photos.removeAt(index);
    setState(() {});
    widget.onChanged?.call(updated);
  }

  @override
  void initState() {
    if (widget.photos != null) {
      photos.addAll(widget.photos!);
    }
    super.initState();
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
                        child: Image.file(
                          photos[index],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
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
