import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class DOBPickerField extends StatefulWidget {
  final String label;
  final String? labelIcon;

  final Function(String)? onChanged;

  final String? initialDate;

  const DOBPickerField({
    super.key,
    required this.label,
    this.labelIcon,
    this.onChanged,
    this.initialDate,
  });

  @override
  State<DOBPickerField> createState() => _DOBPickerFieldState();
}

class _DOBPickerFieldState extends State<DOBPickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    if (widget.initialDate != null) {
      try {
        int millisec = int.parse(widget.initialDate ?? "");
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisec);
        _selectedDate = dateTime;
      } catch (e) {}
    }

    super.initState();
  }

  Future<void> _pickDate(BuildContext context) async {
    log("hello11222");
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,

      initialDate: _selectedDate ?? DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 18), // 18+ restriction
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });

      // final formatted =
      //     "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

      widget.onChanged?.call(pickedDate.millisecondsSinceEpoch.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label
        Row(
          children: [
            if (widget.labelIcon != null && widget.labelIcon!.isNotEmpty) ...[
              SvgPicture.asset(widget.labelIcon!, height: 16, width: 16),
              const SizedBox(width: 6),
            ],
            MyText(
              text: widget.label,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        const SizedBox(height: 6),

        /// Picker Field
        GestureDetector(
          onTap: () => _pickDate(context),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.cardBackground,
            ),
            child: Row(
              children: [
                Expanded(
                  child: MyText(
                    text: _selectedDate == null
                        ? "Select date"
                        : "${_selectedDate!.day.toString().padLeft(2, '0')}/"
                              "${_selectedDate!.month.toString().padLeft(2, '0')}/"
                              "${_selectedDate!.year}",
                    color: _selectedDate == null
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.calendar_month,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
