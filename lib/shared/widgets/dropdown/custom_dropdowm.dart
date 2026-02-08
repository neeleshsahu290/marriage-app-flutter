import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class CustomDropdown extends StatefulWidget {
  final ValueChanged<String?>? onSelected;
  final String label;
  final String? labelIcon;
  final List<String> dropdownList;
  final String? hint;
  final String? initialSelected;
  final bool enabled;

  const CustomDropdown({
    super.key,
    this.onSelected,
    required this.dropdownList,
    required this.label,
    this.labelIcon,
    this.hint,
    this.initialSelected,
    this.enabled = false,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.initialSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              widget.labelIcon != null
                  ? SizedBox(
                      height: 16,
                      width: 16,
                      child: UnconstrainedBox(
                        child: SvgPicture.asset(widget.labelIcon!),
                      ),
                    )
                  : SizedBox.shrink(),

              MyText(
                text: widget.label,
                color: AppColors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),

        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.cardBackground,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,

              hint: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.labelIcon != null &&
                      widget.labelIcon!.isNotEmpty) ...[
                    SvgPicture.asset(widget.labelIcon!, height: 16, width: 16),
                    const SizedBox(width: 8),
                  ],
                  MyText(
                    text: widget.hint ?? 'Select',
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                  ),
                ],
              ),

              value: _selectedItem,

              items: widget.dropdownList.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: MyText(
                    text: context.t(item),
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),

              onChanged: widget.enabled
                  ? (String? value) {
                      setState(() {
                        _selectedItem = value;
                      });
                      widget.onSelected?.call(value);
                    }
                  : null,

              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 16),
                height: 50,
              ),
              menuItemStyleData: const MenuItemStyleData(height: 48),
              dropdownStyleData: DropdownStyleData(),
            ),
          ),
        ),
      ],
    );
  }
}
