import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/common/header_widget_with_icon.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

final List list = [
  "WITHIN_6_MONTHS",
  "SIX_TO_TWELVE_MONTHS",
  "ONE_TO_TWO_YEARS",
  "TWO_PLUS_YEARS",
];
List<String> getRulesList(BuildContext context) {
  return [
    context.tr.ruleRespect,
    context.tr.ruleNoContent,
    context.tr.ruleHonest,
    context.tr.ruleReport,
  ];
}

class IntentScreen extends StatefulWidget {
  const IntentScreen({super.key});

  @override
  State<IntentScreen> createState() => _IntentScreenState();
}

class _IntentScreenState extends State<IntentScreen> {
  int selected = -1;

  bool isAcceptIntent = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    HeaderWidgetWithIcon(
                      iconName: AssetConstants.lockIcon,
                      title: context.tr.intentTitle,
                      descn: context.tr.intentDesc,
                    ),

                    MyText(
                      text: context.tr.intentQuestionSerious,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 1.2.h),
                    box(),
                    SizedBox(height: 2.h),

                    MyText(
                      text: context.tr.intentQuestionSettle,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 1.2.h),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(list.length, (index) {
                        bool isSelectd = index == selected;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelectd
                                  ? AppColors.primary
                                  : AppColors.background,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelectd
                                    ? AppColors.primary
                                    : AppColors.border,
                                width: 1.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 16,
                              ),
                              child: MyText(
                                text: context.t(list[index]),
                                color: isSelectd
                                    ? AppColors.textInverse
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 1.5.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: context.tr.communityGuidelinesTitle,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 8),
                            ...List.generate(
                              getRulesList(context).length,
                              (index) =>
                                  bulletedText(getRulesList(context)[index]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 1.5.h),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isAcceptIntent = !isAcceptIntent;
                            });
                          },
                          child: Container(
                            height: 25,
                            width: 25,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.cardBackground,
                            ),

                            child: isAcceptIntent
                                ? Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.done_rounded,
                                      size: 16,
                                      grade: 1,
                                      fill: 1,
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: MyText(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            text: context.tr.intentAcceptText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            PrimaryButton(
              isDisabled: !isAcceptIntent || selected < 0,
              btnText: context.tr.continueText,
              onPressed: () {
                context.read<StartupCubit>().setIntentDone(list[selected]);
              },
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget box() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.secondary,
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Row(
          children: [
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 4),
            Expanded(
              child: MyText(
                text: context.tr.intentSeriousBox,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(AssetConstants.lockIcon),
            ),
          ],
        ),
      ),
    );
  }

  Widget bulletedText(text) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: AppColors.textSecondary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: MyText(
            text: text,
            color: AppColors.textSecondary,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}
