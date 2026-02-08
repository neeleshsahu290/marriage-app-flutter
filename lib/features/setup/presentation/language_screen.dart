import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swan_match/core/locale/locale_cubit.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/features/auth/model/language_model.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class LanguageScreen extends StatefulWidget {
  final bool isFromSettings;

  const LanguageScreen({super.key, this.isFromSettings = false});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<Language> languages = [];
  @override
  void initState() {
    languages = [
      Language(key: 'en', name: 'English', flag: '🇺🇸'),
      // Language(key: 'es', name: 'Spanish', flag: '🇪🇸'),
      Language(key: 'fr', name: 'Français', flag: '🇫🇷'),
      Language(key: 'ar', name: 'العربية', flag: '🇸🇦'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: context.tr.selectLanguageTitle,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20),
            ...List.generate(languages.length, (index) {
              Language language = languages[index];

              return languageButton(language, () {
                context.read<LocaleCubit>().changeLocale(language.key);
                context.read<StartupCubit>().selectLanguage();
                if (widget.isFromSettings) context.pop();
                // Handle language selection
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget languageButton(Language language, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              MyText(text: language.flag, fontSize: 24),
              SizedBox(width: 40),
              Expanded(
                child: MyText(text: language.name, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
