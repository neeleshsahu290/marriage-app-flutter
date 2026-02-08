import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class CustomRangeSlider extends StatefulWidget {
  final String label;
  final int min;
  final int max;
  final int defaultMin;
  final int defaultMax;
  final String unit;
  final ValueChanged<RangeValues>? onChanged;

  const CustomRangeSlider({
    super.key,
    required this.label,
    required this.min,
    required this.max,
    required this.defaultMin,
    required this.defaultMax,
    this.unit = "",
    this.onChanged,
  });

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();
    _currentRange = RangeValues(
      widget.defaultMin.toDouble(),
      widget.defaultMax.toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text:
              "${widget.label} : ${_currentRange.start.round()} - ${_currentRange.end.round()} ${widget.unit}",

          color: AppColors.textPrimary,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),

        const SizedBox(height: 10),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 20,

            // 🖤 Selected part
            activeTrackColor: Colors.black,

            // ➖ Background strip
            inactiveTrackColor: Colors.grey.shade300,

            // ⚪ White circles
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 11,
            ),
            thumbColor: Colors.white,

            // No glow
            overlayShape: SliderComponentShape.noOverlay,

            // Rounded bar
            rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
          ),
          child: RangeSlider(
            padding: EdgeInsets.zero,
            values: _currentRange,
            min: widget.min.toDouble(),
            max: widget.max.toDouble(),
            divisions: widget.max - widget.min,
            onChanged: (values) {
              setState(() {
                _currentRange = values;
              });

              widget.onChanged?.call(values);
            },
          ),
        ),
      ],
    );
  }
}
