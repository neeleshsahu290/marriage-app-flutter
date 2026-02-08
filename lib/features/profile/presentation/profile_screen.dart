import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/shared/models/user.dart';
import 'package:swan_match/shared/widgets/box/tag_chip.dart';
import 'package:swan_match/shared/widgets/buttons/outline_button.dart';
import 'package:swan_match/shared/widgets/common/header_image_scroll.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  Future<void> _loadProfile() async {
    final profileJson = AppPrefs.getString(PrefNames.userProfile);
    if (profileJson.isNotEmpty) {
      user = User.fromJson(jsonDecode(profileJson));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(body: Center(child: Text(context.tr.noProfileFound)));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderImageScroll(
                images: user!.profilePhotos,
                status: 'visible_to_matches',
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: user!.fullName ?? "",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),

                    if (user!.location != null)
                      MyText(
                        text: user!.location!,
                        color: AppColors.textSecondary,
                      ),

                    _bioSection(user!.bio),

                    const SizedBox(height: 14),

                    MyText(
                      text: context.tr.aboutMe,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),

                    const SizedBox(height: 8),

                    ..._buildProfileFields(user!).map((field) {
                      final label = field.keys.first;
                      final value = field.values.first;
                      return _infoRow(label, value);
                    }),

                    _buildListSection(context.tr.myHabits, user!.habits),

                    const SizedBox(height: 20),

                    OutlineButton(
                      text: context.tr.editProfileDetails,
                      onPressed: () {
                        context.push(RouteNames.onboarding, extra: true);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- PROFILE FIELDS ----------------

  List<Map<String, String?>> _buildProfileFields(User user) {
    return [
      {context.tr.labelPhone: user.phone},
      {context.tr.labelEmail: user.email},

      {context.tr.labelGender: context.t(user.gender ?? "")},

      {context.tr.labelDob: _formatDate(user.dob)},

      {
        context.tr.labelHeight: user.heightCm != null
            ? "${user.heightCm} cm"
            : null,
      },

      {context.tr.labelReligion: context.t(user.religion ?? "")},

      {context.tr.labelFaithLevel: context.t(user.religiousFaith ?? "")},

      {context.tr.labelMaritalStatus: context.t(user.maritalStatus ?? "")},

      {
        context.tr.labelHasChildren: user.hasChildren == true
            ? context.tr.yes
            : context.tr.no,
      },

      {context.tr.labelFamilyType: context.t(user.familyType ?? "")},

      {context.tr.labelParentsStatus: context.t(user.parentsStatus ?? "")},

      {context.tr.labelEducation: context.t(user.educationLevel ?? "")},

      {context.tr.labelProfession: context.t(user.profession ?? "")},

      {context.tr.labelLanguages: _joinTranslated(user.languagesKnown)},

      {context.tr.labelPersonality: _joinTranslated(user.personalityTraits)},

      {context.tr.labelHobbies: _joinTranslated(user.hobbies)},
    ];
  }

  // ---------------- ROW ITEM ----------------

  Widget _infoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40.w,
                child: MyText(
                  text: label,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Expanded(
                child: MyText(
                  text: value,
                  fontSize: 15,
                  textAlignment: TextAlign.end,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color.fromARGB(255, 212, 212, 212)),
      ],
    );
  }

  // ---------------- BIO ----------------

  Widget _bioSection(String? bio) {
    if (bio == null || bio.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: context.tr.bio,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 227, 227, 227),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: MyText(fontSize: 14, fontWeight: FontWeight.w500, text: bio),
          ),
        ],
      ),
    );
  }

  // ---------------- LIST SECTION ----------------

  Widget _buildListSection(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 20),
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

  // ---------------- HELPERS ----------------

  String _joinTranslated(List<dynamic>? values) {
    if (values == null || values.isEmpty) return '';

    return values.map((v) => context.t(v.toString())).join(', ');
  }

  String? _formatDate(DateTime? date) {
    if (date == null) return null;
    return "${date.day}/${date.month}/${date.year}";
  }
}
