// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/features/auth/cubit/auth_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_state.dart';
import 'package:swan_match/features/auth/presentation/widget/pinfeild_.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

// ignore: must_be_immutable
class EmailOtpScreen extends StatelessWidget {
  EmailOtpScreen({super.key});

  final _formkey = GlobalKey<FormState>();

  String _otp = "";

  @override
  Widget build(BuildContext context) {
    String email = context.read<AuthCubit>().state.email;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                    text: "Enter Verification Code",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 2.h),
                  MyText(
                    text: "We'll send you a code to verify your Email",
                    color: AppColors.textSecondary,
                    textAlignment: TextAlign.center,
                  ),

                  SizedBox(height: 2.h),
                  MyText(
                    text: email,
                    textAlignment: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 3.h),

                  Form(
                    key: _formkey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    child: PinInputFeild(
                      onChanged: (value) {
                        _otp = value;
                        context.read<UiCubit>().setDisabled(
                          _formkey.currentState!.validate(),
                        );
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'PIN is required';
                        }
                        if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                          return 'Enter a valid 6-digit PIN';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 10.h),
                ],
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
                  if (_formkey.currentState!.validate()) {
                    context.read<UiCubit>().setLoading(true);
                    bool success = await context
                        .read<AuthCubit>()
                        .verifyEmailOtp(otp: _otp);
                    context.read<UiCubit>().setLoading(false);

                    if (success) {
                      context.pushReplacement(RouteNames.createPassword);
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
