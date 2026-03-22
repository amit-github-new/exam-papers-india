import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/cache_service.dart';
import '../../../models/year_model.dart';
import 'year_repository.dart';

/// Live Supabase implementation of [IYearRepository] with offline cache.
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
    try {
      final yearRows = await _client
          .from(_table)
          .select()
          .eq('exam_id', examId)
          .order('year', ascending: false);

      final rows = yearRows as List<dynamic>;
      if (rows.isEmpty) return [];

      // Live paper count per year from papers table
      final years = rows.map((r) => (r as Map<String, dynamic>)['year'] as int).toList();
      final paperRows = await _client
          .from('papers')
          .select('year')
          .eq('exam_id', examId)
          .inFilter('year', years)
          .not('category_id', 'ilike', '%notification%')
          .not('pdf_url', 'is', null);

      final countMap = <int, int>{};
      for (final row in paperRows as List<dynamic>) {
        final y = (row as Map<String, dynamic>)['year'] as int;
        countMap[y] = (countMap[y] ?? 0) + 1;
      }

      final result = <YearModel>[];
      final cacheRows = <Map<String, dynamic>>[];

      for (final row in rows) {
        final r = row as Map<String, dynamic>;
        final year = r['year'] as int;
        final count = countMap[year] ?? 0;

        result.add(YearModel(
          year:       year,
          examId:     r['exam_id'] as String,
          paperCount: count,
          isLatest:   r['is_latest'] as bool? ?? false,
        ));

        cacheRows.add({
          'year':        year,
          'exam_id':     r['exam_id'] as String,
          'paper_count': count,
          'is_latest':   r['is_latest'] as bool? ?? false,
        });
      }

      await CacheService.saveYears(examId, cacheRows);
      return result;
    } catch (_) {
      final cached = await CacheService.loadYears(examId);
      if (cached != null) {
        return cached.map(YearModel.fromJson).toList();
      }
      rethrow;
    }
  }
}
