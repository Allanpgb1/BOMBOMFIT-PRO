import '../services/supabase_service.dart';

class StepsRepository {
  Future<int> today() async {
    final client = SupabaseService.client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return 0;

    final day = DateTime.now().toIso8601String().substring(0, 10);
    final row = await client
        .from('daily_activity')
        .select('steps')
        .eq('user_id', user.id)
        .eq('activity_date', day)
        .maybeSingle();

    return (row?['steps'] as num?)?.toInt() ?? 0;
  }

  Future<void> saveToday(int steps) async {
    final client = SupabaseService.client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return;

    final day = DateTime.now().toIso8601String().substring(0, 10);
    await client.from('daily_activity').upsert({
      'user_id': user.id,
      'activity_date': day,
      'steps': steps,
    });
  }
}
