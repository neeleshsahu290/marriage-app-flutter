// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/features/auth/cubit/auth_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_state.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/common/header_widget_with_icon.dart';
import 'package:swan_match/shared/widgets/inputs/primary_text_feild.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _password;
  late TextEditingController _rePassword;

  @override
  void initState() {
    super.initState();
    _password = TextEditingController();
    _rePassword = TextEditingController();
  }

  @override
  void dispose() {
    _password.dispose();
    _rePassword.dispose();
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
                      title: "Create Your Password ",
                      descn: "Pick a strong password you’ll remember.",
                    ),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          PrimaryTextField(
                            controller: _password,
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

                              // if (!RegExp(r'[A-Z]').hasMatch(str)) {
                              //   return "Password must contain at least one uppercase letter";
                              // }

                              // if (!RegExp(r'[a-z]').hasMatch(str)) {
                              //   return "Password must contain at least one lowercase letter";
                              // }

                              // if (!RegExp(r'[0-9]').hasMatch(str)) {
                              //   return "Password must contain at least one number";
                              // }

                              return null;
                            },
                          ),

                          PrimaryTextField(
                            controller: _rePassword,
                            label: 'Confirm Password',
                            hintText: 'Enter Password',
                            onChanged: (str) {
                              context.read<UiCubit>().setDisabled(
                                _formKey.currentState!.validate(),
                              );
                            },

                            prrefixIcon: AssetConstants.mailDarkIcon,
                            validator: (str) {
                              if (str == null || str.trim().isEmpty) {
                                return "Confirm password is required";
                              }

                              if (str != _password.text) {
                                return "Passwords do not match";
                              }

                              return null;
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
          BlocBuilder<UiCubit, UiState>(
            builder: (context, state) {
              return PrimaryButton(
                isLoading: state.isLoading,
                isDisabled: !state.isDisabled,
                btnText: 'Continue',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    context.read<UiCubit>().setLoading(true);
                    bool success = await context.read<AuthCubit>().createUser(password: 
                      _password.text,
                    );
                    context.read<UiCubit>().setLoading(false);

                    if (success) {
                      context.read<StartupCubit>().loginComplete();

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
