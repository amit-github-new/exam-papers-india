import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _initCompleter = Completer<void>();

/// Call once after Supabase.initialize() finishes (success or failure).
/// All data providers await this before touching the client.
void markSupabaseReady() {
  if (!_initCompleter.isCompleted) _initCompleter.complete();
}

/// Resolves the moment Supabase is initialized — awaited by every data provider.
Future<void> get supabaseReadyFuture => _initCompleter.future;

/// Single Riverpod provider for the Supabase client.
final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);
