import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color appBarColor;
  final Color titleColor;
  final Widget? flexiableWidget;
  final String? title;
  final bool isLight;
  final double? height;
  final List<Widget>? actionsList;
  final VoidCallback? onBackPressed;
  final Widget? leading;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final bool isTitleCenter;
  final FontWeight fontWeight;
  final SystemUiOverlayStyle systemOverlayStyle;
  const CustomAppBar({
    super.key,
    this.appBarColor = AppColors.appBarbackg,
    this.titleColor = AppColors.textPrimary,
    this.systemOverlayStyle = SystemUiOverlayStyle.dark,
    this.leading,
    this.title,
    this.actionsList,
    this.onBackPressed,
    this.bottom,
    this.isTitleCenter = false,
    this.elevation = 0.4,
    this.fontWeight = FontWeight.w600,
    this.height,
    this.isLight = false,
    this.flexiableWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      systemOverlayStyle: systemOverlayStyle,
      leadingWidth: (onBackPressed == null && leading == null) ? 16 : 48,
      leading: (leading != null)
          ? leading
          : (onBackPressed != null)
          ? Tooltip(
              message: "Back",
              child: IconButton(
                onPressed: onBackPressed,
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 22.0,
                  color: isLight ? AppColors.appBarbackg : Colors.black,
                ),
                color: AppColors.appBarbackg,
              ),
            )
          : const SizedBox(),
      backgroundColor: appBarColor,
      surfaceTintColor: AppColors.appBarbackg,
      title: title != null
          ? MyText(text: title!, fontWeight: fontWeight, color: titleColor)
          : null,
      shadowColor: Colors.grey,
      flexibleSpace: flexiableWidget,
      bottom: bottom,
      centerTitle: isTitleCenter,
      actions: actionsList,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 65.0);
}
