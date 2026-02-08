import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/box/image_placeholer.dart';

class ImageSectionCard extends StatelessWidget {
  final String imageUrl;
  final String status; // hidden | blurred_preview | visible_to_matches

  const ImageSectionCard({
    super.key,
    required this.imageUrl,
    this.status = "visible_to_matches",
  });

  static const Color primary = AppColors.primary;

  bool get isHidden => status == "hidden";
  bool get isBlurred => status == "blurred_preview";
  bool get isVisible => status == "visible_to_matches";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: isHidden
            ? const ImagePlaceholder()
            : Stack(
                fit: StackFit.expand,
                children: [
                  // 🫥 Blurred preview state
                  if (isBlurred)
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                          child: Container(
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.lock,
                              color: Colors.black54,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),

                  // 👀 Visible state gradient
                  if (isVisible)
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black87],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),

                  CachedNetworkImage(
                    imageUrl: imageUrl,

                    fit: BoxFit.contain,
                    placeholder: (_, __) =>
                        Container(color: Colors.grey.shade300),
                    errorWidget: (_, __, ___) =>
                        const Center(child: Icon(Icons.person, size: 80)),
                  ),
                ],
              ),
      ),
    );
  }
}
