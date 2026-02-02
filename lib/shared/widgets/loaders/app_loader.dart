import 'package:flutter/material.dart';
import 'package:swan_match/core/theme/app_colors.dart';

void showCustomProgressDialog(
  BuildContext context, {
  String message = "Loading...",
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // ❌ cannot dismiss by tap
    builder: (_) => CustomProgressDialog(message: message),
  );
}

void dismissCustomProgressDialog(BuildContext context) {
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class CustomProgressDialog extends StatelessWidget {
  final String message;

  const CustomProgressDialog({super.key, this.message = "Please wait..."});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
