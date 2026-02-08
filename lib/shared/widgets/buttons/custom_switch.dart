import 'package:flutter/material.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class CustomSwitchTile extends StatefulWidget {
  final String title;
  final String description;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.description,
    required this.initialValue,
    this.onChanged,
  });

  @override
  State<CustomSwitchTile> createState() => _CustomSwitchTileState();
}

class _CustomSwitchTileState extends State<CustomSwitchTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _toggle(bool newValue) {
    setState(() {
      _value = newValue;
    });

    /// optional callback (prefs / api / logging)
    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// LEFT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: widget.title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 4),
                    MyText(
                      text: widget.description,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),

              /// RIGHT: Native Switch
              Switch(
                value: _value,
                onChanged: _toggle,
                activeThumbColor: AppColors.primary,
                inactiveThumbColor: AppColors.textSecondary,
                // ignore: deprecated_member_use
                inactiveTrackColor: AppColors.textSecondary.withOpacity(0.3),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
