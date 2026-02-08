//     core/router/app_router.dart

import 'package:go_router/go_router.dart';
import 'package:swan_match/core/di/service_locator.dart';
import 'package:swan_match/core/router/router_refresh_notifier.dart';
import 'package:swan_match/features/auth/cubit/auth_cubit.dart';
import 'package:swan_match/features/auth/cubit/ui_cubit.dart';
import 'package:swan_match/features/auth/presentation/create_password_screen.dart';
import 'package:swan_match/features/auth/presentation/email_otp_screen.dart';
import 'package:swan_match/features/auth/presentation/email_screen.dart';
import 'package:swan_match/features/auth/presentation/login_screen.dart';
import 'package:swan_match/features/chat/presentaion/chat_screen.dart';
import 'package:swan_match/features/home/cubit/home_cubit.dart';
import 'package:swan_match/features/home/pesentation/botton_nav_Scaffold.dart';
import 'package:swan_match/features/matches/presentation/match_details_screen.dart';
import 'package:swan_match/features/matches/presentation/matches_screen.dart';
import 'package:swan_match/features/matches/provider/matches_cubit.dart';
import 'package:swan_match/features/onboarding/cubit/onboarding_form_cubit.dart';
import 'package:swan_match/features/onboarding/presentation/screens/intent_screen.dart';
import 'package:swan_match/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:swan_match/features/settings/presentaton/preference_screen.dart';
import 'package:swan_match/features/profile/presentation/profile_screen.dart';
import 'package:swan_match/features/settings/cubit/settings_cubit.dart';
import 'package:swan_match/features/settings/presentaton/edit_settings_screen.dart';
import 'package:swan_match/features/settings/presentaton/settings_screen.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/features/setup/presentation/language_screen.dart';
import 'package:swan_match/features/auth/presentation/phone_screen.dart';
import 'package:swan_match/features/auth/presentation/phone_otp_screen.dart';
import 'package:swan_match/features/setup/presentation/splash_screen.dart';
import 'package:swan_match/features/home/pesentation/home_screen.dart';
import 'package:swan_match/features/setup/presentation/welcome_screen.dart';
import 'package:swan_match/shared/models/user.dart';

import 'route_names.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

GoRouter router = GoRouter(
  initialLocation: RouteNames.splash,

  refreshListenable: GoRouterRefreshNotifier(getIt<StartupCubit>()),

  redirect: (context, state) {
    final startup = context.read<StartupCubit>().state;

    if (!startup.splashFinished) {
      return RouteNames.splash;
    }

    if (!startup.isLoggedIn) {
      if (!startup.languageSelected) {
        return RouteNames.language;
      }

      if (!startup.welcomeSelected) {
        return RouteNames.welcome;
      }

      if (!startup.isEmailOtpSent) {
        return RouteNames.login;
      }

      return null;
    } else {
      if (!startup.isOnoarding) {
        if (!startup.intentSelected) {
          return RouteNames.intent;
        }

        if (!startup.isOnoarding) {
          return RouteNames.onboarding;
        }
      }
    }

    return null;
  },

  routes: [
    GoRoute(path: RouteNames.splash, builder: (_, __) => const SplashScreen()),

    GoRoute(
      path: RouteNames.language,
      builder: (context, state) {
        final bool isFromSettings = state.extra as bool? ?? false;

        return LanguageScreen(isFromSettings: isFromSettings);
      },
    ),

    GoRoute(
      path: RouteNames.welcome,
      builder: (_, __) => const WelcomeScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider.value(value: getIt<AuthCubit>(), child: child);
      },
      routes: [
        GoRoute(
          path: RouteNames.login,
          builder: (_, __) => BlocProvider(
            create: (context) => getIt<UiCubit>(),
            child: const LoginScreen(),
          ),
        ),

        GoRoute(
          path: RouteNames.phone,
          builder: (_, __) => BlocProvider(
            create: (context) => getIt<UiCubit>(),
            child: const PhoneScreen(),
          ),
        ),

        GoRoute(
          path: RouteNames.phoneOtp,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<UiCubit>(),
              child: PhoneOtpScreen(),
            );
          },
        ),

        GoRoute(
          path: RouteNames.email,
          builder: (_, __) => BlocProvider(
            create: (context) => getIt<UiCubit>(),
            child: const EmailScreen(),
          ),
        ),

        GoRoute(
          path: RouteNames.emailOtp,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<UiCubit>(),
              child: EmailOtpScreen(),
            );
          },
        ),

        GoRoute(
          path: RouteNames.createPassword,

          builder: (_, __) => BlocProvider(
            create: (context) => getIt<UiCubit>(),
            child: const CreatePasswordScreen(),
          ),
        ),
      ],
    ),
    GoRoute(path: RouteNames.intent, builder: (_, __) => const IntentScreen()),
    GoRoute(
      path: RouteNames.onboarding,
      builder: (context, state) {
        final bool isEdit = state.extra as bool? ?? false;

        return BlocProvider(
          create: (_) => getIt<OnboardingFormCubit>(),
          child: OnboardingScreen(isEdit: isEdit),
        );
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: RouteNames.home,
          builder: (context, state) => BlocProvider.value(
            value: getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: RouteNames.explore,
          builder: (context, state) => BlocProvider.value(
            value: getIt<MatchesCubit>(),
            child: const MatchesScreen(),
          ),
        ),
        GoRoute(path: RouteNames.chat, builder: (_, __) => const ChatScreen()),
        GoRoute(path: RouteNames.profile, builder: (_, __) => ProfileScreen()),
      ],
    ),
    GoRoute(
      path: RouteNames.matchDetails,
      builder: (context, state) {
        final user = state.extra as User;
        return MatchDetailsScreen(user: user);
      },
    ),

    GoRoute(path: RouteNames.settings, builder: (_, __) => SettingsScreen()),

    GoRoute(
      path: RouteNames.editSettings,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<SettingsCubit>(),
        child: const EditSettingsScreen(),
      ),
    ),

    GoRoute(
      path: RouteNames.preferenceSection,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<SettingsCubit>(),
        child: const PreferencesScreen(),
      ),
    ),
  ],
);
