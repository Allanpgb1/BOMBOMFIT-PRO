import '../models/water_entry.dart';
import '../services/supabase_service.dart';

class WaterRepository {
  Future<List<WaterEntry>> today() async {
    final client = SupabaseService.client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return [];

    final start = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final data = await client
        .from('water_entries')
        .select()
        .eq('user_id', user.id)
        .gte('consumed_at', start.toIso8601String())
        .order('consumed_at', ascending: false);

    return (data as List)
        .map((e) => WaterEntry.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> add(int amountMl) async {
    final client = SupabaseService.client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) throw StateError('Usuário não autenticado.');
    await client.from('water_entries').insert({
      'user_id': user.id,
      'amount_ml': amountMl,
    });
  }
}
