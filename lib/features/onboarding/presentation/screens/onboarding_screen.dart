// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/utils.dart';
import 'package:swan_match/features/onboarding/cubit/onboarding_form_cubit.dart';
import 'package:swan_match/features/onboarding/model/error_model.dart';
import 'package:swan_match/features/onboarding/model/form_page_model.dart';
import 'package:swan_match/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:swan_match/features/onboarding/presentation/widget/navigate_btn.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/shared/widgets/loaders/app_loader.dart';

class OnboardingScreen extends StatefulWidget {
  final bool isEdit;

  const OnboardingScreen({super.key, required this.isEdit});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  List<FormPageModel> pages = [];

  loadPages() {
    pages = formFeilds.map((e) => FormPageModel.fromJson(e)).toList();
  }

  loadFildsData() {
    List<Map<String, ErrorModel>> errorListmap = [];

    for (var page in pages) {
      Map<String, ErrorModel> map = {};
      for (var feild in page.fields) {
        map[feild.keyName] = ErrorModel(
          errorTxt: feild.errorText,
          isVerified: !feild.isRequired,
        );
      }
      errorListmap.add(map);
    }

    context.read<OnboardingFormCubit>().insertFeildData(
      fieldsData,
      errorListmap,
    );

    if (widget.isEdit) {}
  }

  @override
  void initState() {
    loadPages();
    loadFildsData();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<OnboardingFormCubit>().setProfileData();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> submit(BuildContext context) async {
    showCustomProgressDialog(context, message: "Submitting...");

    final isValue = await context.read<OnboardingFormCubit>().submitForm();

    if (!context.mounted) return;

    dismissCustomProgressDialog(context);

    if (isValue) {
      context.read<StartupCubit>().setOnboardingDone();
      context.go(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ValueListenableBuilder(
                  valueListenable: _currentIndex,
                  builder: (context, value, _) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final progress = (value + 1) / pages.length;

                        return Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: constraints.maxWidth * progress,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: pages.length,
                onPageChanged: (index) {
                  _currentIndex.value = index;
                },
                itemBuilder: (context, index) {
                  return RepaintBoundary(
                    child: OnboardingPage(
                      pageData: pages[index],
                      currentPage: index,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, value, child) {
                return NavigateBtn(
                  currentPage: value,

                  onNextClick: () {
                    bool isValid = context
                        .read<OnboardingFormCubit>()
                        .isValidFeilds(value);
                    if (isValid) {
                      if (value < pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        submit(context);
                      }
                    } else {
                      Utils.showError('Please fill all the feilds');
                    }
                  },
                  onPreviousClick: () {
                    if (value > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
