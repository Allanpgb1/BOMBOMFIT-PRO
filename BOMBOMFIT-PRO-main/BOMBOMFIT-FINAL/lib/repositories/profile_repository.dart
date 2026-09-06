import 'dart:convert';
import '../models/profile.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class ProfileRepository {
  Future<Profile?> getCurrent() async {
    final email = await AuthService().currentUser;
    if (email == null) return null;
    final prefs = await LocalStorageService.prefs();
    final raw = prefs.getString('${LocalStorageService.profileKey}_${LocalStorageService.userPrefix(email)}');
    if (raw == null) return null;
    return Profile.fromMap(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> upsert(Profile profile) async {
    final email = await AuthService().currentUser;
    if (email == null) throw StateError('Usuário não autenticado.');
    final prefs = await LocalStorageService.prefs();
    await prefs.setString(
      '${LocalStorageService.profileKey}_${LocalStorageService.userPrefix(email)}',
      jsonEncode(profile.toMap()),
    );
  }
}
