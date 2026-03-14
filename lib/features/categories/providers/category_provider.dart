import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/category_model.dart';
import '../repositories/category_repository.dart';
import '../repositories/supabase_category_repository.dart';
import '../../../services/supabase_service.dart';

/// Immutable key: only show categories that have papers for this exam+year.
class CategoryParams {
  final String examId;
  final int year;

  const CategoryParams({required this.examId, required this.year});

  @override
  bool operator ==(Object other) =>
      other is CategoryParams &&
      other.examId == examId &&
      other.year == year;

  @override
  int get hashCode => Object.hash(examId, year);

  @override
  String toString() => 'CategoryParams($examId, $year)';
}

final categoryRepositoryProvider = Provider<ICategoryRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseCategoryRepository(client);
});

/// Returns only categories that have ≥1 paper for the given exam+year,
/// with live paper count for that year.
final categoriesProvider =
    FutureProvider.autoDispose.family<List<CategoryModel>, CategoryParams>(
  (ref, params) async {
    ref.keepAlive();
    return ref
        .watch(categoryRepositoryProvider)
        .getCategories(params.examId, params.year);
  },
);
