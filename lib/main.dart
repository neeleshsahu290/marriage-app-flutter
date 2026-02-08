import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:swan_match/core/di/service_locator.dart';
import 'package:swan_match/core/locale/locale_cubit.dart';
import 'package:swan_match/core/locale/locale_state.dart';
// ignore: depend_on_referenced_packages
import 'package:swan_match/core/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/utils.dart';
import 'package:swan_match/features/setup/cubit/startup_cubit.dart';
import 'package:swan_match/l10n/app_localizations.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

BuildContext get globalContext => snackbarKey.currentContext!;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDI(); // GetIt
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<StartupCubit>()),
        BlocProvider(create: (_) => getIt<LocaleCubit>()),
      ],
      child: const MarriageApp(),
    ),
  );
}

// class App extends ConsumerWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ResponsiveSizer(
//       builder: (context, orientation, screenType) {
//         final router = ref.watch(goRouterProvider);

//         return MaterialApp.router(
//           debugShowCheckedModeBanner: false,
//           routerConfig: router,
//         );
//       },
//     );
//   }
// }

class MarriageApp extends StatelessWidget {
  const MarriageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return MaterialApp.router(
              scaffoldMessengerKey: snackbarKey,

              // 🌍 Dynamic locale from Bloc
              locale: state.locale,

              supportedLocales: const [
                Locale('en'),
                Locale('fr'),
                Locale('ar'),
              ],

              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              title: 'Marriage App',
              debugShowCheckedModeBanner: false,
              routerConfig: router,

              theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,

                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primary,
                  brightness: Brightness.light,
                ),

                scaffoldBackgroundColor: AppColors.background,

                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),

                textTheme: const TextTheme(
                  bodyMedium: TextStyle(color: Colors.black),
                  bodySmall: TextStyle(color: Colors.black54),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
