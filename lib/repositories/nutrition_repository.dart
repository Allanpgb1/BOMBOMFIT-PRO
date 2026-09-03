import '../services/supabase_service.dart';

class NutritionRepository {
  Future<List<Map<String, dynamic>>> today() async {
    final client = SupabaseService.client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return [];

    final day = DateTime.now().toIso8601String().substring(0, 10);
    final data = await client
        .from('nutrition_logs')
        .select()
        .eq('user_id', user.id)
        .eq('log_date', day)
        .order('created_at', ascending: false);
    return (data as List).map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> add({
    required String meal,
    required int calories,
    required double protein,
    required double carbs,
    required double fat,
  }) async {
    final client = SupabaseService.client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return;
    await client.from('nutrition_logs').insert({
      'user_id': user.id,
      'log_date': DateTime.now().toIso8601String().substring(0, 10),
      'meal': meal,
      'calories': calories,
      'protein_g': protein,
      'carbs_g': carbs,
      'fat_g': fat,
    });
  }
}
