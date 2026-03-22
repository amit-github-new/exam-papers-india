import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/cache_service.dart';
import '../../../core/utils/icon_mapper.dart';
import '../../../models/category_model.dart';
import 'category_repository.dart';

/// Live Supabase implementation of [ICategoryRepository] with offline cache.
///
/// Expected table: `categories`
/// Columns: id TEXT, exam_id TEXT, name TEXT, description TEXT,
///          icon_name TEXT, paper_count INTEGER
class SupabaseCategoryRepository implements ICategoryRepository {
  static const String _table = 'categories';

  final SupabaseClient _client;
  const SupabaseCategoryRepository(this._client);

  @override
  Future<List<CategoryModel>> getCategories(String examId, int year) async {
    try {
      // Step 1: find which categories have papers for this exam+year, with live count
      final paperRows = await _client
          .from('papers')
          .select('category_id, category_name, pdf_url')
          .eq('exam_id', examId)
          .eq('year', year);

      final papers = paperRows as List<dynamic>;
      if (papers.isEmpty) return [];

      final categoryIds = <String>{};
      final countMap = <String, int>{};
      for (final row in papers) {
        final id = row['category_id'] as String;
        categoryIds.add(id);
        if (row['pdf_url'] != null) {
          countMap[id] = (countMap[id] ?? 0) + 1;
        }
      }

      // Step 2: fetch full category details for only those IDs
      final rows = await _client
          .from(_table)
          .select()
          .inFilter('id', categoryIds.toList())
          .order('name', ascending: true);

      final result = <CategoryModel>[];
      final cacheRows = <Map<String, dynamic>>[];

      for (final row in rows as List<dynamic>) {
        final r = row as Map<String, dynamic>;
        final id = r['id'] as String;
        final iconName = r['icon_name'] as String?;
        final count = countMap[id] ?? 0;

        result.add(CategoryModel(
          id:          id,
          name:        r['name'] as String,
          examId:      r['exam_id'] as String,
          icon:        IconMapper.get(iconName),
          description: r['description'] as String? ?? '',
          paperCount:  count,
        ));

        cacheRows.add({...r, 'paper_count': count});
      }

      await CacheService.saveCategories(examId, year, cacheRows);
      return result;
    } catch (_) {
      final cached = await CacheService.loadCategories(examId, year);
      if (cached != null) {
        return cached.map((r) {
          return CategoryModel(
            id:          r['id'] as String,
            name:        r['name'] as String,
            examId:      r['exam_id'] as String,
            icon:        IconMapper.get(r['icon_name'] as String?),
            description: r['description'] as String? ?? '',
            paperCount:  r['paper_count'] as int? ?? 0,
          );
        }).toList();
      }
      rethrow;
    }
  }
}
