import 'package:envawareness/router/app_router.dart';
import 'package:envawareness/widgets/connectivity_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

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
