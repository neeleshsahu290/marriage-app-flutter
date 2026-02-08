import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class CustomSingleSlider extends StatefulWidget {
  final String label;
  final int min;
  final int max;
  final int defaultValue;
  final String unit;
  final ValueChanged<int>? onChanged;

  const CustomSingleSlider({
    super.key,
    required this.label,
    required this.min,
    required this.max,
    required this.defaultValue,
    required this.unit,
    this.onChanged,
  });

  @override
  State<CustomSingleSlider> createState() => _CustomSingleSliderState();
}

class _CustomSingleSliderState extends State<CustomSingleSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.defaultValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: "${widget.label} : ${_value.round()} ${widget.unit}",

          color: AppColors.textPrimary,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),

        const SizedBox(height: 10),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 20,

            activeTrackColor: Colors.black,

            inactiveTrackColor: Colors.grey.shade300,

            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 11),
            thumbColor: Colors.white,

            overlayShape: SliderComponentShape.noOverlay,

            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: _value,
            min: widget.min.toDouble(),
            max: widget.max.toDouble(),
            divisions: widget.max - widget.min,
            onChanged: (val) {
              setState(() {
                _value = val;
              });

              widget.onChanged?.call(val.round());
            },
          ),
        ),
      ],
    );
  }
}
