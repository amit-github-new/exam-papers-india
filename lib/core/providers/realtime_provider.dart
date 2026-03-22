import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/supabase_service.dart';

/// Streams INSERT events from the `papers` table via Supabase Realtime.
/// Waits for Supabase to be initialized before subscribing.
final newPaperStreamProvider = StreamProvider.autoDispose<Map<String, dynamic>>(
  (ref) async* {
    // Wait until Supabase is initialized before touching the client.
    await supabaseReadyFuture;

    final client     = ref.read(supabaseClientProvider);
    final controller = StreamController<Map<String, dynamic>>.broadcast();

    final channel = client
        .channel('public:papers')
        .onPostgresChanges(
          event:    PostgresChangeEvent.insert,
          schema:   'public',
          table:    'papers',
          callback: (payload) => controller.add(payload.newRecord),
        )
        .subscribe();

    ref.onDispose(() {
      client.removeChannel(channel);
      controller.close();
    });

    yield* controller.stream;
  },
);
