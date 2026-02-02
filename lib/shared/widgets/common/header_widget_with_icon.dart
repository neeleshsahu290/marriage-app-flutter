import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class HeaderWidgetWithIcon extends StatelessWidget {
  final String iconName;
  final String title;
  final String descn;
  const HeaderWidgetWithIcon({super.key,required this.iconName, required this.title, required this.descn});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(60),
          ),
          child: SizedBox(
            width: 24,
            height: 24,
            child: UnconstrainedBox(
              child: SvgPicture.asset(
               iconName,

                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h),

        MyText(
          text: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 2.h),
        MyText(
          text: descn,
          color: AppColors.textSecondary,
          textAlignment: TextAlign.center,
        ),

        SizedBox(height: 2.h),
      ],
    );
  }
}
