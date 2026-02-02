import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/features/home/cubit/home_cubit.dart';
import 'package:swan_match/features/matches/provider/matches_cubit.dart';
import 'package:swan_match/match_status.dart';
import 'package:swan_match/shared/models/user.dart';
import 'package:swan_match/shared/widgets/box/tag_chip.dart';
import 'package:swan_match/shared/widgets/my_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileCard extends StatelessWidget {
  final User user;
  final CardType cardType;

  const ProfileCard({super.key, required this.user, required this.cardType});

  // ---------------- TAG BUILDER ----------------

  List<String> _buildTags() {
    return [
      user.profession ?? "",
      user.educationLevel ?? "",
      user.heightCm != null ? "${user.heightCm} cm" : "",
      user.maritalStatus ?? "",
      user.personalityTraits.isNotEmpty ? user.personalityTraits.first : "",

      // First two habits
      if (user.habits.isNotEmpty) user.habits[0],
      if (user.habits.length > 1) user.habits[1],

      // First hobby
      if (user.hobbies.isNotEmpty) user.hobbies.first,
    ].where((e) => e.isNotEmpty).toList();
  }

  // ---------------- MAIN UI ----------------

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        // height: double.infinity,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildImageSection(),

            GestureDetector(
              onTap: () {
                context.push(RouteNames.matchDetails, extra: user);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 1.h),

                    MyText(
                      text: user.fullName ?? "",
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),

                    if (user.location != null) MyText(text: user.location!),

                    SizedBox(height: 1.h),

                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: _buildTags()
                          .take(
                            cardType == CardType.recieved ? 4 : 6,
                          ) // ~2 lines on most screens
                          .map((tag) => TagChip(tag))
                          .toList(),
                    ),

                    SizedBox(height: 2.h),

                    _buildCardByType(context),
                    SizedBox(height: 2.h),

                    Align(
                      alignment: AlignmentGeometry.center,
                      child: MyText(
                        textAlignment: TextAlign.center,
                        text: 'Why this match?',
                        color: const Color.fromARGB(255, 237, 122, 151),

                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- IMAGE SECTION ----------------

  Widget _buildImageSection() {
    return SizedBox(
      height: 27.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              // imageUrl: user.profilePhotos.isNotEmpty
              //     ? user.profilePhotos.first
              //     : "",
              imageUrl: "https://picsum.photos/400/600",

              fit: BoxFit.cover,

              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade300),

              errorWidget: (_, __, ___) =>
                  const Center(child: Icon(Icons.person, size: 80)),
            ),

            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- CARD TYPE SWITCH ----------------

  Widget _buildCardByType(BuildContext context) {
    switch (cardType) {
      case CardType.recommend:
        return Row(
          children: [
            Expanded(
              child: _outlineButton(
                icon: AssetConstants.closeIcon,
                text: 'Pass',
                onClick: () {
                  context.read<HomeCubit>().passRequest(user.matchId ?? "");
                },
              ),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: _outlineButton(
                icon: AssetConstants.relationshipIcon,
                text: 'Intrested',
                isDark: true,
                onClick: () {
                  context.read<HomeCubit>().sendRequest(
                    user.matchId ?? "",
                    user.userId ?? "",
                  );
                },
              ),
            ),
          ],
        );

      case CardType.recieved:
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _outlineButton(
                    icon: AssetConstants.closeIcon,
                    text: 'Decline',
                    onClick: () {
                      context.read<MatchesCubit>().rejectRequest(
                        user.matchId ?? "",
                      );
                    },
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: _outlineButton(
                    icon: AssetConstants.relationshipIcon,
                    text: 'Accept',
                    isDark: true,
                    onClick: () {
                      context.read<MatchesCubit>().acceptRequest(
                        user.matchId ?? "",
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            _outlineButton(
              icon: AssetConstants.chatIcon,
              text: 'Accept and Chat Now',
              onClick: () {
                context.read<MatchesCubit>().acceptRequest(user.matchId ?? "");
              },
            ),
          ],
        );

      case CardType.accepted:
        return Row(
          children: [
            Expanded(
              child: _outlineButton(
                icon: AssetConstants.closeIcon,
                text: 'Remove',
                onClick: () {
                  context.read<MatchesCubit>().removeRequest(
                    user.matchId ?? "",
                  );
                },
              ),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: _outlineButton(
                icon: AssetConstants.chatIcon,
                text: 'Chat Now',
              ),
            ),
          ],
        );

      case CardType.sent:
        return _outlineButton(
          icon: AssetConstants.closeIcon,
          text: 'Revoke request from sent',
          onClick: () {
            context.read<MatchesCubit>().cancelRequest(user.matchId ?? "");
          },
        );
    }
  }

  // ---------------- BUTTON ----------------
  Widget _outlineButton({
    required String text,
    required String icon,
    bool isDark = false,
    VoidCallback? onClick,
  }) {
    return OutlinedButton(
      onPressed: onClick,
      style: OutlinedButton.styleFrom(
        backgroundColor: isDark ? AppColors.primary : AppColors.cardBackground,
        side: BorderSide(
          width: 1.5,
          color: isDark ? AppColors.primary : const Color(0xFFABACAF),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          icon == AssetConstants.closeIcon
              ? Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: SvgPicture.asset(
                    icon,
                    height: 12,
                    width: 12,
                    color: isDark
                        ? AppColors.textInverse
                        : AppColors.textPrimary,
                  ),
                )
              : SvgPicture.asset(
                  icon,
                  height: 20,
                  width: 20,
                  color: isDark ? AppColors.textInverse : AppColors.textPrimary,
                ),
          const SizedBox(width: 6),
          Expanded(
            child: MyText(
              text: text,
              textAlignment: TextAlign.center,
              color: isDark ? AppColors.textInverse : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
