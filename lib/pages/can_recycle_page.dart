import 'package:envawareness/controllers/can_recycle_controller.dart';
import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/button.dart';
import 'package:envawareness/utils/gaps.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Can it be recycled?',
              style: context.theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Gaps.h12,
            result.when(
              data: (data) => Column(
                children: [
                  if (data.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data,
                        style: context.theme.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Gaps.h24,
                  Center(
                    child: DefaultButton(
                      onPressed: getImage,
                      text: data.isEmpty ? 'upload trash photo' : 'Try again',
                    ),
                  ),
                ],
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, _) => Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Sorry, we couldn't process the image. Please try again.",
                      style: context.theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.h24,
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
    );
  }
}
