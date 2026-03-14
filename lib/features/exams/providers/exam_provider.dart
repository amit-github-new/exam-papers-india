import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/exam_model.dart';
import '../repositories/exam_repository.dart';
// import '../repositories/supabase_exam_repository.dart'; // uncomment for Supabase
// import '../../../services/supabase_service.dart';       // uncomment for Supabase

/// Repository provider — using mock data for testing.
/// To switch to Supabase: uncomment imports above and swap the return value.
final examRepositoryProvider = Provider<IExamRepository>((ref) {
  return const ExamRepository(); // mock
  // final client = ref.watch(supabaseClientProvider);
  // return SupabaseExamRepository(client);
});

/// Exam list provider with in-memory caching via [keepAlive].
final examsProvider = FutureProvider.autoDispose<List<ExamModel>>((ref) async {
  ref.keepAlive();
  return ref.watch(examRepositoryProvider).getExams();
});
