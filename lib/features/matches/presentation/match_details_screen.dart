import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/shared/widgets/common/custom_app_bar.dart';
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
        onBackPressed: () {
          context.pop();
        },
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),

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

                  buildTopList(user),

                  // Wrap(
                  //   spacing: 8,
                  //   runSpacing: 6,
                  //   children: _buildTags(
                  //     user,
                  //   ).map((e) => TagChip(e)).toList(),
                  // ),
                  SizedBox(height: 1.h),

                  _buildListSection("Habits", user.habits),
                  _buildListSection("Highlights", [
                    ...user.hobbies,
                    ...user.personalityTraits,
                  ]),

                  _buildContactSection(user),
                  // _buildSection(
                  //   "Basic Info",
                  //   "${user.gender}, ${user.heightCm} cm",
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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

    // Remove empty values
    tags.removeWhere((key, value) => value.isEmpty);

    return tags;
  }

  Widget buildTopList(User user) {
    final items = topList(user);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              SvgPicture.asset(
                entry.key,
                height: 30,
                width: 30,
                //    color: AppColors.textSecondary,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: MyText(
                  text: entry.value,
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

  // ---------------- HEADER IMAGE ----------------

  Widget _buildHeaderImage() {
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: "https://picsum.photos/400/600",
        //  imageUrl: user.profilePhotos.isNotEmpty ? user.profilePhotos.first : "",
        fit: BoxFit.cover,

        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),

        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.person, size: 80)),
      ),
    );
  }

  // ---------------- TAGS ----------------

  // ---------------- SECTIONS ----------------

  Widget _buildSection(String? content) {
    if (content == null || content.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 227, 227),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: MyText(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            text: content,
          ),
        ),
      ),
    );
  }

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

  Widget _buildContactSection(User user) {
    if (user.phone == null && user.email == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(text: "Contact", fontSize: 18, fontWeight: FontWeight.w600),
        const SizedBox(height: 10),

        if (user.phone != null) _infoRow(AssetConstants.phoneIcon, user.phone!),

        if (user.email != null) _infoRow(AssetConstants.mail2Icon, user.email!),
      ],
    );
  }

  Widget _infoRow(String icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(icon, height: 20, width: 20),
              const SizedBox(width: 10),
              Expanded(
                child: MyText(
                  text: value,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
