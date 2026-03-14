import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/paper_model.dart';

final bookmarkProvider =
    StateNotifierProvider<BookmarkNotifier, List<PaperModel>>(
  (ref) => BookmarkNotifier(),
);

class BookmarkNotifier extends StateNotifier<List<PaperModel>> {
  BookmarkNotifier() : super([]);

  void toggle(PaperModel paper) {
    if (isBookmarked(paper.id)) {
      state = state.where((p) => p.id != paper.id).toList();
    } else {
      state = [...state, paper];
    }
  }

  bool isBookmarked(String paperId) => state.any((p) => p.id == paperId);

  void clearAll() => state = [];
}
