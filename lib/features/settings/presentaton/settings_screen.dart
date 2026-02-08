// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';

import 'package:swan_match/features/settings/presentaton/edit_settings_screen.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/shared/widgets/buttons/outline_button.dart';
import 'package:swan_match/shared/widgets/common/custom_app_bar.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool showOnline = true;
  bool emailVisible = false;
  bool mobileVisible = false;
  String photoVisibility = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadFromPrefs();
    });
  }

  Future<void> _loadFromPrefs() async {
    setState(() {
      showOnline = AppPrefs.getBool(PrefNames.showOnlineStatus);
      emailVisible = AppPrefs.getBool(PrefNames.showEmail);
      mobileVisible = AppPrefs.getBool(PrefNames.showPhone);

      final photoApi = AppPrefs.getString(PrefNames.photoVisibility);

      photoVisibility = photoApi.isEmpty
          ? context.tr.photoHiddenAfterMatch
          : photoApi.toUILabel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: context.tr.settingsTitle,
        onBackPressed: () => context.pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// EDIT PRIVACY
              OutlineButton(
                svgIcon: AssetConstants.privacyIcon,
                align: TextAlign.start,
                text: context.tr.editPrivacyVisibility,
                onPressed: () async {
                  await context.push(RouteNames.editSettings);
                  _loadFromPrefs();
                },
              ),

              const SizedBox(height: 20),

              MyText(
                text: context.tr.privacySummaryTitle,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),

              _summaryTile(
                title: context.tr.summaryOnlineStatus,
                value: showOnline
                    ? context.tr.statusVisible
                    : context.tr.statusHidden,
              ),

              _summaryTile(
                title: context.tr.summaryEmailVisibility,
                value: emailVisible
                    ? context.tr.statusVisible
                    : context.tr.statusHidden,
              ),

              _summaryTile(
                title: context.tr.summaryMobileVisibility,
                value: mobileVisible
                    ? context.tr.statusVisible
                    : context.tr.statusHidden,
              ),

              _summaryTile(
                title: context.tr.summaryPhotoVisibility,
                value: photoVisibility,
              ),

              const SizedBox(height: 30),

              /// MATCH PREFS
              OutlineButton(
                svgIcon: AssetConstants.lockIcon,
                align: TextAlign.start,
                text: context.tr.matchPreferences,
                onPressed: () async {
                  await context.push(RouteNames.preferenceSection);
                },
              ),

              const SizedBox(height: 20),
              OutlineButton(
                svgIcon: AssetConstants.languageIcon,
                align: TextAlign.start,
                text: context.tr.labelLanguages,
                onPressed: () async {
                  await context.push(RouteNames.language, extra: true);
                  // _loadFromPrefs();
                },
              ),
              const SizedBox(height: 20),

              MyText(
                text: context.tr.accountTitle,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),

              const SizedBox(height: 10),

              OutlineButton(
                svgIcon: AssetConstants.logoutIcon,
                align: TextAlign.start,
                text: context.tr.logout,
                onPressed: () async {
                  await context.read<StartupCubit>().logout();
                },
              ),

              const SizedBox(height: 20),

              OutlineButton(
                svgIcon: AssetConstants.deleteIcon,
                textColor: AppColors.primary,
                align: TextAlign.start,
                text: context.tr.deleteAccount,
                borderColor: AppColors.primary,
                onPressed: () {
                  context.push(RouteNames.preferenceSection);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- SUMMARY TILE ----------------

  Widget _summaryTile({required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: MyText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _chipBg(value),
              borderRadius: BorderRadius.circular(20),
            ),
            child: MyText(
              text: value,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _chipText(value),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- CHIP COLORS ----------------

  Color _chipBg(String value) {
    if (value == context.tr.statusVisible) {
      return AppColors.primary.withOpacity(0.12);
    }

    if (value == context.tr.statusHidden ||
        value == context.tr.photoHiddenAfterMatch) {
      return Colors.grey.withOpacity(0.15);
    }

    return AppColors.secondary.withOpacity(0.15);
  }

  Color _chipText(String value) {
    if (value == context.tr.statusVisible) {
      return AppColors.primary;
    }

    if (value == context.tr.statusHidden ||
        value == context.tr.photoHiddenAfterMatch) {
      return Colors.grey.shade700;
    }

    return AppColors.textSecondary;
  }
}
