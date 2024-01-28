import 'package:envawareness/router/app_router.dart';
import 'package:envawareness/widgets/connectivity_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
