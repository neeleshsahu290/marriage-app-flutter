import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swan_match/core/utils/extensions.dart';

import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/core/utils/user_match_helper.dart';
import 'package:swan_match/features/matches/presentation/widgets/contact_section_widget.dart';
import 'package:swan_match/shared/widgets/common/custom_app_bar.dart';
import 'package:swan_match/shared/widgets/common/header_image_scroll.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/shared/models/user.dart';
import 'package:swan_match/shared/widgets/box/tag_chip.dart';

class MatchDetailsScreen extends StatelessWidget {
  final User user;

  const MatchDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: user.fullName,
        onBackPressed: () => context.pop(),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderImageScroll(
              images: user.profilePhotos,
              status: user.photoVisibility ?? "visible_to_matches",
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: user.fullName ?? "",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),

                  if (user.location != null)
                    MyText(
                      text: user.location!,
                      color: AppColors.textSecondary,
                    ),

                  SizedBox(height: 1.h),

                  _buildSection(user.bio),

                  buildTopList(context, user),

                  SizedBox(height: 1.h),

                  _buildListSection(
                    context.tr.youAndPartner(
                      user.gender == "FEMALE" ? context.tr.her : context.tr.him,
                    ),
                    UserMatchHelper.getCommonImportantValues(user),
                  ),

                  _buildListSection(context.tr.habitsTitle, user.habits),

                  _buildListSection(context.tr.highlightsTitle, [
                    ...user.hobbies,
                    ...user.personalityTraits,
                  ]),

                  ContactSectionWidget(
                    phone: user.phone,
                    email: user.email,
                    showPhone: user.showPhone,
                    showEmail: user.showEmail,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TOP LIST ----------------

  Map<String, String> topList(User user) {
    final Map<String, String> tags = {
      AssetConstants.heightIcon: user.heightCm != null
          ? "${user.heightCm} cm"
          : "",

      AssetConstants.communityIcon: user.religion ?? "",

      AssetConstants.languageIcon: user.languagesKnown.isNotEmpty
          ? user.languagesKnown.join(", ")
          : "",

      AssetConstants.relationshipStatusIcon: user.maritalStatus ?? "",

      AssetConstants.professionIcon: user.profession ?? "",

      AssetConstants.educationIcon: user.educationLevel ?? "",
    };

    tags.removeWhere((_, value) => value.isEmpty);

    return tags;
  }

  Widget buildTopList(BuildContext context, User user) {
    final items = topList(user);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              SvgPicture.asset(entry.key, height: 30, width: 30),

              const SizedBox(width: 10),

              Expanded(
                child: MyText(
                  text: context.t(entry.value),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ---------------- BIO ----------------

  Widget _buildSection(String? content) {
    if (content == null || content.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 227, 227),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: MyText(fontSize: 14, fontWeight: FontWeight.w500, text: content),
      ),
    );
  }

  // ---------------- LIST SECTION ----------------

  Widget _buildListSection(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(text: title, fontSize: 18, fontWeight: FontWeight.w600),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: items.map((e) => TagChip(e)).toList(),
          ),
        ],
      ),
    );
  }
}
