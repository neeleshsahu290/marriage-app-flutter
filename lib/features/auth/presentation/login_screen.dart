// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/validator_utils.dart';
import 'package:swan_match/features/auth/cubit/auth_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_state.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/inputs/primary_text_feild.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  late TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 14.h),

                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(20),
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 12.h,
                            width: 12.h,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        MyText(
                          text: 'Swan Match',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 4.h),

                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              PrimaryTextField(
                                controller: _controller,
                                label: 'Email or Phone',
                                hintText: 'Enter email or phone number',
                                onChanged: (str) {
                                  context.read<UiCubit>().setDisabled(
                                    _formKey.currentState!.validate(),
                                  );
                                },

                                prrefixIcon: AssetConstants.mailDarkIcon,
                                validator: (str) {
                                  if (str == null || str.trim().isEmpty) {
                                    return "Email or phone is required";
                                  } else if (!ValidatorUtils.isValidEmail(
                                        str.trim(),
                                      ) &&
                                      !ValidatorUtils.isValidPhone(
                                        str.trim(),
                                      )) {
                                    return "Email or phone is required";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 2.h),

                              PrimaryTextField(
                                controller: _passController,
                                label: 'Password',
                                hintText: 'Enter Password',
                                onChanged: (str) {
                                  context.read<UiCubit>().setDisabled(
                                    _formKey.currentState!.validate(),
                                  );
                                },

                                prrefixIcon: AssetConstants.mailDarkIcon,
                                validator: (str) {
                                  if (str == null || str.trim().isEmpty) {
                                    return "Password is required";
                                  }

                                  if (str.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            child: Text('Forgot Password?'),
                          ),
                        ),
                        SizedBox(height: 4.h),

                        BlocBuilder<UiCubit, UiState>(
                          builder: (context, state) {
                            return PrimaryButton(
                              disablePadding: true,
                              isLoading: state.isLoading,
                              isDisabled: !state.isDisabled,
                              btnText: 'Sign In',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  context.read<UiCubit>().setLoading(true);
                                  bool success = await context
                                      .read<AuthCubit>()
                                      .loginUser(
                                        identifier: _controller.text,
                                        password: _passController.text,
                                      );
                                  context.read<UiCubit>().setLoading(false);

                                  if (success) {
                                    context.read<StartupCubit>().userCreated();

                                    context.go(RouteNames.home);
                                  }
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(height: 2.h),

                        RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign in",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.read<StartupCubit>().userCreated();

                                    context.push(RouteNames.phone);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
