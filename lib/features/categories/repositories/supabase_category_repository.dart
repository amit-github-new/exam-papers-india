import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/icon_mapper.dart';
import '../../../models/category_model.dart';
import 'category_repository.dart';

/// Live Supabase implementation of [ICategoryRepository].
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
    // Step 1: find which categories have papers for this exam+year, with live count
    final paperRows = await _client
        .from('papers')
        .select('category_id, category_name')
        .eq('exam_id', examId)
        .eq('year', year);

    final papers = paperRows as List<dynamic>;
    if (papers.isEmpty) return [];

    // Build category_id → count map
    final countMap = <String, int>{};
    for (final row in papers) {
      final id = row['category_id'] as String;
      countMap[id] = (countMap[id] ?? 0) + 1;
    }

    // Step 2: fetch full category details for only those IDs
    final rows = await _client
        .from(_table)
        .select()
        .inFilter('id', countMap.keys.toList())
        .order('name', ascending: true);

    return (rows as List<dynamic>).map((row) {
      final r = row as Map<String, dynamic>;
      final id = r['id'] as String;
      return CategoryModel(
        id:          id,
        name:        r['name'] as String,
        examId:      r['exam_id'] as String,
        icon:        IconMapper.get(r['icon_name'] as String?),
        description: r['description'] as String? ?? '',
        paperCount:  countMap[id] ?? 0,  // live count for this year
      );
    }).toList();
  }
}
