import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/features/setup/model/welcome_intent_model.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                    text: context.tr.welcomeTitle,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 2.h),
                  MyText(
                    text: context.tr.welcomeSubtitle,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 4.h),
                  ...List.generate(
                    getWelcomeIntentList(context).length,
                    (index) => valueItem(getWelcomeIntentList(context)[index]),
                  ),
                ],
              ),
            ),
          ),
          PrimaryButton(
            btnText: context.tr.continueText,
            onPressed: () {
              context.read<StartupCubit>().completeWelcome();
            },
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget valueItem(WelcomeIntentModel item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset(
              item.icon,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: item.title, fontWeight: FontWeight.w600),
                // SizedBox(height: 4),
                MyText(text: item.description, color: AppColors.textSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
