// theme_web.dart
import 'dart:html' as html;

void changeThemeColor({required bool isDark}) {
  const lightColor = '#F9EFDC';
  const darkColor = '#1a1a1a';
  final color = isDark ? darkColor : lightColor;

  var themeColorMeta = html.querySelector('meta[name="theme-color"]');
  if (themeColorMeta != null) {
    // 正確地設置 content 屬性
    (themeColorMeta as html.MetaElement).content = color;
  } else {
    // 如果不存在，則創建一個新的 meta 標籤並設置 content
    themeColorMeta = html.MetaElement()
      ..name = 'theme-color'
      ..content = color;
    html.document.head!.append(themeColorMeta);
  }
}
