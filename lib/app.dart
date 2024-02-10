import 'package:envawareness/router/app_router.dart';
import 'package:envawareness/widgets/connectivity_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    init();
  }

  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  // This widget is the root of your application.
  ThemeData _buildTheme(Brightness brightness) {
    var baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
    );
    return baseTheme.copyWith(
      scaffoldBackgroundColor: brightness == Brightness.light
          ? const Color(0xfff6f8e7)
          : const Color(0xff1a1a1a),
      textTheme:
          GoogleFonts.mPlusRounded1cTextTheme(baseTheme.textTheme.copyWith(
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
      )),
    );
  }

  void init() {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: appRouter,
        theme: _isDarkTheme
            ? _buildTheme(Brightness.dark)
            : _buildTheme(Brightness.light),
        debugShowCheckedModeBanner: false,
        title: 'Envawareness',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
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

          child = _listenConnectivity(child);

          return child;
        });
  }

  Widget _listenConnectivity(Widget child) {
    return ConnectivityDetector(
      child: child,
    );
  }
}
