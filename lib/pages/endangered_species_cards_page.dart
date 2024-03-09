import 'dart:ui';

import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:envawareness/constants/endangered_specise_data.dart';
import 'package:envawareness/controllers/google_wallet_controller.dart';
import 'package:envawareness/data/endangered_species_info.dart';
import 'package:envawareness/data/google_wallet_pass_property.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/catch_game_page.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_io/io.dart';

class EndangeredSpeciesCardsPage extends ConsumerWidget {
  const EndangeredSpeciesCardsPage({super.key});

  static const routePath = '/endangered-species-cards';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final playInfo = ref.watch(playControllerProvider).requireValue.playInfo;
    final ownedCardCount = playInfo.ownedAnimalCardIndexes.length;
    final totalSpeciesCount = endangeredSpeciesList.length;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  l10n.endangeredSpeciesISaved,
                  style: context.textTheme.titleLarge,
                ),
                Gaps.h12,
                Text.rich(
                  TextSpan(
                    text: '$ownedCardCount🦕',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                    children: [
                      TextSpan(
                        text: '/$totalSpeciesCount',
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Gaps.h12,
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: context.paddingBottom,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: endangeredSpeciesList.length,
                    itemBuilder: (context, index) {
                      final species = endangeredSpeciesList[index];
                      final isOwned =
                          playInfo.ownedAnimalCardIndexes.contains(index);

                      return AppTap(
                        onTap: () {
                          showSpeciesCardDialog(
                            context,
                            isOwned: isOwned,
                            info: species,
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: ImageFiltered(
                                  imageFilter: isOwned
                                      ? ImageFilter.blur()
                                      : ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: species.image,
                                        color: isOwned
                                            ? null
                                            : Colors.black.withOpacity(1),
                                        colorBlendMode: BlendMode.color,
                                        // placeholder: (context, url) => const Center(
                                        //   child: CircularProgressIndicator(),
                                        // ),
                                        width: constraints.maxWidth,
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              species.translatedName,
                              style: context.textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const AppCloseButton(),
          ],
        ),
      ),
    );
  }
}

Future<void> showSpeciesCardDialog(
  BuildContext context, {
  required EndangeredSpeciesInfo info,
  bool isOwned = true,
  bool canNavigateSpeciesPage = false,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return SpeciesCard(
        isOwned: isOwned,
        info: info,
        canNavigateSpeciesPage: canNavigateSpeciesPage,
      );
    },
  );
}

class SpeciesCard extends ConsumerWidget {
  const SpeciesCard({
    required this.isOwned,
    required this.info,
    this.canNavigateSpeciesPage = false,
    super.key,
  });
  final bool isOwned;
  final bool canNavigateSpeciesPage;
  final EndangeredSpeciesInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final showGoogleWallet = Platform.isAndroid && isOwned;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Tilt(
                tiltConfig: TiltConfig(
                  enableGestureTouch: !(Platform.isAndroid || Platform.isIOS),
                ),
                lightConfig: const LightConfig(disable: true),
                shadowConfig: const ShadowConfig(disable: true),
                childLayout: ChildLayout(
                  outer: [
                    Positioned.fill(
                      top: context.height / 2.2,
                      child: TiltParallax(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                info.translatedName,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: const Color.fromARGB(
                                        255,
                                        49,
                                        70,
                                        121,
                                      ),
                                    ),
                              ),
                              Gaps.h20,
                              Text(
                                info.enDangerLevelName(l10n),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: const Color.fromARGB(
                                        255,
                                        49,
                                        70,
                                        121,
                                      ),
                                    ),
                              ),
                              Gaps.h12,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${l10n.endangeredLevel}：',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: const Color.fromARGB(
                                            255,
                                            49,
                                            70,
                                            121,
                                          ),
                                        ),
                                  ),
                                  ...info.endangerStars,
                                ],
                              ),
                              Text(
                                info.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: const Color.fromARGB(
                                        255,
                                        49,
                                        70,
                                        121,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 100,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: double.maxFinite,
                          height: context.height / 3,
                          child: TiltParallax(
                            size: const Offset(30, 30),
                            child: Padding(
                              padding: const EdgeInsets.all(Spacings.px20),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: ImageFiltered(
                                                  imageFilter: ImageFilter.blur(
                                                    sigmaX: 10,
                                                    sigmaY: 10,
                                                  ),
                                                  child: LayoutBuilder(
                                                    builder:
                                                        (context, constraints) {
                                                      return CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl: info.image,
                                                        color: isOwned
                                                            ? null
                                                            : Colors.black
                                                                .withOpacity(1),
                                                        colorBlendMode:
                                                            BlendMode.color,
                                                        width: constraints
                                                            .maxWidth,
                                                        placeholder: (
                                                          context,
                                                          url,
                                                        ) =>
                                                            const ColoredBox(
                                                          color: Colors.white,
                                                        ),
                                                        errorWidget: (
                                                          context,
                                                          url,
                                                          error,
                                                        ) =>
                                                            const Icon(
                                                          Icons.error,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: CachedNetworkImage(
                                                fit: BoxFit.contain,
                                                imageUrl: info.image,
                                                color: isOwned
                                                    ? null
                                                    : Colors.black
                                                        .withOpacity(1),
                                                colorBlendMode: BlendMode.color,
                                                placeholder: (context, url) =>
                                                    const ColoredBox(
                                                  color: Colors.white,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                child: Container(
                  height: 360,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              top: context.height / 1.5,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  if (showGoogleWallet) ...[
                    AddToGoogleWalletButton(
                      pass: ref
                          .read(googleWalletControllerProvider.notifier)
                          .getPassJson(
                        header: info.translatedName,
                        subHeader: l10n.endangeredSpecies,
                        endangeredLevel: info.level,
                        logoImageUrl: info.image,
                        heroImageUrl: info.image,
                        properties: [
                          GoogleWalletPassProperty(
                            id: 'endangered_species',
                            header: l10n.endangeredLevel,
                            body: info.level,
                          ),
                        ],
                      ),
                      onSuccess: () {},
                      onCanceled: () {},
                      onError: (Object error) {},
                    ),
                    Gaps.h20,
                  ],
                  if (canNavigateSpeciesPage)
                    DefaultButton(
                      text: l10n.myEndangeredSpeciesAlbum,
                      onPressed: () =>
                          context.push(EndangeredSpeciesCardsPage.routePath),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
