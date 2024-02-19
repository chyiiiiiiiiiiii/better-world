import 'package:envawareness/router/app_router.dart';
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
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  // This widget is the root of your application.
  ThemeData _buildTheme(Brightness brightness) {
    final baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
    );
    return baseTheme.copyWith(
      scaffoldBackgroundColor: brightness == Brightness.light
          ? const Color.fromARGB(255, 229, 207, 171)
          : const Color(0xff1a1a1a),
      textTheme: GoogleFonts.mPlusRounded1cTextTheme(
        baseTheme.textTheme.copyWith(
          titleLarge: GoogleFonts.mPlusRounded1c(
            textStyle: baseTheme.textTheme.titleLarge,
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
          displaySmall: GoogleFonts.mPlusRounded1c(
            textStyle: baseTheme.textTheme.displaySmall,
            fontWeight: FontWeight.w800,
          ),
          displayMedium: GoogleFonts.mPlusRounded1c(
            textStyle: baseTheme.textTheme.displayMedium,
            fontWeight: FontWeight.w800,
          ),
          displayLarge: GoogleFonts.mPlusRounded1c(
            textStyle: baseTheme.textTheme.displayLarge,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Envawareness',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: _isDarkTheme
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
