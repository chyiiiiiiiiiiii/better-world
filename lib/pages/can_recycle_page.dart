import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:envawareness/controllers/can_recycle_controller.dart';
import 'package:envawareness/dialogs/showing.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/pages/catch_game_page.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
import 'package:envawareness/utils/recycle_icon.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_io/io.dart';

class GeminiImagePage extends ConsumerStatefulWidget {
  const GeminiImagePage({required this.isElectron, super.key});
  static const canRecycleRoutePath = '/can-recycle-page';
  static const electronRoutePath = '/electron-page';

  final bool isElectron;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GeminiImagePageState();
}

class _GeminiImagePageState extends ConsumerState<GeminiImagePage> {
  late AppLocalizations l10n = context.l10n;

  Future<void> getImage() async {
    final picker = ImagePicker();

    try {
      final pickImageWay = await showPickImageDialog();

      if (!mounted) {
        return;
      }

      final imageWidth = min(
        context.width * 1.5,
        800,
      );

      XFile? image;

      if (pickImageWay == 'Camera') {
        image = await picker.pickImage(
          source: ImageSource.camera,
          maxWidth: imageWidth.toDouble(),
        );
      } else if (pickImageWay == 'Gallery') {
        image = await picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: imageWidth.toDouble(),
        );
      } else {
        return;
      }

      final bytes = await image?.readAsBytes();
      if (bytes == null && mounted) {
        return;
      } else {
        await ref
            .read(canRecycleControllerProvider.notifier)
            .checkRecyclable(bytes!, isElectron: widget.isElectron);
      }
    } catch (error) {
      if (!context.mounted) {
        return;
      }

      await showMessageDialog<void>(
        context,
        message: l10n.canRecyclePermissionOrImageError,
        onConfirm: AppSettings.openAppSettings,
      );
    }
  }

  Future<String?> showPickImageDialog() {
    return showGeneralDialog<String?>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Pick image',
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return ScaleTransition(
          scale: animation,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.pickImageMessage,
                        style: context.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      Gaps.h20,
                      Row(
                        children: [
                          if (!kIsWeb || !Platform.isMacOS)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, 'Camera');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_rounded,
                                      color: context.colorScheme.primary,
                                    ),
                                    Gaps.w4,
                                    Text(
                                      l10n.pickImageCamera,
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(
                                        color: context.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, 'Gallery');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo,
                                    color: context.colorScheme.secondary,
                                  ),
                                  Gaps.w4,
                                  Text(
                                    l10n.pickImageAlbum,
                                    style:
                                        context.textTheme.titleLarge?.copyWith(
                                      color: context.colorScheme.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(canRecycleControllerProvider);
    final isLoading = asyncState.isLoading;

    final pickedImage = asyncState.value?.pickedImage ?? Uint8List(0);
    final hasAiResponse = (asyncState.value?.aiResponse ?? '').isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: context.paddingTop == 0 ? Spacings.px20 : 0,
              left: Spacings.px20,
              right: Spacings.px20,
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.isElectron
                            ? 'assets/images/game_icon/electron.png'
                            : 'assets/images/game_icon/recyclable.png',
                        fit: BoxFit.contain,
                        width: 80,
                      ),
                      Gaps.h20,
                      if (pickedImage.isEmpty)
                        Text(
                          widget.isElectron
                              ? l10n.electronGameText
                              : l10n.canRecycleGameText,
                          style: context.theme.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      AnimatedSize(
                        duration: Durations.short4,
                        child: AspectRatio(
                          aspectRatio: pickedImage.isEmpty ? 1 / 0.1 : 1 / 0.7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Spacings.px20),
                            child: pickedImage.isNotEmpty
                                ? Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned.fill(
                                        child: Image.memory(
                                          pickedImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (isLoading)
                                        const CircularProgressIndicator(),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ),
                      Gaps.h12,
                      asyncState.when(
                        data: (data) {
                          return Column(
                            children: [
                              if (hasAiResponse) ...[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                context.colorScheme.secondary,
                                            borderRadius: BorderRadius.circular(
                                              Spacings.px20,
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              data.aiResponse,
                                              style: context
                                                  .theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Gaps.w20,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const RecycleIcon(
                                            size: 24,
                                          ),
                                          Gaps.w8,
                                          Text(
                                            data.addScore.toString(),
                                            style: context
                                                .theme.textTheme.headlineLarge,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Gaps.h16,
                              ],
                              DefaultButton(
                                onPressed: getImage,
                                text: hasAiResponse
                                    ? l10n.canRecycleGameNext
                                    : l10n.canRecycleGameShoot,
                              ),
                            ],
                          );
                        },
                        loading: () => const SizedBox.shrink(),
                        error: (error, _) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                l10n.canRecycleGameError,
                                style: context.theme.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.h24,
                            Center(
                              child: DefaultButton(
                                onPressed: getImage,
                                text: l10n.canRecycleGameTryAgain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.h12,
                    ],
                  ),
                ),
                const AppCloseButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
