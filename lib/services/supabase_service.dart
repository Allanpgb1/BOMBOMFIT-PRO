import 'package:supabase_flutter/supabase_flutter.dart';
class SupabaseService {
  static Future<void> initialize({
    required String url,
    required String publishableKey,
  }) async {
    if (url.isEmpty || publishableKey.isEmpty) {
      return;
    }
    await Supabase.initialize(
      url: url,
      publishableKey: publishableKey,
    );
  }
  static SupabaseClient? get client {
    try {
      return Supabase.instance.client;
    } catch (_) {
      return null;
    }
  }
}