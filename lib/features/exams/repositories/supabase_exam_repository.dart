import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/icon_mapper.dart';
import '../../../models/exam_model.dart';
import 'exam_repository.dart';

/// Live Supabase implementation of [IExamRepository].
///
/// Expected table: `exams`
/// Columns: id TEXT, name TEXT, short_name TEXT, description TEXT,
///          conducted_by TEXT, color_value INTEGER, icon_name TEXT,
///          total_papers INTEGER
class SupabaseExamRepository implements IExamRepository {
  static const String _table = 'exams';

  final SupabaseClient _client;
  const SupabaseExamRepository(this._client);

  @override
  Future<List<ExamModel>> getExams() async {
    final rows = await _client
        .from(_table)
        .select()
        .order('name', ascending: true);

    return (rows as List<dynamic>).map((row) {
      final r = row as Map<String, dynamic>;
      return ExamModel(
        id:          r['id'] as String,
        name:        r['name'] as String,
        shortName:   r['short_name'] as String,
        description: r['description'] as String? ?? '',
        conductedBy: r['conducted_by'] as String? ?? 'UPSC',
        icon:        IconMapper.get(r['icon_name'] as String?),
        color:       Color(r['color_value'] as int? ?? 0xFF2563EB),
        totalPapers: r['total_papers'] as int? ?? 0,
      );
    }).toList();
  }
}
