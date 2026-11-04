/// Spacing, corner radius and size values from the design.
///
/// Example: `const SizedBox(height: AppDimens.lg)`,
///          `BorderRadius.circular(AppDimens.radiusCard)`.
class AppDimens {
  AppDimens._();

  // ── Spacing ──────────────────────────────────────────────────────
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  /// Left/right padding of a screen.
  static const double screenPadding = 24;

  // ── Corner radius ────────────────────────────────────────────────
  static const double radiusInput = 14;
  static const double radiusButton = 16;
  static const double radiusCard = 20;
  static const double radiusSheet = 24;

  /// Fully rounded (chips, pills, avatars).
  static const double radiusPill = 999;

  // ── Sizes ────────────────────────────────────────────────────────
  static const double buttonHeight = 56;
  static const double inputHeight = 52;

  /// Smallest comfortable tap area.
  static const double minTouchTarget = 48;
}
