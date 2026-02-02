import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';

class StartupRepository {
  bool isSplash = false;
  // Storage keys
  static const _welcomeKey = 'startup_welcome_done';
  static const _languageKey = 'startup_language_selected';
  static const _intentKey = 'startup_intent_selected';
  static const _languageCodeKey = 'startup_language_code';
  static const _intentTypeKey = 'startup_intent_type';

  StartupRepository();

  bool isWelcomeDone() {
    return AppPrefs.getBool(_welcomeKey);
  }

  Future<void> setWelcomeDone() async {
    await AppPrefs.setBool(_welcomeKey, true);
    isSplash = true;
  }

  bool isLanguageDone() {
    return AppPrefs.getBool(_languageKey);
  }

  Future<void> clearSession() async {
    await AppPrefs.clear();
  }

  Future<void> setLanguageDone({required String languageCode}) async {
    await AppPrefs.setBool(_languageKey, true);
    await AppPrefs.setString(_languageCodeKey, languageCode);
  }

  String? getSelectedLanguage() {
    return null;
    //return _prefs.getString(_languageCodeKey);
  }

  bool isIntentDone() {
    return AppPrefs.getBool(_intentKey);
  }

  Future<void> setIntentDone({required String intentType}) async {
    await AppPrefs.setBool(_intentKey, true);
    // await _prefs.setString(_intentTypeKey, intentType);
  }

  // String? getSelectedIntent() {
  //   retauthurn _prefs.getString(_intentTypeKey);
  // }

  bool isLoggedIn() {
    return AppPrefs.getBool(PrefNames.isLoggedIn);
  }

  bool isOnBoardingDone() {
    return AppPrefs.getBool(PrefNames.isOnboardingCompleted);
  }

  Future<void> setOnboardingDone() async {
    await AppPrefs.setBool(PrefNames.isOnboardingCompleted, true);
    // await _prefs.setString(_intentTypeKey, intentType);
  }

  Future<void> clearStartup() async {
    await AppPrefs.remove(_welcomeKey);
    await AppPrefs.remove(_languageKey);
    await AppPrefs.remove(_intentKey);
    await AppPrefs.remove(_languageCodeKey);
    await AppPrefs.remove(_intentTypeKey);
  }
}
