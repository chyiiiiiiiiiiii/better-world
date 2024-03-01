import 'dart:typed_data';

import 'package:envawareness/controllers/can_recycle_controller.dart';
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
          .canRecycleThis(bytes!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(canRecycleControllerProvider);
    final pickedImage = result.value?.pickedImage ?? Uint8List(0);

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
                'Can it be recycled?',
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
                          ? Image.memory(
                              pickedImage,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
              result.when(
                data: (data) {
                  final hasResponse = data.aiResponse.isNotEmpty;
                  return Column(
                    children: [
                      if (hasResponse) ...[
                        Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              data.aiResponse,
                              style: context.theme.textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Gaps.h24,
                      ],
                      DefaultButton(
                        onPressed: getImage,
                        text: !hasResponse ? 'upload trash photo' : 'Try again',
                      ),
                    ],
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Column(
                  children: [
                    Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Sorry, we couldn't process the image. Please try again.",
                          style: context.theme.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Gaps.h20,
                    Center(
                      child: DefaultButton(
                        onPressed: getImage,
                        text: 'Try again',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
