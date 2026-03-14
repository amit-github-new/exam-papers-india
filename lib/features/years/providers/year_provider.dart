import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/year_model.dart';
import '../repositories/year_repository.dart';
// import '../repositories/supabase_year_repository.dart'; // uncomment for Supabase
// import '../../../services/supabase_service.dart';       // uncomment for Supabase

/// Repository provider — using mock data for testing.
final yearRepositoryProvider = Provider<IYearRepository>((ref) {
  return const YearRepository(); // mock
  // final client = ref.watch(supabaseClientProvider);
  // return SupabaseYearRepository(client);
});

/// Family provider keyed by [examId] with in-memory caching.
final yearsProvider =
    FutureProvider.autoDispose.family<List<YearModel>, String>(
  (ref, examId) async {
    ref.keepAlive();
    return ref.watch(yearRepositoryProvider).getYears(examId);
  },
);
