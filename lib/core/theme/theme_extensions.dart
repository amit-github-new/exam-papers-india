import 'package:flutter/material.dart';

/// BuildContext shortcuts for theme-aware colours.
/// Use these in widgets instead of raw [AppColors] constants so that
/// dark-mode and light-mode both look correct.
extension ThemeContextX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  ThemeData get theme => Theme.of(this);
  ColorScheme get cs => Theme.of(this).colorScheme;

  // ── Backgrounds ────────────────────────────────────────────────────────────
  Color get bgColor =>
      isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);

  // ── Surfaces ───────────────────────────────────────────────────────────────
  Color get surfaceColor => cs.surface;
  Color get surfaceVariantColor => cs.surfaceContainerHighest;

  // ── Borders ────────────────────────────────────────────────────────────────
  Color get borderColor => cs.outlineVariant;

  // ── Brand ──────────────────────────────────────────────────────────────────
  Color get primaryColor => cs.primary;
  Color get primaryContainerColor => cs.primaryContainer;
  Color get onPrimaryContainerColor => cs.onPrimaryContainer;

  // ── Text ───────────────────────────────────────────────────────────────────
  Color get textPrimary => cs.onSurface;
  Color get textSecondary => cs.onSurfaceVariant;
  Color get textTertiary =>
      isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

  // ── Semantic ───────────────────────────────────────────────────────────────
  Color get successColor =>
      isDark ? const Color(0xFF34D399) : const Color(0xFF10B981);
  Color get successContainerColor =>
      isDark ? const Color(0xFF064E3B) : const Color(0xFFD1FAE5);
  Color get errorContainerColor => cs.errorContainer;
}
