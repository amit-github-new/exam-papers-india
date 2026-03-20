import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Master switch — flip to true when the app reaches ~10k downloads.
const bool _adsEnabled = false;

class AdsConfig {
  AdsConfig._();

  static const bool enabled = _adsEnabled;

  // Use Google's test IDs during development, real IDs in release.
  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712' // Google test ID
          : 'ca-app-pub-3940256099942544/4411468910';
    }
    return 'ca-app-pub-1253282534825140/6803807648'; // Production
  }
}

class AdService {
  static InterstitialAd? _interstitialAd;
  static bool _isLoading = false;

  /// Call once at app startup to initialise the SDK.
  static Future<void> initialize() async {
    if (!AdsConfig.enabled) return;
    await MobileAds.instance.initialize();
    _loadInterstitial();
  }

  static void _loadInterstitial() {
    if (!AdsConfig.enabled || _isLoading) return;
    _isLoading = true;

    InterstitialAd.load(
      adUnitId: AdsConfig.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoading = false;
          ad.setImmersiveMode(true);
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          debugPrint('AdService: interstitial failed to load: $error');
        },
      ),
    );
  }

  /// Show the interstitial if ready, then reload for next time.
  /// [onDone] is always called — whether the ad was shown or not.
  static Future<void> showInterstitial({required VoidCallback onDone}) async {
    if (!AdsConfig.enabled || _interstitialAd == null) {
      onDone();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitial(); // Preload for next time
        onDone();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitial();
        onDone();
      },
    );

    await _interstitialAd!.show();
  }
}
