import '../../../core/constants/app_constants.dart';
import '../../../models/exam_model.dart';
import '../../../services/mock_data_service.dart';

/// Contract — swap implementation for SupabaseExamRepository when ready.
abstract class IExamRepository {
  Future<List<ExamModel>> getExams();
}

/// Mock implementation backed by [MockDataService].
class ExamRepository implements IExamRepository {
  const ExamRepository();

  @override
  Future<List<ExamModel>> getExams() async {
    await Future.delayed(AppConstants.mockDelay);
    return MockDataService.exams;
  }
}

// ── TODO: Supabase implementation (uncomment & wire when ready) ───────────────
//
// class SupabaseExamRepository implements IExamRepository {
//   final SupabaseClient _client;
//   const SupabaseExamRepository(this._client);
//
//   @override
//   Future<List<ExamModel>> getExams() async {
//     final rows = await _client.from('exams').select().order('name');
//     return rows.map((r) => ExamModel.fromJson(r, icon: _iconFor(r['id']))).toList();
//   }
//
//   IconData _iconFor(String id) { ... }
// }
