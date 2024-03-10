import 'package:envawareness/constants/constants.dart';
import 'package:envawareness/controllers/app_controller.dart';
import 'package:envawareness/router/app_router.dart';
import 'package:envawareness/utils/common.dart';
import 'package:envawareness/widgets/connectivity_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  void _toggleTheme() {
    ref.read(darkModeProvider.notifier).state = !ref.read(darkModeProvider);
  }

  // This widget is the root of your application.
  ThemeData _buildTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;

    final baseTheme = ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      primaryColor: const Color(0xff79E077),
      colorScheme: isLight
          ? const ColorScheme.light(
              primary: Color(0xff79E077),
              secondary: Color(0xff298BE9),
              background: Color(0xffF9EFDC),
            )
          : const ColorScheme.dark(
              primary: Color.fromARGB(255, 107, 193, 106),
              secondary: Color(0xff298BE9),
              background: Color(0xff1a1a1a),
            ),
    );

    final languageCode = platformLocale.languageCode;

    return baseTheme.copyWith(
      textTheme: switch (languageCode) {
        'zh' => GoogleFonts.notoSansTcTextTheme(
            baseTheme.textTheme.copyWith(
              displayLarge: GoogleFonts.notoSansTc(
                textStyle: baseTheme.textTheme.displayLarge,
                fontWeight: FontWeight.w800,
              ),
              displayMedium: GoogleFonts.notoSansTc(
                textStyle: baseTheme.textTheme.displayMedium,
                fontWeight: FontWeight.w800,
              ),
              displaySmall: GoogleFonts.notoSansTc(
                textStyle: baseTheme.textTheme.displaySmall,
                fontWeight: FontWeight.w800,
              ),
              headlineLarge: GoogleFonts.notoSansTc(
                textStyle: baseTheme.textTheme.headlineLarge,
                fontWeight: FontWeight.w800,
              ),
              headlineMedium: GoogleFonts.notoSansTc(
                textStyle: baseTheme.textTheme.headlineMedium,
                fontWeight: FontWeight.w800,
              ),
              headlineSmall: GoogleFonts.notoSansTc(
                textStyle: baseTheme.textTheme.headlineSmall,
                fontWeight: FontWeight.w800,
              ),
              titleLarge: GoogleFonts.notoSansTc(
                textStyle: baseTheme.textTheme.titleLarge,
                fontWeight: FontWeight.w800,
              ),
              titleMedium: GoogleFonts.notoSansTc(
                textStyle: baseTheme.textTheme.titleMedium,
                fontWeight: FontWeight.w800,
              ),
              titleSmall: GoogleFonts.notoSansTc(
                textStyle: baseTheme.textTheme.titleSmall,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        _ => GoogleFonts.mPlusRounded1cTextTheme(
            baseTheme.textTheme.copyWith(
              displayLarge: GoogleFonts.mPlusRounded1c(
                textStyle: baseTheme.textTheme.displayLarge,
                fontWeight: FontWeight.w800,
              ),
              displayMedium: GoogleFonts.mPlusRounded1c(
                textStyle: baseTheme.textTheme.displayMedium,
                fontWeight: FontWeight.w800,
              ),
              displaySmall: GoogleFonts.mPlusRounded1c(
                textStyle: baseTheme.textTheme.displaySmall,
                fontWeight: FontWeight.w800,
              ),
              headlineLarge: GoogleFonts.mPlusRounded1c(
                textStyle: baseTheme.textTheme.headlineLarge,
                fontWeight: FontWeight.w800,
              ),
              headlineMedium: GoogleFonts.mPlusRounded1c(
                textStyle: baseTheme.textTheme.headlineMedium,
                fontWeight: FontWeight.w800,
              ),
              headlineSmall: GoogleFonts.mPlusRounded1c(
                textStyle: baseTheme.textTheme.headlineSmall,
                fontWeight: FontWeight.w800,
              ),
              titleLarge: GoogleFonts.mPlusRounded1c(
                textStyle: baseTheme.textTheme.titleLarge,
                fontWeight: FontWeight.w800,
              ),
              titleMedium: GoogleFonts.mPlusRounded1c(
                textStyle: baseTheme.textTheme.titleMedium,
                fontWeight: FontWeight.w800,
              ),
              titleSmall: GoogleFonts.mPlusRounded1c(
                textStyle: baseTheme.textTheme.titleSmall,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(appRouterProvider);
    final darMode = ref.watch(darkModeProvider);
    final appLocale = ref.watch(appLocaleProvider).value;

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: appLocale,
      theme: darMode
          ? _buildTheme(Brightness.dark)
          : _buildTheme(Brightness.light),
      builder: (
        BuildContext context,
        Widget? child,
      ) {
        if (child == null) {
          return const Material(
            child: Center(
              child: Text(
                'App launch failed.',
              ),
            ),
          );
        }

        return _listenConnectivity(child);
      },
    );
  }

  Widget _listenConnectivity(Widget child) {
    return ConnectivityDetector(
      child: child,
    );
  }
}
