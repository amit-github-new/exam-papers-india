import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Single Riverpod provider for the Supabase client.
/// All Supabase repositories consume this — never call
/// [Supabase.instance.client] directly elsewhere.
final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);
