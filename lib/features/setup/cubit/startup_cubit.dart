import 'package:bloc/bloc.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/features/setup/cubit/startup_state.dart';
import 'package:swan_match/features/setup/data/startup_repository.dart';

class StartupCubit extends Cubit<StartupState> {
  final StartupRepository repo;

  StartupCubit(this.repo)
    : super(
        StartupState.initial(
          splashFinished: false,
          languageSelected: repo.isLanguageDone(),
          intentSelected: repo.isIntentDone(),
          welcomeSelected: repo.isWelcomeDone(),
          isLoggedIn: repo.isLoggedIn(),
          isOnoarding: repo.isOnBoardingDone(),
          isEmailOtpSent: repo.isLoggedIn(),
        ),
      );

  Future<void> completeSplash() async {
    emit(state.copyWith(splashFinished: true));
  }

  Future<void> selectLanguage(String languageCode) async {
    await repo.setLanguageDone(languageCode: languageCode);
    emit(state.copyWith(languageSelected: true));
  }

  Future<void> completeWelcome() async {
    await repo.setWelcomeDone();

    emit(state.copyWith(welcomeSelected: true));
  }

  Future<void> loginComplete() async {
    emit(state.copyWith(isLoggedIn: true));
  }

  Future<void> userCreated() async {
    emit(state.copyWith(isEmailOtpSent: true));
  }

  Future<void> setOnboardingDone() async {
    await repo.setOnboardingDone();
    emit(state.copyWith(isOnoarding: true));
  }

  Future<void> setIntentDone(String type) async {
    await AppPrefs.setString(PrefNames.marriagePriority, type);
    await repo.setIntentDone(intentType: type);
    emit(state.copyWith(intentSelected: true));
  }

  bool homeScreenMove() {
    return state.isLoggedIn && state.isOnoarding;
  }

  Future<void> logout() async {
    await repo.clearSession(); // clear prefs / token / flags

    emit(
      StartupState.initial(
        splashFinished: true, // splash already done
        languageSelected: repo.isLanguageDone(),
        intentSelected: false,
        welcomeSelected: false,
        isLoggedIn: false,
        isOnoarding: false,
        isEmailOtpSent: false,
      ),
    );
  }
}
