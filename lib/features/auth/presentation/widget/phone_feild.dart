import 'package:flutter/material.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/core/utils/validator_utils.dart';
import 'package:swan_match/shared/widgets/inputs/primary_text_feild.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class PhoneField extends StatelessWidget {
  final String dialCode;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const PhoneField({
    super.key,
    required this.dialCode,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dial Code
        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: MyText(text: dialCode, fontWeight: FontWeight.w600),
          ),
        ),

        const SizedBox(width: 12),

        // Phone Number Input
        Flexible(
          flex: 4,
          child: PrimaryTextField(
            radius: 12,
            controller: controller,
            inputType: TextInputType.phone,
            hintText: context.tr.enterPhoneNumber,
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.tr.errorPhoneRequired;
              }
              if (!ValidatorUtils.isValidPhone(value)) {
                return context.tr.errorPhoneInvalid;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
