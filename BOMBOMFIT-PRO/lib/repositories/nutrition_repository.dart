import 'dart:convert';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class NutritionRepository {
  Future<List<Map<String, dynamic>>> today() async {
    final email = await AuthService().currentUser;
    if (email == null) return [];
    final prefs = await LocalStorageService.prefs();
    final key = '${LocalStorageService.nutritionKey}_${LocalStorageService.userPrefix(email)}';
    final raw = prefs.getStringList(key) ?? [];
    final day = DateTime.now().toIso8601String().substring(0, 10);
    return raw.map((s) => jsonDecode(s) as Map<String, dynamic>)
      .where((e) => e['log_date'] == day)
      .toList()
      .reversed
      .toList();
  }

  Future<void> add({
    required String meal,
    required int calories,
    required double protein,
    required double carbs,
    required double fat,
  }) async {
    final email = await AuthService().currentUser;
    if (email == null) return;
    final prefs = await LocalStorageService.prefs();
    final key = '${LocalStorageService.nutritionKey}_${LocalStorageService.userPrefix(email)}';
    final entries = prefs.getStringList(key) ?? [];
    entries.add(jsonEncode({
      'id': DateTime.now().microsecondsSinceEpoch.toString(),
      'log_date': DateTime.now().toIso8601String().substring(0, 10),
      'meal': meal,
      'calories': calories,
      'protein_g': protein,
      'carbs_g': carbs,
      'fat_g': fat,
    }));
    await prefs.setStringList(key, entries);
  }
}
