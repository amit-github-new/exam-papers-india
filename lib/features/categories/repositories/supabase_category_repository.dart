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
  Future<List<CategoryModel>> getCategories(String examId) async {
    final rows = await _client
        .from(_table)
        .select()
        .eq('exam_id', examId)
        .order('name', ascending: true);

    return (rows as List<dynamic>).map((row) {
      final r = row as Map<String, dynamic>;
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
}
