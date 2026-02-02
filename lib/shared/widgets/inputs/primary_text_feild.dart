import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final Function()? onSuffixIconTap;
  final bool isPasswordField;
  final bool isReadOnly;
  final int? length;
  final Color backgroundColor;
  final double radius;
  final int? maxLines;
  final String? labelIcon;
  final List<TextInputFormatter>? inputFormatter;
  final Color? textColor;
  final String? label;
  final String? prrefixIcon;
  final String? initalValue;

  const PrimaryTextField({
    super.key,
    this.controller,
    this.inputType,
    this.obscureText = false,
    this.onChanged,
    this.labelIcon,
    this.validator,
    this.onSuffixIconTap,
    this.prrefixIcon,
    this.hintText,
    this.isPasswordField = false,
    this.isReadOnly = false,
    this.length,
    this.inputFormatter,
    this.radius = 8.0,
    this.maxLines,
    this.textColor = AppColors.textPrimary,
    this.backgroundColor = AppColors.cardBackground,
    this.label,
    this.initalValue
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        label != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      labelIcon != null
                          ? SizedBox(
                              height: 16,
                              width: 16,
                              child: UnconstrainedBox(
                                child: SvgPicture.asset(labelIcon!),
                              ),
                            )
                          : SizedBox.shrink(),

                      MyText(
                        text: label ?? "",
                        color: AppColors.textPrimary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: backgroundColor,
          ),

          child: TextFormField(
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            controller: controller,
            keyboardType: inputType,
            obscureText: obscureText,
            initialValue: initalValue,
            maxLines: maxLines,
            maxLength: length,
            onChanged: onChanged,
            onTapOutside: (event) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            readOnly: isReadOnly,
            validator: validator,
            inputFormatters: inputFormatter,
            decoration: buildInputDecoration(hintText),
          ),
        ),
      ],
    );
  }

  InputDecoration buildInputDecoration(String? hinttext) {
    return InputDecoration(
      isDense: false,

      hintText: hinttext,
      hintStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: AppColors.cardBackground, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: AppColors.cardBackground, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: AppColors.cardBackground, width: 1),
      ),
      suffixIconConstraints: isPasswordField
          ? const BoxConstraints(minHeight: 40.0)
          : const BoxConstraints(minWidth: 0, minHeight: 40.0),
      //   prefixIconConstraints: const BoxConstraints(
      //     maxHeight: 20,
      //     maxWidth: 36,
      //     minWidth: 36,
      //     minHeight: 20, // Match your icon height or slightly more
      //   ),
      //   prefix: prrefixIcon != null
      //       ? Padding(
      //           padding: const EdgeInsets.only(right: 8),
      //           child: SizedBox(
      //             width: 20,
      //             child: Column(
      //               mainAxisSize: MainAxisSize.max,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 SvgPicture.asset(
      //                   prrefixIcon!,
      //                   height: 20,
      //                   width: 20,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         )
      //       : null,

      //   suffixIcon: isPasswordField
      //       ? Container(
      //           width: 24,
      //           margin: const EdgeInsets.only(right: 10.0),
      //           child: InkWell(
      //             onTap: onSuffixIconTap,
      //             child: SvgPicture.asset(
      //               obscureText ? passwordHiddenIcon : passwordVisibleIcon,
      //             ),
      //           ),
      //         )
      //       : const SizedBox(),
    );
  }
}
