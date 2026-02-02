import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swan_match/core/theme/app_colors.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class Utils {
  static void showCustomSnackbar({
    required String message,
    Color backgroundColor = Colors.black,
    IconData icon = Icons.info_outline,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
  }) {
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: backgroundColor,
        duration: duration,
        content: Row(
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
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

  static void showError(String message) {
    showCustomSnackbar(
      message: message,
      backgroundColor: AppColors.error,
      icon: Icons.error_outline,
    );
  }

  static void showSuccess(String message) {
    showCustomSnackbar(
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle_outline,
    );
  }

  static void showInfo(String message) {
    showCustomSnackbar(
      message: message,
      backgroundColor: Colors.black87,
      icon: Icons.info_outline,
    );
  }

  static void showToast({
    required String message,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 14.0,
    );
  }
}
