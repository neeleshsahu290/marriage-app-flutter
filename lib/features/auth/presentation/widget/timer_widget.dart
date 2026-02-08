import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swan_match/core/theme/app_colors.dart';

// ignore: must_be_immutable
class TimerWidget extends StatefulWidget {
  final VoidCallback onStarted;
  final VoidCallback? onComplete;
  final VoidCallback? resendOtp;
  bool restartTimer;
  final int timerTime;

  TimerWidget(
    this.onStarted,
    this.resendOtp, {
    this.restartTimer = false,
    this.onComplete,
    this.timerTime = 60,
    super.key,
  });

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  late int secondsRemaining;
  Timer? timer;
  bool isTimerRunning = true;

  @override
  void initState() {
    super.initState();
    secondsRemaining = widget.timerTime;
    startTimer();
  }

  void startTimer() {
    timer?.cancel(); // cancel previous if any

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;

      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
          isTimerRunning = true;
        });
      } else {
        t.cancel();
        setState(() {
          isTimerRunning = false;
        });

        widget.onComplete?.call();
      }
    });
  }

  void restart() {
    setState(() {
      secondsRemaining = widget.timerTime;
      isTimerRunning = true;
    });

    widget.onStarted();
    startTimer();
  }

  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.restartTimer && !oldWidget.restartTimer) {
      restart();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: isTimerRunning
          ? RichText(
              text: TextSpan(
                text: "Resend timer",

                //KeyLang.otpResendTimer.tr(),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: " ${formatTime(secondsRemaining)} ",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: widget.resendOtp,
              child: Text(
                //  KeyLang.otpResend.tr(),
                "Resend otp",
                style: const TextStyle(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
    );
  }
}
