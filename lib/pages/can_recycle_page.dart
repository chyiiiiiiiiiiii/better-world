import 'dart:typed_data';
import 'dart:ui';

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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CanRecyclePage extends ConsumerStatefulWidget {
  const CanRecyclePage({super.key});
  static const routePath = '/can-recycle-page';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CanRecyclePageState();
}

class _CanRecyclePageState extends ConsumerState<CanRecyclePage> {
  late AppLocalizations l10n = context.l10n;

  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickImageWay = await showPickImageDialog();

    if (!mounted) {
      return;
    }

    final imageWidth = context.width * 1.5;

    XFile? image;
    try {
      if (pickImageWay == 'Camera') {
        image = await picker.pickImage(
          source: ImageSource.camera,
          maxWidth: imageWidth,
        );
      } else if (pickImageWay == 'Gallery') {
        image = await picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: imageWidth,
        );
      } else {
        return;
      }
    } catch (error) {
      if (!context.mounted) {
        return;
      }

      await showMessageDialog<void>(
        context,
        message: '請先將裝置的相機或相簿的權限開啟，才能提供照片哦！',
        onConfirm: AppSettings.openAppSettings,
      );
    }

    final bytes = await image?.readAsBytes();
    if (bytes == null && mounted) {
      return;
    } else {
      await ref
          .read(canRecycleControllerProvider.notifier)
          .checkRecyclable(bytes!);
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
                                style: context.textTheme.titleLarge?.copyWith(
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
                                style: context.textTheme.titleLarge?.copyWith(
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: context.paddingTop,
                left: Spacings.px20,
                right: Spacings.px20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (pickedImage.isEmpty)
                    Text(
                      l10n.canRecycleGameText,
                      style: context.theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: pickedImage.isEmpty ? 0 : Spacings.px20,
                    ),
                    child: AnimatedSize(
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
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                          sigmaX: isLoading ? 5 : 0,
                                          sigmaY: isLoading ? 5 : 0,
                                        ),
                                        child: Image.memory(
                                          pickedImage,
                                          fit: BoxFit.cover,
                                        ),
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
                  ),
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
                                        color: context.colorScheme.secondary,
                                        borderRadius: BorderRadius.circular(8),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                            Gaps.h24,
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
                ],
              ),
            ),
            const AppCloseButton(),
          ],
        ),
      ),
    );
  }
}
