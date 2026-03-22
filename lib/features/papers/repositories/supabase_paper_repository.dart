import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/cache_service.dart';
import '../../../models/paper_model.dart';
import 'paper_repository.dart';

/// Live Supabase implementation of [IPaperRepository] with offline cache.
///
/// Schema: papers table uses year_id (UUID FK → exam_years) and file_url.
/// We resolve year_id from the year integer, then join categories for name.
const _storageBase =
    'https://hsvgjgnfrtufrfswwoeu.supabase.co/storage/v1/object/public/papers/';

class SupabasePaperRepository implements IPaperRepository {
  final SupabaseClient _client;
  const SupabasePaperRepository(this._client);

  @override
  Future<List<PaperModel>> getPapers(PaperParams params) async {
    try {
      final rows = await _client
          .from('papers')
          .select()
          .eq('exam_id', params.examId)
          .eq('year', params.year)
          .eq('category_id', params.categoryId)
          .order('created_at', ascending: true);

      final result = <PaperModel>[];
      final cacheRows = <Map<String, dynamic>>[];

      for (final row in rows as List<dynamic>) {
        final r = row as Map<String, dynamic>;
        final model = PaperModel(
          id:              r['id'] as String,
          title:           (r['title'] as String).replaceAll(RegExp(r'\s*\([^)]*\)'), '').trim(),
          examId:          r['exam_id'] as String,
          year:            r['year'] as int,
          categoryId:      r['category_id'] as String,
          categoryName:    r['category_name'] as String? ?? '',
          pdfUrl:          (r['pdf_url'] as String?) ?? '$_storageBase${r['id']}.pdf',
          downloadUrl:     r['download_url'] as String?,
          fileSizeMb:      (r['file_size_mb'] as num?)?.toDouble(),
          language:        r['language'] as String?,
          totalQuestions:  r['total_questions'] as int?,
          totalMarks:      r['total_marks'] as int?,
          durationMinutes: r['duration_minutes'] as int?,
        );
        result.add(model);
        cacheRows.add(model.toJson());
      }

      await CacheService.savePapers(
        params.examId,
        params.year,
        params.categoryId,
        cacheRows,
      );
      return result;
    } catch (_) {
      final cached = await CacheService.loadPapers(
        params.examId,
        params.year,
        params.categoryId,
      );
      if (cached != null) {
        return cached.map(PaperModel.fromJson).toList();
      }
      rethrow;
    }
  }
}
