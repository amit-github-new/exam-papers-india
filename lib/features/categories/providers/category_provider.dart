import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/category_model.dart';
import '../repositories/category_repository.dart';
// import '../repositories/supabase_category_repository.dart'; // uncomment for Supabase
// import '../../../services/supabase_service.dart';           // uncomment for Supabase

/// Repository provider — using mock data for testing.
final categoryRepositoryProvider = Provider<ICategoryRepository>((ref) {
  return const CategoryRepository(); // mock
  // final client = ref.watch(supabaseClientProvider);
  // return SupabaseCategoryRepository(client);
});

/// Family provider keyed by [examId] with in-memory caching.
final categoriesProvider =
    FutureProvider.autoDispose.family<List<CategoryModel>, String>(
  (ref, examId) async {
    ref.keepAlive();
    return ref.watch(categoryRepositoryProvider).getCategories(examId);
  },
);
