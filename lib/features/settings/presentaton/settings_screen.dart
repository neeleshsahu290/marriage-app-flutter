// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
// import 'package:swan_match/features/settings/cubit/settings_cubit.dart';
// import 'package:swan_match/features/settings/cubit/settings_state.dart';
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
  String photoVisibility = "Hidden (Only after match)";

  @override
  void initState() {
    super.initState();
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    setState(() {
      showOnline = AppPrefs.getBool(PrefNames.showOnlineStatus);
      emailVisible = AppPrefs.getBool(PrefNames.showEmail);
      mobileVisible = AppPrefs.getBool(PrefNames.showPhone);

      photoVisibility = (AppPrefs.getString(
        PrefNames.photoVisibility,
      )).toUILabel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Settings',
        onBackPressed: () => context.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Navigate to edit screen
            OutlineButton(
              svgIcon: AssetConstants.privacyIcon,
              align: TextAlign.start,
              text: 'Edit Privacy & Visibility',
              onPressed: () async {
                await context.push(RouteNames.editSettings);
                _loadFromPrefs();
                if (mounted) {
                  setState(() {});
                }
              },
            ),

            const SizedBox(height: 20),
            MyText(
              text: 'Privacy & Visibility Summary',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            // SUMMARY CARD
            _summaryTile(
              title: 'Online Status',
              value: showOnline ? 'Visible' : 'Hidden',
            ),
            _summaryTile(
              title: 'Email Visibility',
              value: emailVisible ? 'Visible' : 'Hidden',
            ),
            _summaryTile(
              title: 'Mobile Visibility',
              value: mobileVisible ? 'Visible' : 'Hidden',
            ),
            _summaryTile(title: 'Photo Visibility', value: photoVisibility),

            const SizedBox(height: 30),
            MyText(text: 'Account', fontSize: 18, fontWeight: FontWeight.w500),
            const SizedBox(height: 10),

            OutlineButton(
              svgIcon: AssetConstants.logoutIcon,
              align: TextAlign.start,
              text: 'Log Out',
              onPressed: () async {
                await context.read<StartupCubit>().logout();
              },
            ),

            const SizedBox(height: 20),
            OutlineButton(
              svgIcon: AssetConstants.deleteIcon,
              textColor: AppColors.primary,
              align: TextAlign.start,
              text: 'Delete Account',
              borderColor: AppColors.primary,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

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
          /// Title
          Expanded(
            child: MyText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          /// Status chip
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

  Color _chipBg(String value) {
    if (value.toLowerCase().contains('visible')) {
      return AppColors.primary.withOpacity(0.12);
    }
    if (value.toLowerCase().contains('hidden')) {
      return Colors.grey.withOpacity(0.15);
    }
    return AppColors.secondary.withOpacity(0.15);
  }

  Color _chipText(String value) {
    if (value.toLowerCase().contains('visible')) {
      return AppColors.primary;
    }
    if (value.toLowerCase().contains('hidden')) {
      return Colors.grey.shade700;
    }
    return AppColors.textSecondary;
  }
}
