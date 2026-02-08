import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';

class StartupRepository {
  bool isSplash = false;

  StartupRepository();

  bool isWelcomeDone() {
    return AppPrefs.getBool(PrefNames.welcomeKey);
  }

  Future<void> setWelcomeDone() async {
    await AppPrefs.setBool(PrefNames.welcomeKey, true);
    isSplash = true;
  }

  bool isLanguageDone() {
    return AppPrefs.getBool(PrefNames.languageKey);
  }

  Future<void> clearSession() async {
    await AppPrefs.clear();
  }

  Future<void> setLanguageDone({required String languageCode}) async {
    await AppPrefs.setBool(PrefNames.languageKey, true);
    await AppPrefs.setString(PrefNames.languageCodeKey, languageCode);
  }

  String? getSelectedLanguage() {
    return null;
    //return PREFNAMES.prefs.getString(PREFNAMES.languageCodeKey);
  }

  bool isIntentDone() {
    return AppPrefs.getBool(PrefNames.intentKey);
  }

  Future<void> setIntentDone({required String intentType}) async {
    await AppPrefs.setBool(PrefNames.intentKey, true);
    // await PREFNAMES.prefs.setString(PREFNAMES.intentTypeKey, intentType);
  }

  // String? getSelectedIntent() {
  //   retauthurn PREFNAMES.prefs.getString(PREFNAMES.intentTypeKey);
  // }

  bool isLoggedIn() {
    return AppPrefs.getBool(PrefNames.isLoggedIn);
  }

  bool isOnBoardingDone() {
    return AppPrefs.getBool(PrefNames.onboardingCompleted);
  }

  Future<void> setOnboardingDone() async {
    await AppPrefs.setBool(PrefNames.onboardingCompleted, true);
    // await PrefNames.prefs.setString(PrefNames.intentTypeKey, intentType);
  }

  Future<void> clearStartup() async {
    await AppPrefs.remove(PrefNames.welcomeKey);
    await AppPrefs.remove(PrefNames.languageKey);
    await AppPrefs.remove(PrefNames.intentKey);
    await AppPrefs.remove(PrefNames.languageCodeKey);
    await AppPrefs.remove(PrefNames.intentTypeKey);
  }
}
