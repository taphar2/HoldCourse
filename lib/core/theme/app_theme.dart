import 'package:material_ui/material_ui.dart';

/// Colour and typography tokens shared by every screen.
///
/// Screens must read colours from `Theme.of(context)`, never from hardcoded
/// values, so light/dark and the planned high-contrast mode keep working.
abstract final class AppTheme {
  /// Seed used to derive both colour schemes.
  static const Color seed = Color(0xFF2563EB);

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );

    return ThemeData(colorScheme: scheme);
  }
}
