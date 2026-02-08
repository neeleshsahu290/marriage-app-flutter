import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/core/utils/utils.dart';
import 'package:swan_match/features/settings/cubit/settings_cubit.dart';
import 'package:swan_match/features/settings/cubit/settings_state.dart';
import 'package:swan_match/shared/widgets/buttons/custom_switch.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/common/custom_app_bar.dart'
    show CustomAppBar;
import 'package:swan_match/shared/widgets/dropdown/custom_dropdowm.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

import '../../../main.dart';

class EditSettingsScreen extends StatefulWidget {
  const EditSettingsScreen({super.key});

  @override
  State<EditSettingsScreen> createState() => _EditSettingsScreenState();
}

class _EditSettingsScreenState extends State<EditSettingsScreen> {
  List<String> photosVisibilityList = [];

  String? photoVisibility;
  bool showOnline = true;
  bool emailVisible = false;
  bool mobileVisible = false;
  bool isEnableButton = false;

  void _setEnableButton() {
    if (isEnableButton) return;
    setState(() => isEnableButton = true);
  }

  _loadPrefs() {
    final photo = AppPrefs.getString(PrefNames.photoVisibility);

    photoVisibility = photo.isEmpty
        ? context.tr.photoHiddenAfterMatch
        : photo.toUILabel;

    showOnline = AppPrefs.getBool(PrefNames.showOnlineStatus);
    emailVisible = AppPrefs.getBool(PrefNames.showEmail);
    mobileVisible = AppPrefs.getBool(PrefNames.showPhone);
    // 🔍 LOG ALL PREF VALUES
    log("---- Loaded Preferences ----");
    log("Photo Visibility (raw): $photo");
    log("Photo Visibility (ui): $photoVisibility");
    log("Show Online Status: $showOnline");
    log("Email Visible: $emailVisible");
    log("Mobile Visible: $mobileVisible");
    log("----------------------------");
  }

  @override
  void initState() {
    photosVisibilityList = [
      globalContext.tr.photoHiddenAfterMatch,
      globalContext.tr.photoBlurredPreview,
      globalContext.tr.photoVisibleToMatches,
    ];

    _loadPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: context.tr.editSettingsTitle,
        onBackPressed: () => context.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headingWidget(
                context.tr.photosSettingsTitle,
                AssetConstants.cameraIcon,
              ),
              const SizedBox(height: 10),

              /// PHOTO VISIBILITY
              CustomDropdown(
                dropdownList: photosVisibilityList,
                label: context.tr.photoVisibilityLabel,
                hint: context.tr.select,
                initialSelected: photoVisibility,
                onSelected: (value) {
                  photoVisibility = value ?? "";
                  _setEnableButton();
                },
              ),

              const SizedBox(height: 20),

              _headingWidget(
                context.tr.privacySafetyTitle,
                AssetConstants.privacyIcon,
              ),

              /// SHOW ONLINE
              CustomSwitchTile(
                title: context.tr.showOnlineStatus,
                description: context.tr.showOnlineDesc,
                initialValue: showOnline,
                onChanged: (val) {
                  showOnline = val;
                  _setEnableButton();
                },
              ),

              /// EMAIL VISIBILITY
              CustomSwitchTile(
                title: context.tr.emailVisibilityTitle,
                description: context.tr.emailVisibilityDesc,
                initialValue: emailVisible,
                onChanged: (val) {
                  emailVisible = val;
                  _setEnableButton();
                },
              ),

              /// MOBILE VISIBILITY
              CustomSwitchTile(
                title: context.tr.mobileVisibilityTitle,
                description: context.tr.mobileVisibilityDesc,
                initialValue: mobileVisible,
                onChanged: (val) {
                  mobileVisible = val;
                  _setEnableButton();
                },
              ),

              const SizedBox(height: 30),

              /// SAVE BUTTON
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return PrimaryButton(
                    isLoading: state.isLoading,
                    btnText: context.tr.saveChanges,
                    disablePadding: true,
                    onPressed: state.isLoading ? null : _saveSettings,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSettings() async {
    bool isValue = await context.read<SettingsCubit>().updateSettings(
      emailVisible: emailVisible,
      mobileVisible: mobileVisible,
      photoVisibility: photoVisibility?.toApiValue ?? "",
      showOnline: showOnline,
    );

    if (isValue && mounted) {
      Utils.showSuccess(context.tr.settingsUpdated);
      context.pop();
    }
  }

  Widget _headingWidget(String name, String icon) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 10),
        MyText(text: name, fontSize: 18, fontWeight: FontWeight.w500),
      ],
    );
  }
}

extension PhotoVisibilityX on String {
  /// UI label → API value
  String get toApiValue {
    if (this == globalContext.tr.photoHiddenAfterMatch) return "hidden";
    if (this == globalContext.tr.photoBlurredPreview) return "blurred_preview";
    if (this == globalContext.tr.photoVisibleToMatches) {
      return "visible_to_matches";
    }
    return "hidden";
  }

  /// API value → localized UI label
  String get toUILabel {
    switch (this) {
      case "hidden":
        return globalContext.tr.photoHiddenAfterMatch;
      case "blurred_preview":
        return globalContext.tr.photoBlurredPreview;
      case "visible_to_matches":
        return globalContext.tr.photoVisibleToMatches;
      default:
        return globalContext.tr.photoHiddenAfterMatch;
    }
  }
}
