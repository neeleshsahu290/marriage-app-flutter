// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/shared/widgets/box/image_placeholer.dart';

class HeaderImageScroll extends StatefulWidget {
  final List<String> images;
  final double height;

  // status values:
  // "hidden"
  // "blurred_preview"
  // "visible_to_matches"
  final String status;

  const HeaderImageScroll({
    super.key,
    required this.images,
    this.height = 35,
    this.status = "blurred_preview",
  });

  @override
  State<HeaderImageScroll> createState() => _HeaderImageScrollState();
}

class _HeaderImageScrollState extends State<HeaderImageScroll> {
  int _currentIndex = 0;

  bool get isHidden => widget.status == "hidden";
  bool get isBlurred => widget.status == "blurred_preview";
  bool get isVisible => widget.status == "visible_to_matches";

  @override
  Widget build(BuildContext context) {
    final images = widget.images;

    // 🔒 Hidden state
    if (isHidden) {
      return SizedBox(height: widget.height.h, child: ImagePlaceholder());
    }

    return SizedBox(
      height: widget.height.h,
      width: double.infinity,
      child: images.isEmpty
          ? ImagePlaceholder()
          : Container(
              color: Color.fromARGB(255, 183, 183, 183),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      final imageUrl = images[index];

                      // 🫥 Blurred preview
                      if (isBlurred) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => const Center(
                                child: Icon(Icons.person, size: 80),
                              ),
                            ),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                              child: Container(
                                color: Colors.black.withOpacity(0.2),
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
                        );
                      }

                      // 👀 Fully visible (original UI)
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            color: Colors.grey.withOpacity(0.4),
                            colorBlendMode: BlendMode.srcOver,
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: Container(),
                          ),
                          CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.contain,
                            placeholder: (_, __) =>
                                Container(color: Colors.grey.shade300),
                            errorWidget: (_, __, ___) => const Center(
                              child: Icon(Icons.person, size: 80),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // ● bullets (only when not hidden)
                  Positioned(
                    bottom: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentIndex == index ? 10 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
