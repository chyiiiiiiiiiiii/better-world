import 'package:envawareness/utils/build_context_extension.dart';
import 'package:envawareness/utils/spacings.dart';
import 'package:envawareness/widgets/app_tap.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required this.onPressed,
    required this.text,
    this.textStyle,
    super.key,
  });
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return AppTap(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(Spacings.px64),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Spacings.px8),
          child: Text(
            text,
            style: textStyle ??
                context.textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
