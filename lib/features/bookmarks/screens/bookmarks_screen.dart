import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/widgets/app_empty_widget.dart';
import '../../../models/paper_model.dart';
import '../providers/bookmark_provider.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarkProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
        ),
        actions: [
          if (bookmarks.isNotEmpty)
            TextButton(
              onPressed: () => _confirmClearAll(context, ref),
              child: Text(
                'Clear All',
                style: TextStyle(color: cs.error),
              ),
            ),
          const SizedBox(width: 4),
        ],
      ),
      body: bookmarks.isEmpty
          ? const AppEmptyWidget(
              title: 'No Bookmarks Yet',
              subtitle:
                  'Bookmark question papers from any exam\nto access them quickly here.',
              icon: Icons.bookmark_border_rounded,
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final paper = bookmarks[index];
                return _BookmarkTile(paper: paper);
              },
            ),
    );
  }

  Future<void> _confirmClearAll(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Bookmarks'),
        content: const Text(
            'Are you sure you want to remove all bookmarks? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Clear All',
                style:
                    TextStyle(color: Theme.of(ctx).colorScheme.error)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(bookmarkProvider.notifier).clearAll();
    }
  }
}

class _BookmarkTile extends ConsumerWidget {
  final PaperModel paper;
  const _BookmarkTile({required this.paper});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outlineVariant),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── PDF icon ─────────────────────────────────────────────
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.picture_as_pdf_rounded,
                color: cs.primary,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            // ── Info ─────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paper.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    paper.categoryName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: paper.pdfUrl != null
                              ? () => context.pushNamed(
                                    AppRoutes.viewer,
                                    queryParameters: {
                                      'url': paper.pdfUrl!,
                                      'title': paper.title,
                                    },
                                  )
                              : null,
                          icon: const Icon(Icons.open_in_new_rounded, size: 15),
                          label: const Text('Open'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Remove bookmark ─────────────────────────────────────
            IconButton(
              onPressed: () =>
                  ref.read(bookmarkProvider.notifier).toggle(paper),
              icon: Icon(Icons.bookmark_rounded, color: cs.primary),
              tooltip: 'Remove bookmark',
            ),
          ],
        ),
      ),
    );
  }
}
