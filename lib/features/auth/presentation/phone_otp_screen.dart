// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/features/auth/cubit/auth_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_state.dart';
import 'package:swan_match/features/auth/presentation/widget/pinfeild_.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

// ignore: must_be_immutable
class PhoneOtpScreen extends StatelessWidget {
  PhoneOtpScreen({super.key});

  final _formkey = GlobalKey<FormState>();

  final _isvalidOtp = ValueNotifier<bool>(false);

  String _otp = '';

  @override
  Widget build(BuildContext context) {
    String phone = context.read<AuthCubit>().state.phone;
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
                    text: context.tr.enterVerificationCode,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 2.h),
                  MyText(
                    text: context.tr.verificationCodeDesc,
                    color: AppColors.textSecondary,
                    textAlignment: TextAlign.center,
                  ),

                  SizedBox(height: 2.h),
                  MyText(
                    text: phone,
                    textAlignment: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 3.h),

                  Form(
                    key: _formkey,

                    child: PinInputFeild(
                      onChanged: (value) {
                        _otp = value;
                        context.read<UiCubit>().setDisabled(
                          _formkey.currentState!.validate(),
                        );
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
                btnText: context.tr.confirm,
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    context.read<UiCubit>().setLoading(true);
                    bool success = await context
                        .read<AuthCubit>()
                        .verifyPhoneOtp(otp: _otp);
                    context.read<UiCubit>().setLoading(false);

                    if (success) {
                      context.pushReplacement(RouteNames.email);
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
