import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight local cache backed by shared_preferences.
///
/// Keys:
///   cache_exams                          → List<ExamRow>  (includes icon_name)
///   cache_years_{examId}                 → List<YearRow>
///   cache_categories_{examId}_{year}     → List<CategoryRow> (includes icon_name)
///   cache_papers_{examId}_{year}_{catId} → List<PaperRow>
class CacheService {
  static const _examsKey        = 'cache_exams';
  static const _yearsPrefix     = 'cache_years_';
  static const _categoriesPrefix = 'cache_categories_';
  static const _papersPrefix    = 'cache_papers_';

  // ── Exams ─────────────────────────────────────────────────────────────────

  static Future<void> saveExams(List<Map<String, dynamic>> rows) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_examsKey, jsonEncode(rows));
  }

  static Future<List<Map<String, dynamic>>?> loadExams() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_examsKey);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  // ── Years ─────────────────────────────────────────────────────────────────

  static Future<void> saveYears(
    String examId,
    List<Map<String, dynamic>> rows,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_yearsPrefix$examId', jsonEncode(rows));
  }

  static Future<List<Map<String, dynamic>>?> loadYears(String examId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_yearsPrefix$examId');
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  // ── Categories ────────────────────────────────────────────────────────────

  static Future<void> saveCategories(
    String examId,
    int year,
    List<Map<String, dynamic>> rows,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_categoriesPrefix${examId}_$year', jsonEncode(rows));
  }

  static Future<List<Map<String, dynamic>>?> loadCategories(
    String examId,
    int year,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_categoriesPrefix${examId}_$year');
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  // ── Papers ────────────────────────────────────────────────────────────────

  static Future<void> savePapers(
    String examId,
    int year,
    String categoryId,
    List<Map<String, dynamic>> rows,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_papersPrefix${examId}_${year}_$categoryId',
      jsonEncode(rows),
    );
  }

  static Future<List<Map<String, dynamic>>?> loadPapers(
    String examId,
    int year,
    String categoryId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_papersPrefix${examId}_${year}_$categoryId');
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }
}
