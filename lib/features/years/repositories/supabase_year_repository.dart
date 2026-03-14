import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../models/year_model.dart';
import 'year_repository.dart';

/// Live Supabase implementation of [IYearRepository].
///
/// Expected table: `exam_years`
/// Columns: id SERIAL, exam_id TEXT, year INTEGER,
///          paper_count INTEGER, is_latest BOOLEAN
class SupabaseYearRepository implements IYearRepository {
  static const String _table = 'exam_years';

  final SupabaseClient _client;
  const SupabaseYearRepository(this._client);

  @override
  Future<List<YearModel>> getYears(String examId) async {
    final rows = await _client
        .from(_table)
        .select()
        .eq('exam_id', examId)
        .order('year', ascending: false);

    return (rows as List<dynamic>).map((row) {
      final r = row as Map<String, dynamic>;
      return YearModel(
        year:       r['year'] as int,
        examId:     r['exam_id'] as String,
        paperCount: r['paper_count'] as int? ?? 0,
        isLatest:   r['is_latest'] as bool? ?? false,
      );
    }).toList();
  }
}
