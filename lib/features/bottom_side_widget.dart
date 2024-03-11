import 'package:envawareness/features/play/play_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/endangered_species_cards_page.dart';
import 'package:envawareness/pages/leader_board_page.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:envawareness/zdogs/dash_zdog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zflutter/zflutter.dart';

class BottomSideWidget extends ConsumerWidget {
  const BottomSideWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final isStoreOpened = ref.watch(isStoreOpenedProvider);

    if (isStoreOpened) {
      return Center(
        child: DefaultButton(
          onPressed: ref.read(playControllerProvider.notifier).onStoreTap,
          text: l10n.leave,
        ),
      )
          .animate(
            key: const Key('close'),
            delay: Durations.extralong4,
          )
          .fade();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTap(
          onTap: () {
            showDialog<void>(
              context: context,
              barrierColor: Colors.transparent,
              builder: (
                BuildContext context,
              ) {
                return const LeaderBoardPage();
              },
            );
          },
          child: SizedBox(
            width: 48,
            height: 48,
            child: Image.asset('assets/images/game_icon/leader_board.png'),
          ),
        ),
        Gaps.w32,
        AppTap(
          onTap: () {
            ref.read(playControllerProvider.notifier).onStoreTap();
          },
          child: Image.asset(
            'assets/images/game_icon/store.png',
            width: 48,
            height: 48,
          ),
        ),
        Gaps.w32,
        AppTap(
          onTap: () {
            context.push(EndangeredSpeciesCardsPage.routePath);
          },
          child: SizedBox(
            width: 48,
            height: 48,
            child: ZIllustration(
              children: const [
                DashZdog(
                  translate: ZVector(0, 0, 100),
                  useAnimation: false,
                ),
              ],
            ),
          ),
        ),
      ],
    )
        .animate(
          key: const Key('open'),
          delay: Durations.extralong4,
        )
        .fadeIn();
  }
}

class CrownZdog extends StatelessWidget {
  const CrownZdog({
    super.key,
    this.translate = const ZVector.only(),
  });
  final ZVector translate;

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      translate: translate,
      child: ZGroup(
        children: [
          ZShape(
            path: [
              ZMove.only(y: -10),
              ZLine.only(x: -10, y: 5),
              ZLine.only(
                x: -20,
              ),
              ZLine.only(x: -20, y: 10),
              ZLine.only(x: -20, y: 20),
              ZLine.only(x: 20, y: 20),
              ZLine.only(x: 20),
              ZLine.only(x: 10, y: 5),
            ],
            // closed by default
            stroke: 5,
            fill: true,
            color: const Color.fromARGB(255, 246, 191, 54),
          ),
          ZPositioned(
            translate: const ZVector.only(y: 10),
            child: ZShape(
              stroke: 10,
              color: const Color.fromARGB(255, 205, 65, 44),
            ),
          ),
        ],
      ),
    );
  }
}
