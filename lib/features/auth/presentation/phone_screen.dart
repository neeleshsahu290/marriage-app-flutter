// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/features/auth/cubit/auth_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_state.dart';
import 'package:swan_match/features/auth/presentation/widget/country_selection.dart';
import 'package:swan_match/features/auth/presentation/widget/phone_feild.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/common/header_widget_with_icon.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  late TextEditingController _controller;
  String dialCode = "+93";
  final _formKey = GlobalKey<FormState>();

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
                      iconName: AssetConstants.phoneIcon,
                      title: context.tr.phoneVerificationTitle,
                      descn: context.tr.phoneVerificationDesc,
                    ),

                    CountrySelection(
                      onSelected: (value) {
                        setState(() {});
                        dialCode = value ?? "";
                      },
                    ),
                    SizedBox(height: 2.h),

                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: PhoneField(
                        dialCode: dialCode,
                        controller: _controller,
                        onChanged: (value) {
                          context.read<UiCubit>().setDisabled(
                            _formKey.currentState!.validate(),
                          );
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
                btnText: context.tr.continueText,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    context.read<UiCubit>().setLoading(true);
                    bool success = await context.read<AuthCubit>().sendPhoneOtp(
                      dialCode + _controller.text,
                    );
                    context.read<UiCubit>().setLoading(false);

                    if (success) {
                      context.push(RouteNames.phoneOtp);
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
