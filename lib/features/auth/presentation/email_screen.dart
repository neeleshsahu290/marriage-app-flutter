// ignore_for_file: use_build_context_synchronously

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
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/common/header_widget_with_icon.dart';
import 'package:swan_match/shared/widgets/inputs/primary_text_feild.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderWidgetWithIcon(
                      iconName: AssetConstants.mailIcon,
                      title: "Email Verification",
                      descn: "We'll send you a code to verify your email",
                    ),

                    Form(
                      key: _formKey,
                      child: PrimaryTextField(
                        controller: _controller,
                        label: 'Email',
                        hintText: 'Enter Email',
                        onChanged: (str) {
                          context.read<UiCubit>().setDisabled(
                            _formKey.currentState!.validate(),
                          );
                        },

                        prrefixIcon: AssetConstants.mailDarkIcon,
                        validator: (str) {
                          if (str == null || str.trim().isEmpty) {
                            return "Email is required";
                          } else if (!ValidatorUtils.isValidEmail(str.trim())) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<UiCubit, UiState>(
            builder: (context, state) {
              return PrimaryButton(
                isLoading: state.isLoading,
                isDisabled: !state.isDisabled,
                btnText: 'Continue',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    context.read<UiCubit>().setLoading(true);
                    bool success = await context.read<AuthCubit>().sendEmailOtp(
                      _controller.text,
                    );
                    context.read<UiCubit>().setLoading(false);

                    if (success) {
                      context.push(RouteNames.emailOtp);
                    }
                  }
                },
              );
            },
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
