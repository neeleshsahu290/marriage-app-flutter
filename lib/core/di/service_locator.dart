import 'package:get_it/get_it.dart';
import 'package:swan_match/core/network/api_client.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/squlite_db_storage.dart';
import 'package:swan_match/features/auth/cubit/auth_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_cubit.dart';
import 'package:swan_match/features/auth/data/auth_repository.dart';
import 'package:swan_match/features/auth/data/auth_repository_impl.dart';
import 'package:swan_match/features/home/cubit/home_cubit.dart';
import 'package:swan_match/features/home/data/home_repository.dart';
import 'package:swan_match/features/home/data/home_repository_impl.dart';
import 'package:swan_match/features/matches/data/matches_repository.dart';
import 'package:swan_match/features/matches/data/matches_repository_impl.dart';
import 'package:swan_match/features/matches/provider/matches_cubit.dart';
import 'package:swan_match/features/onboarding/cubit/onboarding_form_cubit.dart';
import 'package:swan_match/features/onboarding/data/onboarding_repository.dart';
import 'package:swan_match/features/onboarding/data/onboarding_repository_impl.dart';
import 'package:swan_match/features/settings/cubit/settings_cubit.dart';
import 'package:swan_match/features/settings/data/settings_repository.dart';
import 'package:swan_match/features/settings/data/settings_repository_impl.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/features/setup/data/startup_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // Shared Prefs
  await AppPrefs.init();

  // Api
  getIt.registerLazySingleton(() => ApiClient());
  getIt.registerLazySingleton(() => SQLiteDbStorage());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => StartupRepository());

  // Cubits
  getIt.registerLazySingleton(() => StartupCubit(getIt<StartupRepository>()));
  getIt.registerFactory<OnboardingRepository>(
    () => OnboardingRepositoryImpl(getIt()),
  );

  getIt.registerFactory(
    () => OnboardingFormCubit(getIt<OnboardingRepository>()),
  );

  getIt.registerLazySingleton(() => AuthCubit(getIt<AuthRepository>()));

  getIt.registerFactory(() => UiCubit());

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<SQLiteDbStorage>(), getIt()),
  );

  getIt.registerLazySingleton(() => HomeCubit(getIt<HomeRepository>()));

  getIt.registerLazySingleton<MatchRepository>(
    () => MatchRepositoryImpl(getIt<SQLiteDbStorage>(), getIt()),
  );
  getIt.registerLazySingleton(() => MatchesCubit(getIt<MatchRepository>()));

  getIt.registerFactory<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt()),
  );

  getIt.registerFactory(() => SettingsCubit(getIt<SettingsRepository>()));
}
