import 'package:flutter/material.dart';

/// Every colour in the app, taken from the Fintech App UI design.
///
/// Use these names instead of typing hex codes in widgets, so the whole
/// app can be re-coloured from this one file.
class AppColors {
  AppColors._(); // only static members, never create an instance

  // ── Backgrounds (darkest → lightest) ─────────────────────────────
  /// Screen background (Scaffold).
  static const Color background = Color(0xFF0E0F0C);

  /// Cards, text fields, list groups, bottom sheets.
  static const Color surface = Color(0xFF1A1B17);

  /// Things that sit ON a card: avatars, icon tiles, selected chips.
  static const Color surface2 = Color(0xFF24261F);

  // ── Lines ────────────────────────────────────────────────────────
  /// Borders around cards, fields and outlined buttons.
  static const Color border = Color(0xFF2E3029);

  /// Thin lines between list rows.
  static const Color divider = Color(0xFF24261F);

  /// Empty PIN dots, inactive page dots.
  static const Color inactive = Color(0xFF4A4C43);

  // ── Text ─────────────────────────────────────────────────────────
  /// Main text.
  static const Color text = Color(0xFFF2F1EC);

  /// Secondary text: labels, dates, captions.
  static const Color textMuted = Color(0xFFA3A39A);

  /// Placeholder (hint) text inside empty fields.
  static const Color hint = Color(0xFF9A9A90);

  // ── Brand ────────────────────────────────────────────────────────
  /// The lime accent: primary buttons, active tab, money coming in.
  static const Color accent = Color(0xFFD4F25A);

  /// Text and icons placed ON the accent colour (dark, for contrast).
  static const Color onAccent = Color(0xFF0E0F0C);

  // ── Status ───────────────────────────────────────────────────────
  /// Error text and error borders (e.g. "Incorrect PIN").
  static const Color error = Color(0xFFFF8A7A);

  /// Background of an error banner.
  static const Color errorSurface = Color(0xFF2A1714);

  /// Border of an error banner / log-out button.
  static const Color errorBorder = Color(0xFF5C2A22);

  // ── Money ────────────────────────────────────────────────────────
  /// Amount colour for money IN, e.g. "+₦300.00".
  static const Color credit = accent;

  /// Amount colour for money OUT, e.g. "−₦1,000.00".
  /// Credit and debit also differ by the + / − sign, not colour alone.
  static const Color debit = text;
}
