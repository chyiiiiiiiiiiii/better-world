import 'dart:typed_data';
import 'dart:ui';

import 'package:envawareness/controllers/can_recycle_controller.dart';
import 'package:envawareness/l10n/app_localizations_extension.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
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
  Future<void> getImage() async {
    final picker = ImagePicker();
    var picerRes = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Use camera or gallery?'),
          content: const Text('Please select a source'),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Camera'),
                  child: const Text('Camera'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Gallery'),
                  child: const Text('Gallery'),
                ),
              ],
            ),
          ],
        );
      },
    );
    XFile? image;
    picerRes = picerRes?.toString();
    if (picerRes == 'Camera') {
      image = await picker.pickImage(source: ImageSource.camera, maxWidth: 300);
    } else if (picerRes == 'Gallery') {
      image = await picker.pickImage(source: ImageSource.gallery);
    } else {
      return;
    }
// Capture a photo.
    // final photo = await picker.pickImage(source: ImageSource.camera);
    final bytes = await image?.readAsBytes();
    if (bytes == null && mounted) {
      await showDialog<void>(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('No image selected'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    } else {
      await ref
          .read(canRecycleControllerProvider.notifier)
          .checkRecyclable(bytes!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final asyncState = ref.watch(canRecycleControllerProvider);
    final isLoading = asyncState.isLoading;

    final pickedImage = asyncState.value?.pickedImage ?? Uint8List(0);
    final hasAiResponse = (asyncState.value?.aiResponse ?? '').isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacings.px20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.canRecycleGameText,
                style: context.theme.textTheme.headlineMedium,
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
                          child: Text(
                            data.aiResponse,
                            style: context.theme.textTheme.titleMedium,
                            textAlign: TextAlign.center,
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
              Gaps.h84,
            ],
          ),
        ),
      ),
    );
  }
}
