// theme_manager.dart
export 'package:envawareness/utils/change_theme_manager.dart'
    // Use `theme_web.dart` if the target platform is the web
    if (dart.library.html) 'package:envawareness/utils/change_web_theme.dart';

class ThemeManager {
  static void changeThemeColor({required bool isDark}) {
    changeThemeColor(isDark: isDark);
  }
}
