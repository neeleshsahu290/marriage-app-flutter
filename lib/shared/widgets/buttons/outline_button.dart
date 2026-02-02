import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final String? svgIcon;
  final double? width;
  final double height;
  final VoidCallback? onPressed;
  final double cornerRadius;
  final double borderWidth;
  final Color borderColor;
  final Color textColor;
  final double iconSize;
  final double spacing;
  final TextAlign align;

  const OutlineButton({
    super.key,
    required this.text,
    this.svgIcon,
    this.width = double.infinity,
    this.height = 50,
    this.onPressed,
    this.cornerRadius = 8,
    this.borderWidth = 1.5,
    this.borderColor = AppColors.border,
    this.textColor = AppColors.textPrimary,
    this.iconSize = 26,
    this.spacing = 10,
    this.align = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.background,
          side: BorderSide(color: borderColor, width: borderWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon!,
                width: iconSize,
                height: iconSize,
                colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              ),

            if (svgIcon != null) SizedBox(width: spacing),

            Expanded(
              child: MyText(
                textAlignment: align,
                text: text,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
