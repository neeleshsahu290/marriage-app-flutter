import 'package:flutter/material.dart';
import 'package:swan_match/core/theme/app_colors.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  static const Color primary = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [primary.withOpacity(0.9), primary.withOpacity(0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(0.35),
                    blurRadius: 14,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.person_outline,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "No photo available",
              style: TextStyle(
                color: primary.withOpacity(0.85),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
