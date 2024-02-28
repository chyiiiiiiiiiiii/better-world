import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:envawareness/constants/endangered_specise_data.dart';
import 'package:envawareness/data/endangered_species_info.dart';
import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class EndangeredSpeciesCardsPage extends ConsumerWidget {
  const EndangeredSpeciesCardsPage({super.key});

  static const routePath = '/endangered-species-cards';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final playInfo = ref.watch(playControllerProvider).requireValue.playInfo;
    final ownedCardCount = playInfo.ownedAnimalCardIndexes.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.endangeredSpecies),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: endangeredSpeciesList.length,
          itemBuilder: (context, index) {
            final species = endangeredSpeciesList[index];
            final isOwned = playInfo.ownedAnimalCardIndexes.contains(index);

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
                              color:
                                  isOwned ? null : Colors.black.withOpacity(1),
                              colorBlendMode: BlendMode.color,
                              // placeholder: (context, url) => const Center(
                              //   child: CircularProgressIndicator(),
                              // ),
                              memCacheHeight: constraints.maxHeight.toInt(),
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
    );
  }
}

Future<void> showSpeciesCardDialog(
  BuildContext context, {
  required EndangeredSpeciesInfo info,
  bool isOwned = true,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return SpeciesCard(
        isOwned: isOwned,
        info: info,
      );
    },
  );
}

class SpeciesCard extends StatelessWidget {
  const SpeciesCard({
    required this.isOwned,
    required this.info,
    super.key,
  });
  final bool isOwned;
  final EndangeredSpeciesInfo info;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Tilt(
          lightConfig: const LightConfig(disable: true),
          shadowConfig: const ShadowConfig(disable: true),
          childLayout: ChildLayout(
            outer: [
              Positioned.fill(
                top: 480,
                child: TiltParallax(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          '${l10n.endangeredLevel}：${info.level}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: const Color.fromARGB(255, 49, 70, 121),
                              ),
                        ),
                        Text(
                          info.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: const Color.fromARGB(255, 49, 70, 121),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 440,
                child: TiltParallax(
                  child: Text(
                    info.translatedName,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: const Color.fromARGB(255, 49, 70, 121),
                        ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 40,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 400,
                    child: TiltParallax(
                      size: const Offset(30, 30),
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: info.image,
                                color: isOwned
                                    ? null
                                    : Colors.black.withOpacity(1),
                                colorBlendMode: BlendMode.color,
                                // placeholder: (context, url) => const Center(
                                //   child: CircularProgressIndicator(),
                                // ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                memCacheHeight: constraints.maxHeight.toInt(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
