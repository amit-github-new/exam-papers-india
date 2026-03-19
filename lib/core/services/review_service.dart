import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  static const _keyPaperOpenCount = 'paper_open_count';
  static const _keyReviewRequested = 'review_requested';
  static const _triggerCount = 3;

  /// Call this every time the user opens a paper.
  /// Shows the in-app review dialog once the user has opened [_triggerCount] papers.
  static Future<void> onPaperOpened() async {
    final prefs = await SharedPreferences.getInstance();

    final alreadyRequested = prefs.getBool(_keyReviewRequested) ?? false;
    if (alreadyRequested) return;

    final count = (prefs.getInt(_keyPaperOpenCount) ?? 0) + 1;
    await prefs.setInt(_keyPaperOpenCount, count);

    if (count >= _triggerCount) {
      final inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
        await prefs.setBool(_keyReviewRequested, true);
      }
    }
  }
}
