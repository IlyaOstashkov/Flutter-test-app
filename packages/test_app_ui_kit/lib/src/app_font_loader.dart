import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class AppFonts {
  static const roboto = 'Roboto';
  static const sFUIDisplay = '.SF UI Display';
  static const sFUIText = '.SF UI Text';
  static const sFProDisplay = 'SF Pro Display';
  static const sFProText = 'SF Pro Text';
}

class AppFontsLoader {
  static const List<String> _appFonts = [
    AppFonts.roboto,
    AppFonts.sFUIDisplay,
    AppFonts.sFUIText,
    AppFonts.sFProText,
    AppFonts.sFProDisplay,
  ];

  static Future<void> load() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final fontManifest = await rootBundle.loadStructuredData<Iterable<dynamic>>(
      'FontManifest.json',
      (string) async => json.decode(string),
    );
    for (final Map<String, dynamic> font in fontManifest) {
      final fontLoader = FontLoader(_derivedFontFamily(font));
      for (final Map<String, dynamic> fontType in font['fonts']) {
        fontLoader.addFont(rootBundle.load(fontType['asset']));
      }
      await fontLoader.load();
    }
  }

  static String _derivedFontFamily(Map<String, dynamic> fontDefinition) {
    final String fontFamily = fontDefinition['family'];
    if (_appFonts.contains(fontFamily)) return fontFamily;
    if (fontFamily.startsWith('packages/')) {
      if (_appFonts.any(fontFamily.contains)) {
        return fontFamily.split('/').last;
      }
    } else {
      for (final Map<String, dynamic> fontType in fontDefinition['fonts']) {
        final String asset = fontType['asset'];
        if (asset.startsWith('packages')) {
          final packageName = asset.split('/')[1];
          return 'packages/$packageName/$fontFamily';
        }
      }
    }
    return fontFamily;
  }
}
