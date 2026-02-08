import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class MultipleSelect extends StatefulWidget {
  final String label;
  final String? labelIcon;
  final List<String>? initialSelectedItems;
  final List<String> items;
  final int? max;
  final ValueChanged<List<String>>? onChanged;

  const MultipleSelect({
    super.key,
    required this.label,
    this.labelIcon,
    required this.items,
    this.onChanged,
    this.initialSelectedItems,
    this.max,
  });

  @override
  State<MultipleSelect> createState() => _MultipleSelectState();
}

class _MultipleSelectState extends State<MultipleSelect> {
  final Set<int> _selectedIndexes = {};

  @override
  void initState() {
    super.initState();

    if (widget.initialSelectedItems != null) {
      for (int i = 0; i < widget.items.length; i++) {
        if (widget.initialSelectedItems!.contains(widget.items[i])) {
          _selectedIndexes.add(i);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LABEL
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.labelIcon != null && widget.labelIcon!.isNotEmpty) ...[
                SvgPicture.asset(widget.labelIcon!, height: 16, width: 16),
                const SizedBox(width: 6),
              ],
              MyText(
                text: widget.label,
                color: AppColors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),

        // CHIPS
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(widget.items.length, (index) {
            final isSelected = _selectedIndexes.contains(index);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedIndexes.remove(index);
                  } else {
                    if (widget.max != null &&
                        widget.max! >= _selectedIndexes.length) {
                      _selectedIndexes.add(index);
                    } else if (widget.max == null) {
                      _selectedIndexes.add(index);
                    }
                  }
                });

                widget.onChanged?.call(
                  _selectedIndexes.map((i) => widget.items[i]).toList(),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16,
                ),
                child: MyText(
                  text: context.t(widget.items[index]),
                  color: isSelected
                      ? AppColors.textInverse
                      : AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
