import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_fonts.dart';

/// The app's theme, matching the Fintech App UI design (dark, lime accent,
/// Instrument Serif headings + Manrope body).
///
/// Usage in main.dart:
///
/// ```dart
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///   AppTheme.applySystemUiOverlay();
///   runApp(MaterialApp(theme: AppTheme.darkTheme, home: const HomeScreen()));
/// }
/// ```
class AppTheme {
  AppTheme._();

  /// Status bar and Android navigation bar colours.
  /// The design is dark, so the icons must be LIGHT (white).
  static const SystemUiOverlayStyle systemUiOverlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // Android: white icons
    statusBarBrightness: Brightness.dark, // iOS: white icons (dark bar)
    systemNavigationBarColor: AppColors.background,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: false,
  );

  /// Call once in main(), before runApp().
  static void applySystemUiOverlay() {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlay);
  }

  static final ThemeData darkTheme = _buildDarkTheme();

  static ThemeData _buildDarkTheme() {
    final textTheme = buildTextTheme(AppColors.text, AppColors.textMuted);

    const colorScheme = ColorScheme.dark(
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      secondary: AppColors.accent,
      onSecondary: AppColors.onAccent,
      error: AppColors.error,
      onError: AppColors.onAccent,
      surface: AppColors.surface,
      onSurface: AppColors.text,
      surfaceContainerLowest: AppColors.background,
      surfaceContainerLow: AppColors.background,
      surfaceContainer: AppColors.surface,
      surfaceContainerHigh: AppColors.surface2,
      surfaceContainerHighest: AppColors.surface2,
      onSurfaceVariant: AppColors.textMuted,
      outline: AppColors.border,
      outlineVariant: AppColors.divider,
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusButton),
    );

    OutlineInputBorder inputBorder(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusInput),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      primaryColor: AppColors.accent,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      dividerColor: AppColors.divider,
      fontFamily: AppFonts.defaultFont,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: const IconThemeData(color: AppColors.text, size: 22),
      primaryIconTheme: const IconThemeData(color: AppColors.text, size: 22),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      // ── App bar: same colour as the screen, no shadow ──────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.text),
        titleTextStyle: textTheme.titleLarge,
        systemOverlayStyle: systemUiOverlay,
      ),

      // ── Buttons ────────────────────────────────────────────────────
      // Primary action (Continue, Send, Log in): lime, 56 px tall.
      // For a full-width button wrap it: SizedBox(width: double.infinity, child: ...)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          disabledBackgroundColor: AppColors.surface2,
          disabledForegroundColor: AppColors.textMuted,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(64, AppDimens.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
          shape: buttonShape,
          textStyle: textTheme.labelLarge,
        ),
      ),

      // Secondary action (I already have an account, Share): outlined.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.text,
          disabledForegroundColor: AppColors.textMuted,
          side: const BorderSide(color: AppColors.border),
          minimumSize: const Size(64, AppDimens.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
          shape: buttonShape,
          textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      // Text links (See all, Forgot password?): lime text.
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          minimumSize: const Size(48, AppDimens.minTouchTarget),
          textStyle: textTheme.labelMedium?.copyWith(fontSize: 14),
        ),
      ),

      // ── Text fields ────────────────────────────────────────────────
      // The design puts the label ABOVE the field as normal Text, and uses
      // hintText inside the field.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.lg,
          vertical: AppDimens.lg,
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(color: AppColors.hint),
        labelStyle: textTheme.bodySmall,
        helperStyle: textTheme.bodySmall,
        errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.error),
        prefixIconColor: AppColors.textMuted,
        suffixIconColor: AppColors.textMuted,
        border: inputBorder(AppColors.border),
        enabledBorder: inputBorder(AppColors.border),
        focusedBorder: inputBorder(AppColors.accent, 1.5),
        errorBorder: inputBorder(AppColors.error),
        focusedErrorBorder: inputBorder(AppColors.error, 1.5),
        disabledBorder: inputBorder(AppColors.divider),
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.accent,
        selectionColor: Color(0x55D4F25A), // accent at ~33%
        selectionHandleColor: AppColors.accent,
      ),

      // ── Cards (balance card, summary cards, list groups) ──────────
      cardTheme: CardThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusCard),
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      // ── Bottom navigation (Home / History / Saved / Profile) ───────
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: Colors.transparent, // the design shows colour only
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 22,
            color: states.contains(WidgetState.selected)
                ? AppColors.accent
                : AppColors.textMuted,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontFamily: AppFonts.defaultFont,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: states.contains(WidgetState.selected)
                ? AppColors.accent
                : AppColors.textMuted,
          ),
        ),
      ),

      // ── Chips (filters: All / Money in / Money out, quick amounts) ─
      chipTheme: ChipThemeData(
        color: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.accent
              : Colors.transparent,
        ),
        side: WidgetStateBorderSide.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? BorderSide.none
              : const BorderSide(color: AppColors.border),
        ),
        shape: const StadiumBorder(),
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.md,
          vertical: AppDimens.sm,
        ),
        labelStyle: TextStyle(
          fontFamily: AppFonts.defaultFont,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          // Dark text on the lime selected chip, light text otherwise.
          color: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.onAccent
                : AppColors.text,
          ),
        ),
      ),

      // ── Switch ("Save as beneficiary") ─────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.onAccent
              : AppColors.textMuted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.accent
              : AppColors.surface2,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Colors.transparent
              : AppColors.border,
        ),
      ),

      // ── Lists, dividers ────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        iconColor: AppColors.text,
        textColor: AppColors.text,
        titleTextStyle: textTheme.titleSmall,
        subtitleTextStyle: textTheme.bodySmall,
        leadingAndTrailingTextStyle: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.lg),
        minVerticalPadding: AppDimens.md,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ── Pop-ups ────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface2,
        contentTextStyle: textTheme.bodyMedium,
        actionTextColor: AppColors.accent,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusInput),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        modalBackgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: AppColors.border,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimens.radiusSheet),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusSheet),
        ),
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textMuted,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
        linearTrackColor: AppColors.surface2,
        circularTrackColor: AppColors.surface2,
      ),
    );
  }
}

/// Text styles used across the app.
///
/// display*  / headline*  → Instrument Serif (big headings, money amounts)
/// title* / body* / label* → Manrope (everything else)
///
/// Example: `Text('₦4,300.00', style: Theme.of(context).textTheme.displayMedium)`
TextTheme buildTextTheme(Color fontColor, Color mutedColor) {
  TextStyle serif(double size, double height) => TextStyle(
        fontFamily: AppFonts.displayFont,
        fontSize: size,
        height: height,
        fontWeight: FontWeight.w400,
        letterSpacing: size >= 40 ? -0.5 : 0,
        color: fontColor,
      );

  TextStyle sans(double size, FontWeight weight, double height,
          [Color? color]) =>
      TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color ?? fontColor,
      );

  return TextTheme(
    /// Display — big serif numbers and hero titles
    displayLarge: serif(76, 1.0), // amount you type (Send / Fund)
    displayMedium: serif(54, 1.05), // wallet balance on Home
    displaySmall: serif(48, 1.02), // onboarding titles, "Money sent"

    /// Headline — serif screen titles
    headlineLarge: serif(40, 1.05), // "History", "Saved", "Create your account"
    headlineMedium: serif(32, 1.1), // profile name
    headlineSmall: serif(28, 1.15), // "Recent", summary amounts, dialog titles

    /// Title — Manrope, semibold
    titleLarge: sans(18, FontWeight.w600, 1.3), // app bar title
    titleMedium: sans(16, FontWeight.w600, 1.4), // card titles, recipient name
    titleSmall: sans(15, FontWeight.w600, 1.4), // list item titles

    /// Body — Manrope, regular
    bodyLarge: sans(16, FontWeight.w400, 1.5), // paragraphs, field text
    bodyMedium: sans(14, FontWeight.w400, 1.45), // normal text
    bodySmall: sans(13, FontWeight.w400, 1.4, mutedColor), // dates, captions, field labels

    /// Label — buttons, chips, small caps headers
    labelLarge: sans(16, FontWeight.w700, 1.2), // button text
    labelMedium: sans(13, FontWeight.w600, 1.3), // chips, small buttons
    labelSmall: sans(12, FontWeight.w700, 1.3, mutedColor).copyWith(
      letterSpacing: 1.0, // "ACCOUNT", "SECURITY" section headers (use .toUpperCase())
    ),
  );
}
