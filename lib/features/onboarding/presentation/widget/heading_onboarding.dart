import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class HeadingOnboarding extends StatelessWidget {
  final String heading;
  final String desc;
  const HeadingOnboarding({
    super.key,
    required this.heading,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:  20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          MyText(text: heading, fontSize: 22, fontWeight: FontWeight.w600),
          SizedBox(height: 1.2.h),
      
          MyText(text: desc),
        ],
      ),
    );
  }
}
