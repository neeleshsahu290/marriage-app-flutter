import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/inputs/primary_text_feild.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class HeightBottomSheetField extends StatefulWidget {
  final String label;
  final ValueChanged<String>? onSelected;
  final String? initalValue;

  const HeightBottomSheetField({
    super.key,
    required this.label,
    this.onSelected,
    this.initalValue,
  });

  @override
  State<HeightBottomSheetField> createState() => _HeightBottomSheetFieldState();
}

class _HeightBottomSheetFieldState extends State<HeightBottomSheetField> {
  String? _selectedHeight;

  @override
  void initState() {
    super.initState();
    _selectedHeight = widget.initalValue;
  }

  void _openHeightSheet(BuildContext context) {
    final heights = List.generate(
      37,
      (i) => "${(4 + (i ~/ 12))}'${(i % 12)}\"",
    );

    String tempHeight = _selectedHeight ?? "5'6\"";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.45, // 🔥 CONTROL HEIGHT
          child: Column(
            children: [
              const SizedBox(height: 12),

              /// Drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              const SizedBox(height: 16),

              /// Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(text: "Height"),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),

                    // TextButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       _selectedHeight = tempHeight;
                    //     });
                    //     widget.onSelected?.call(tempHeight);
                    //     Navigator.pop(context);
                    //   },
                    //   child: const Text("Done"),
                    // ),
                  ],
                ),
              ),

              //  const Divider(),
              Divider(
                color: const Color.fromARGB(255, 232, 232, 232),
                height: 0.4,
                thickness: 0.4,
              ),

              /// Height Picker
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IgnorePointer(
                      child: Container(
                        height: 48,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(8),
                          //  border: Border.all(color: AppColors.border, width: 1),
                        ),
                      ),
                    ),

                    /// Wheel
                    ListWheelScrollView.useDelegate(
                      itemExtent: 48,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        tempHeight = heights[index];
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: heights.length,
                        builder: (context, index) {
                          return Center(
                            child: MyText(
                              text: heights[index],
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ),

                    /// 🔥 Selected Item Highlight
                  ],
                ),
              ),
              PrimaryButton(
                height: 50,
                btnText: 'Save',
                cornerRadius: 30,
                onPressed: () {
                  setState(() {
                    _selectedHeight = tempHeight;
                  });
                  widget.onSelected?.call(tempHeight);
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: widget.label,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 6),

        GestureDetector(
          onTap: () => _openHeightSheet(context),
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
                    text: _selectedHeight ?? "Select height",
                    color: _selectedHeight == null
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_up),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
