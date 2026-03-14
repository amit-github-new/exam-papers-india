import 'package:flutter/material.dart';

/// Centralised colour palette — single source of truth.
/// All colours are defined here; never use raw [Color] literals elsewhere.
class AppColors {
  AppColors._();

  // ── Brand / Primary ───────────────────────────────────────────────────────
  static const Color primary          = Color(0xFF2563EB);
  static const Color primaryDark      = Color(0xFF1D4ED8);
  static const Color primaryLight     = Color(0xFF3B82F6);
  static const Color primaryContainer = Color(0xFFDBEAFE);
  static const Color onPrimary        = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF1E3A5F);

  // ── Secondary / Accent ────────────────────────────────────────────────────
  static const Color secondary          = Color(0xFFF59E0B);
  static const Color secondaryContainer = Color(0xFFFEF3C7);
  static const Color onSecondaryContainer = Color(0xFF78350F);

  // ── Backgrounds & Surfaces ────────────────────────────────────────────────
  static const Color background    = Color(0xFFF8FAFC);
  static const Color surface       = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color surfaceTint   = Color(0xFFEFF6FF);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary  = Color(0xFF94A3B8);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color success          = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color warning          = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color error            = Color(0xFFEF4444);
  static const Color errorContainer   = Color(0xFFFEE2E2);

  // ── Borders & Dividers ────────────────────────────────────────────────────
  static const Color border     = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color divider    = Color(0xFFE2E8F0);

  // ── Per-exam accent colours (index matches exam order in MockDataService) ──
  static const List<Color> examColors = [
    Color(0xFF2563EB), // UPSC           — Blue
    Color(0xFF7C3AED), // CDS            — Purple
    Color(0xFF059669), // Geo Scientist  — Emerald
    Color(0xFFDC2626), // CAPF           — Red
    Color(0xFFD97706), // NDA            — Amber
    Color(0xFF0891B2), // Eng. Services  — Cyan
  ];
}
