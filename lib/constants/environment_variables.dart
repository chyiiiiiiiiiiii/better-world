import 'package:flutter/material.dart';

@immutable
final class EnvironmentVariables {
  const EnvironmentVariables._();

  static const googleAiStudioApiKey = String.fromEnvironment('AI_API_KEY');
}
