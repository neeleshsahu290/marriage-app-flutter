import 'package:flutter/material.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class NavigateBtn extends StatelessWidget {
  final int currentPage;
  final VoidCallback? onNextClick;
  final VoidCallback? onPreviousClick;
  const NavigateBtn({super.key, this.onNextClick, this.onPreviousClick, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
       currentPage!=0?   Expanded(
            child: Padding(
       padding: const EdgeInsets.only(right:  20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: AppColors.border, 
                      width: 1,
                    ),
                  ),
                ),
                onPressed: onPreviousClick,
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: MyText(
                      text: 'Back',
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ):SizedBox.shrink(),
          
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.all(0.0),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onNextClick,
              child: SizedBox(
                height: 50,
                child: Center(
                  child: MyText(
                    text: 'Next',
                    color: AppColors.textInverse,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
