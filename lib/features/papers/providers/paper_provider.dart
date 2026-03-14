import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/paper_model.dart';
import '../repositories/paper_repository.dart';
// import '../repositories/supabase_paper_repository.dart'; // uncomment for Supabase
// import '../../../services/supabase_service.dart';        // uncomment for Supabase

/// Repository provider — using mock data for testing.
final paperRepositoryProvider = Provider<IPaperRepository>((ref) {
  return const PaperRepository(); // mock
  // final client = ref.watch(supabaseClientProvider);
  // return SupabasePaperRepository(client);
});

/// Family provider keyed by [PaperParams] with in-memory caching.
final papersProvider =
    FutureProvider.autoDispose.family<List<PaperModel>, PaperParams>(
  (ref, params) async {
    ref.keepAlive();
    return ref.watch(paperRepositoryProvider).getPapers(params);
  },
);
