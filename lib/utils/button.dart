import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 121, 224, 119),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}
