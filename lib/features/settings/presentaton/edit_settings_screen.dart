import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/utils.dart';
import 'package:swan_match/features/settings/cubit/settings_cubit.dart';
import 'package:swan_match/features/settings/cubit/settings_state.dart';
import 'package:swan_match/shared/widgets/buttons/custom_switch.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/common/custom_app_bar.dart'
    show CustomAppBar;
import 'package:swan_match/shared/widgets/dropdown/custom_dropdowm.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class EditSettingsScreen extends StatefulWidget {
  const EditSettingsScreen({super.key});

  @override
  State<EditSettingsScreen> createState() => _EditSettingsScreenState();
}

class _EditSettingsScreenState extends State<EditSettingsScreen> {
  List<String> photosVisibilityList = [
    "Hidden (Only after match)",
    "Blurred Preview",
    "Visible to Matches",
  ];
  String photoVisibility = "Hidden";
  bool showOnline = true;
  bool emailVisible = false;
  bool mobileVisible = false;
  bool isEnableButton = false;
  _setEnbleButton() {
    if (isEnableButton) return;
    setState(() {
      isEnableButton = true;
    });
  }

  Future<void> _loadPrefs() async {
    final photo = AppPrefs.getString(PrefNames.photoVisibility);
    final online = AppPrefs.getBool(PrefNames.showOnlineStatus);
    final email = AppPrefs.getBool(PrefNames.showEmail);
    final phone = AppPrefs.getBool(PrefNames.showPhone);
    if (photoVisibility.isEmpty) {
      photoVisibility = "Hidden (Only after match)";
    } else {
      photoVisibility = photo.toUILabel;
    }

    showOnline = online;
    emailVisible = email;
    mobileVisible = phone;
  }

  @override
  void initState() {
    _loadPrefs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Edit Settings',
        onBackPressed: () => context.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headingWidget('Photos Settings', AssetConstants.cameraIcon),
              const SizedBox(height: 10),

              /// Photo Visibility
              CustomDropdown(
                dropdownList: photosVisibilityList,
                label: "Photo Visibility",
                hint: 'Select',
                initialSelected: photoVisibility,
                onSelected: (value) {
                  photoVisibility = value ?? "";
                  _setEnbleButton();
                },
              ),

              const SizedBox(height: 20),
              _headingWidget('Privacy & Safety', AssetConstants.privacyIcon),

              /// Show Online
              CustomSwitchTile(
                title: "Show Online Status",
                description: "Allow others to see when you're online",
                initialValue: showOnline,
                onChanged: (val) {
                  showOnline = val;
                  _setEnbleButton();
                },
              ),

              /// Email Visibility
              CustomSwitchTile(
                title: "Email Visibility",
                description: "Let matches see your email",
                initialValue: emailVisible,
                onChanged: (val) {
                  emailVisible = val;
                  _setEnbleButton();
                },
              ),

              /// Mobile Visibility
              CustomSwitchTile(
                title: "Mobile No. Visibility",
                description: "Let matches see your mobile number",
                initialValue: mobileVisible,
                onChanged: (val) {
                  mobileVisible = val;
                  _setEnbleButton();
                },
              ),

              const SizedBox(height: 30),

              /// SAVE BUTTON
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return PrimaryButton(
                    isLoading: state.isLoading,
                    btnText: "Save Changes",
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
      photoVisibility: photoVisibility.toApiValue,
      showOnline: showOnline,
    );
    if (isValue) {
      if (mounted) {
        Utils.showSuccess('Settings updated successfully');
        context.pop();
      }
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
    switch (this) {
      case "Hidden (Only after match)":
        return "hidden";
      case "Blurred Preview":
        return "blurred_preview";
      case "Visible to Matches":
        return "visible_to_matches";
      default:
        return "hidden";
    }
  }

  /// API value → UI label
  String get toUILabel {
    switch (this) {
      case "hidden":
        return "Hidden (Only after match)";
      case "blurred_preview":
        return "Blurred Preview";
      case "visible_to_matches":
        return "Visible to Matches";
      default:
        return "Hidden (Only after match)";
    }
  }
}
