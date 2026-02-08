import 'package:flutter/widgets.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class TagChip extends StatelessWidget {
  final String name;
  const TagChip(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
        child: MyText(
          text: context.t(name),
          color: AppColors.primary,
          fontSize: 14,
        ),
      ),
    );
  }
}
