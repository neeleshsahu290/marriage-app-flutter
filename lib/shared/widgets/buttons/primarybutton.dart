import 'package:flutter/material.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class PrimaryButton extends StatefulWidget {
  final String btnText;
  final double? width;
  final double height;
  final Function()? onPressed;
  final bool disablePadding;
  final Color textColor;
  final double textSize;
  final Widget? child;
  final bool isLoading;
  final double cornerRadius;
  final double elevation;
  final FontWeight fontWeight;
  final bool isDisabled;

  const PrimaryButton({
    super.key,
    required this.btnText,
    this.width,
    this.height = 50.0,
    this.onPressed,
    this.disablePadding = false,
    this.child,
    this.isLoading = false,
    this.textColor = AppColors.textInverse,
    this.textSize = 16.0,
    this.cornerRadius = 6.0,
    this.elevation = 1.0,
    this.fontWeight = FontWeight.w700,
    this.isDisabled = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool isEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.disablePadding
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
            foregroundColor: Colors.black,
            elevation: widget.elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.cornerRadius),
            ),
          ),
          onPressed: widget.isLoading || widget.isDisabled
              ? null
              : () {
                  if (isEnabled) {
                    if (!widget.isLoading) {
                      widget.onPressed?.call();
                      setState(() {
                        isEnabled = false;
                        Future.delayed(const Duration(milliseconds: 500)).then((
                          value,
                        ) {
                          if (mounted) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                        });
                      });
                    }
                  }
                },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.cornerRadius),

              color: widget.isDisabled
                  ? const Color.fromRGBO(255, 31, 87, 0.5)
                  : widget.isLoading
                  ? Colors.grey.shade300
                  : AppColors.primary,
            ),

            child: widget.child != null
                ? SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: widget.child,
                  )
                : Container(
                    width: widget.width,
                    height: widget.height,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.cornerRadius),
                    ),
                    child: widget.isLoading
                        ? const SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                              strokeWidth: 3,
                            ),
                          )
                        : MyText(
                            text: widget.btnText,
                            textAlignment: TextAlign.center,
                            color: widget.textColor,
                            fontSize: widget.textSize,
                            fontWeight: widget.fontWeight,
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
