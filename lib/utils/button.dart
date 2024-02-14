import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required this.onPressed,
    required this.text,
    super.key,
  });
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppTap(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 121, 224, 119),
          borderRadius: BorderRadius.circular(Spacings.px64),
        ),
        padding: const EdgeInsets.all(Spacings.px8),
        child: Text(
          text,
          style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
