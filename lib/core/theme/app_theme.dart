import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // ── Shared text theme (colour-agnostic — inherits from ColorScheme) ─────────
  static TextTheme _textTheme(ColorScheme cs) =>
      GoogleFonts.interTextTheme().copyWith(
        displayLarge:  GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700,  color: cs.onSurface,        letterSpacing: -0.5),
        displayMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700,  color: cs.onSurface,        letterSpacing: -0.5),
        headlineLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700,  color: cs.onSurface,        letterSpacing: -0.3),
        headlineMedium:GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700,  color: cs.onSurface,        letterSpacing: -0.2),
        headlineSmall: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600,  color: cs.onSurface),
        titleLarge:    GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600,  color: cs.onSurface),
        titleMedium:   GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600,  color: cs.onSurface),
        titleSmall:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,  color: cs.onSurface),
        bodyLarge:     GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400,  color: cs.onSurface),
        bodyMedium:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400,  color: cs.onSurfaceVariant),
        bodySmall:     GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400,  color: cs.onSurfaceVariant),
        labelLarge:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,  color: cs.primary,          letterSpacing: 0.1),
        labelMedium:   GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500,  color: cs.onSurfaceVariant, letterSpacing: 0.1),
        labelSmall:    GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500,  color: cs.onSurfaceVariant, letterSpacing: 0.2),
      );

  // ── Shared component themes ──────────────────────────────────────────────────
  static ThemeData _base(ColorScheme cs, Color scaffoldBg) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: _textTheme(cs),

      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: cs.surface,
        shadowColor: cs.outlineVariant,
        titleTextStyle: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w700, color: cs.onSurface),
        iconTheme:        IconThemeData(color: cs.onSurface,        size: 22),
        actionsIconTheme: IconThemeData(color: cs.onSurfaceVariant, size: 22),
      ),

      cardTheme: CardThemeData(
        color: cs.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: cs.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: BorderSide(color: cs.primary),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      dividerTheme: DividerThemeData(
        color: cs.outlineVariant,
        thickness: 1,
        space: 0,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: cs.surfaceContainerHighest,
        selectedColor: cs.primaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide.none,
        labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      ),

      iconTheme: IconThemeData(color: cs.onSurfaceVariant, size: 22),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: cs.inverseSurface,
        contentTextStyle: GoogleFonts.inter(
            fontSize: 14, color: cs.onInverseSurface),
      ),

      drawerTheme: DrawerThemeData(
        backgroundColor: cs.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? cs.primary : null),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? cs.primaryContainer
                : null),
      ),
    );
  }

  // ── Light theme ──────────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    const cs = ColorScheme(
      brightness: Brightness.light,
      primary:              AppColors.primary,
      onPrimary:            AppColors.onPrimary,
      primaryContainer:     AppColors.primaryContainer,
      onPrimaryContainer:   AppColors.onPrimaryContainer,
      secondary:            AppColors.secondary,
      onSecondary:          AppColors.onPrimary,
      secondaryContainer:   AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      error:                AppColors.error,
      onError:              AppColors.onPrimary,
      errorContainer:       AppColors.errorContainer,
      onErrorContainer:     AppColors.error,
      surface:              AppColors.surface,
      onSurface:            AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceVariant,
      onSurfaceVariant:     AppColors.textSecondary,
      outline:              AppColors.border,
      outlineVariant:       AppColors.borderLight,
      shadow:               Color(0xFF000000),
      scrim:                Color(0xFF000000),
      inverseSurface:       AppColors.textPrimary,
      onInverseSurface:     AppColors.surface,
      inversePrimary:       AppColors.primaryLight,
    );
    return _base(cs, AppColors.background);
  }

  // ── Dark theme ───────────────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    const cs = ColorScheme(
      brightness: Brightness.dark,
      primary:              Color(0xFF60A5FA), // Blue-400
      onPrimary:            Color(0xFF0F172A),
      primaryContainer:     Color(0xFF1D4ED8),
      onPrimaryContainer:   Color(0xFFDBEAFE),
      secondary:            Color(0xFFFBBF24),
      onSecondary:          Color(0xFF0F172A),
      secondaryContainer:   Color(0xFF92400E),
      onSecondaryContainer: Color(0xFFFEF3C7),
      error:                Color(0xFFF87171),
      onError:              Color(0xFF0F172A),
      errorContainer:       Color(0xFF7F1D1D),
      onErrorContainer:     Color(0xFFFECACA),
      surface:              Color(0xFF1E293B), // Slate-800
      onSurface:            Color(0xFFF1F5F9), // Slate-100
      surfaceContainerHighest: Color(0xFF334155), // Slate-700
      onSurfaceVariant:     Color(0xFF94A3B8), // Slate-400
      outline:              Color(0xFF475569), // Slate-600
      outlineVariant:       Color(0xFF334155), // Slate-700
      shadow:               Color(0xFF000000),
      scrim:                Color(0xFF000000),
      inverseSurface:       Color(0xFFF1F5F9),
      onInverseSurface:     Color(0xFF0F172A),
      inversePrimary:       Color(0xFF2563EB),
    );
    return _base(cs, const Color(0xFF0F172A));
  }
}
