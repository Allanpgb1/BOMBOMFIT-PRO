import 'dart:convert';
import '../models/water_entry.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class WaterRepository {
  Future<List<WaterEntry>> today() async {
    final email = await AuthService().currentUser;
    if (email == null) return [];
    final prefs = await LocalStorageService.prefs();
    final key = '${LocalStorageService.waterKey}_${LocalStorageService.userPrefix(email)}';
    final raw = prefs.getStringList(key) ?? [];
    final today = DateTime.now();
    return raw.map((s) => WaterEntry.fromMap(jsonDecode(s) as Map<String, dynamic>))
      .where((e) => e.consumedAt.year == today.year && e.consumedAt.month == today.month && e.consumedAt.day == today.day)
      .toList()
      ..sort((a, b) => b.consumedAt.compareTo(a.consumedAt));
  }

  Future<void> add(int amountMl) async {
    final email = await AuthService().currentUser;
    if (email == null) throw StateError('Usuário não autenticado.');
    final prefs = await LocalStorageService.prefs();
    final key = '${LocalStorageService.waterKey}_${LocalStorageService.userPrefix(email)}';
    final entries = prefs.getStringList(key) ?? [];
    entries.add(jsonEncode({
      'id': DateTime.now().microsecondsSinceEpoch.toString(),
      'consumed_at': DateTime.now().toIso8601String(),
      'amount_ml': amountMl,
    }));
    await prefs.setStringList(key, entries);
  }
}
